#!/bin/bash

args=("$@")

export RELEASE="solodev-dcx-aws"
export NAMESPACE="solodev-dcx"
export KUBECONFIG="eksconfig"
export DOMAINNAME="domain.com"
export DOMAINID="config"
export SECRET="BigSecret123"
export PASSWORD="password"
export DBPASSWORD="password"

#GET VALUES FROM CLOUDFORMATION OUTPUT OF EKS STACK
export CAData=""
export EKSEndpoint=""
export EKSName=""
export ControlPlaneProvisionRoleArn=""

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
    helm --kubeconfig $KUBECONFIG install --namespace ${NAMESPACE} --name ${NAME} charts/${RELEASE} --set solodev.cname=${DOMAINNAME} --set solodev.settings.appSecret=${SECRET} --set solodev.settings.appPassword=${PASSWORD} --set solodev.settings.dbPassword=${DBPASSWORD}
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
    helm --kubeconfig $KUBECONFIG repo update
    helm --kubeconfig $KUBECONFIG repo list
}

log(){
    POD="${args[1]}"
    kubectl --kubeconfig=$KUBECONFIG logs -f $POD
}

clean(){
    helm --kubeconfig $KUBECONFIG list --short --namespace ${NAMESPACE} | xargs -L1 helm delete
}

#INIT
init(){
    generateConfig
    helm --kubeconfig $KUBECONFIG init
    helm --kubeconfig $KUBECONFIG repo add charts 'https://raw.githubusercontent.com/techcto/charts/master/'
    rbac
    installDashboard
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