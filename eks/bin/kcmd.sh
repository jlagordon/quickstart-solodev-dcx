#!/bin/bash
args=("$@")

#Config
export KUBECONFIG="eksconfig"

#GET VALUES FROM CLOUDFORMATION OUTPUT OF EKS STACK
export CAData=""
export EKSEndpoint=""
export EKSName=""
export ControlPlaneProvisionRoleArn=""

#AWS
export Region="us-east-1"

#Solodev
export RELEASE="solodev-dcx-aws"
export NAMESPACE="solodev-dcx"
export SECRET="BigSecret123"
export PASSWORD="password"
export DBPASSWORD="password"

#ADMIN
proxy(){
    token
    kubectl --kubeconfig=$KUBECONFIG proxy
}

ls(){
    kubectl --kubeconfig=$KUBECONFIG get pods --all-namespaces   
}

install(){
    NAME="${args[1]}"
    helm --kubeconfig $KUBECONFIG install --namespace ${NAMESPACE} --name ${NAME} charts/${RELEASE} --set serviceAccountName='solodev-serviceaccount' --set solodev.settings.appSecret=${SECRET} --set solodev.settings.appPassword=${PASSWORD} --set solodev.settings.dbPassword=${DBPASSWORD}
}

delete(){
    NAME="${args[1]}"
    helm --kubeconfig $KUBECONFIG del --purge ${NAME}
    kubectl --kubeconfig $KUBECONFIG delete --namespace ${NAME} --all pvc
}

#UTILS
token(){
    kubectl --kubeconfig=$KUBECONFIG -n kube-system describe secret $(kubectl --kubeconfig=$KUBECONFIG -n kube-system get secret | grep eks-admin | awk '{print $1}')
}

update(){
    helm --kubeconfig $KUBECONFIG repo add charts 'https://raw.githubusercontent.com/techcto/charts/master/'
    helm --kubeconfig $KUBECONFIG repo update
    helm --kubeconfig $KUBECONFIG repo list
}

log(){
    POD="${args[1]}"
    kubectl --kubeconfig=$KUBECONFIG logs -f $POD
}

clean(){
    NAME="${args[1]}"
    kubectl --kubeconfig $KUBECONFIG delete --all daemonsets,replicasets,statefulsets,services,deployments,pods,rc,configmap --namespace=${NAME} --grace-period=0 --force
    kubectl --kubeconfig $KUBECONFIG delete --namespace ${NAME} --all pvc
}

#INIT
init(){
    generateConfig
    kubectl --kubeconfig $KUBECONFIG create namespace ${NAMESPACE} 
    helm --kubeconfig $KUBECONFIG init
    helm --kubeconfig $KUBECONFIG repo add charts 'https://raw.githubusercontent.com/techcto/charts/master/'
    rbac
}

generateConfig(){
    cat > ${KUBECONFIG} << EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${CAData}	
    server: ${EKSEndpoint}	
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
      - token
      - -i
      - ${EKSName}
      - -r
      - ${ControlPlaneProvisionRoleArn}
      command: aws-iam-authenticator
      env: null
EOF
}

rbac(){
    kubectl --kubeconfig=$KUBECONFIG create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts;
}

initServiceAccount(){
    kubectl --kubeconfig $KUBECONFIG create namespace ${NAMESPACE} 
    kubectl --kubeconfig $KUBECONFIG delete sa solodev-serviceaccount --namespace ${NAMESPACE}
    ISSUER_URL=$(aws eks describe-cluster --name ${EKSName} --region ${Region} --query cluster.identity.oidc.issuer --output text )
    echo $ISSUER_URL
    ISSUER_URL_WITHOUT_PROTOCOL=$(echo $ISSUER_URL | sed 's/https:\/\///g' )
    ISSUER_HOSTPATH=$(echo $ISSUER_URL_WITHOUT_PROTOCOL | sed "s/\/id.*//" )
    rm *.crt || echo "No files that match *.crt exist"
    ROOT_CA_FILENAME=$(openssl s_client -showcerts -connect $ISSUER_HOSTPATH:443 < /dev/null \
                        | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".crt"; print > out } END {print "cert"a".crt"}')
    ROOT_CA_FINGERPRINT=$(openssl x509 -fingerprint -noout -in $ROOT_CA_FILENAME \
                        | sed 's/://g' | sed 's/SHA1 Fingerprint=//')
    aws iam create-open-id-connect-provider \
                        --url $ISSUER_URL \
                        --thumbprint-list $ROOT_CA_FINGERPRINT \
                        --client-id-list sts.amazonaws.com \
                        --region ${Region} || echo "A provider for $ISSUER_URL already exists"
    ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    PROVIDER_ARN="arn:aws:iam::$ACCOUNT_ID:oidc-provider/$ISSUER_URL_WITHOUT_PROTOCOL"
    cat > trust-policy.json << EOF
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Principal": {
            "Federated": "${PROVIDER_ARN}"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
            "StringEquals": {
                "${ISSUER_URL_WITHOUT_PROTOCOL}:sub": "system:serviceaccount:${NAMESPACE}:solodev-serviceaccount"
            }
        }
    }]
}
EOF

    ROLE_NAME=solodev-usage
    aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://trust-policy.json
    cat > iam-policy.json << EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "aws-marketplace:RegisterUsage"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF

    POLICY_ARN=$(aws iam create-policy --policy-name AWSMarketplacePolicy --policy-document file://iam-policy.json --query Policy.Arn | sed 's/"//g')
    echo ${POLICY_ARN}
    aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN
    echo $ROLE_NAME
    applyServiceAccount $ROLE_NAME
}

applyServiceAccount(){
    if [ "$1" == "" ]; then
        ROLE_NAME="${args[1]}"
    else
        ROLE_NAME=$1
    fi
    echo "Role="$ROLE_NAME
    ROLE_ARN=$(aws iam get-role --role-name ${ROLE_NAME} --query Role.Arn --output text)
    kubectl --kubeconfig $KUBECONFIG create sa solodev-serviceaccount --namespace ${NAMESPACE}
    kubectl --kubeconfig $KUBECONFIG annotate sa solodev-serviceaccount eks.amazonaws.com/role-arn=$ROLE_ARN --namespace ${NAMESPACE}
    echo "Service Account Created: solodev-serviceaccount"
}

setServiceAccount(){
    SERVICE_ACCOUNT="${args[1]}"
    kubectl --kubeconfig $KUBECONFIG set serviceaccount deployment solodev-deployment ${SERVICE_ACCOUNT}
}

installDashboard(){
    #https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html
    kubectl --kubeconfig $KUBECONFIG apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
    kubectl --kubeconfig $KUBECONFIG apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml
    kubectl --kubeconfig $KUBECONFIG apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml
    kubectl --kubeconfig $KUBECONFIG apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml
    cat > eks-admin-service-account.yaml << EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: eks-admin
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: eks-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: eks-admin
  namespace: kube-system
EOF
    kubectl --kubeconfig $KUBECONFIG apply -f eks-admin-service-account.yaml
}


$*