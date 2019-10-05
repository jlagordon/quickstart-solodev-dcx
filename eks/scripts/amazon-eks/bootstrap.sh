#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

err_report() {
    echo "Exited with error on line $1"
}
trap 'err_report $LINENO' ERR

IFS=$'\n\t'

function print_help {
    echo "usage: $0 [options] <cluster-name>"
    echo "Bootstraps an instance into an EKS cluster"
    echo ""
    echo "-h,--help print this help"
    echo "--use-max-pods Sets --max-pods for the kubelet when true. (default: true)"
    echo "--b64-cluster-ca The base64 encoded cluster CA content. Only valid when used with --apiserver-endpoint. Bypasses calling \"aws eks describe-cluster\""
    echo "--apiserver-endpoint The EKS cluster API Server endpoint. Only valid when used with --b64-cluster-ca. Bypasses calling \"aws eks describe-cluster\""
    echo "--kubelet-extra-args Extra arguments to add to the kubelet. Useful for adding labels or taints."
}

POSITIONAL=()

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -h|--help)
            print_help
            exit 1
            ;;
        --use-max-pods)
            USE_MAX_PODS="$2"
            shift
            shift
            ;;
        --b64-cluster-ca)
            B64_CLUSTER_CA=$2
            shift
            shift
            ;;
        --apiserver-endpoint)
            APISERVER_ENDPOINT=$2
            shift
            shift
            ;;
        --kubelet-extra-args)
            KUBELET_EXTRA_ARGS=$2
            shift
            shift
            ;;
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
            ;;
    esac
done

set +u
set -- "${POSITIONAL[@]}" # restore positional parameters
CLUSTER_NAME="$1"
set -u

USE_MAX_PODS="${USE_MAX_PODS:-true}"
SOLODEV_NETWORK="${SOLODEV_NETWORK:-false}"
B64_CLUSTER_CA="${B64_CLUSTER_CA:-}"
APISERVER_ENDPOINT="${APISERVER_ENDPOINT:-}"
KUBELET_EXTRA_ARGS="${KUBELET_EXTRA_ARGS:-}"

if [ -z "$CLUSTER_NAME" ]; then
    echo "CLUSTER_NAME is not defined"
    exit  1
fi

ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
AWS_DEFAULT_REGION=$(echo $ZONE | awk '{print substr($0, 1, length($0)-1)}')

### kubelet kubeconfig

CA_CERTIFICATE_DIRECTORY=/etc/kubernetes/pki
CA_CERTIFICATE_FILE_PATH=$CA_CERTIFICATE_DIRECTORY/ca.crt
mkdir -p $CA_CERTIFICATE_DIRECTORY
if [[ -z "${B64_CLUSTER_CA}" ]] && [[ -z "${APISERVER_ENDPOINT}" ]]; then
    DESCRIBE_CLUSTER_RESULT="/tmp/describe_cluster_result.txt"
    aws eks describe-cluster \
        --region=${AWS_DEFAULT_REGION} \
        --name=${CLUSTER_NAME} \
        --output=text \
        --query 'cluster.{certificateAuthorityData: certificateAuthority.data, endpoint: endpoint}' > $DESCRIBE_CLUSTER_RESULT
    B64_CLUSTER_CA=$(cat $DESCRIBE_CLUSTER_RESULT | awk '{print $1}')
    APISERVER_ENDPOINT=$(cat $DESCRIBE_CLUSTER_RESULT | awk '{print $2}')
fi

echo $B64_CLUSTER_CA | base64 -d > $CA_CERTIFICATE_FILE_PATH

sed -i s,CLUSTER_NAME,$CLUSTER_NAME,g /var/lib/kubelet/kubeconfig
kubectl config \
    --kubeconfig /var/lib/kubelet/kubeconfig \
    set-cluster \
    kubernetes \
    --certificate-authority=/etc/kubernetes/pki/ca.crt \
    --server=$APISERVER_ENDPOINT

### kubelet.service configuration

MAC=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ -s | head -n 1)
CIDRS=$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$MAC/vpc-ipv4-cidr-blocks)
TEN_RANGE=$(echo $CIDRS | grep -c '^10\..*' || true )
DNS_CLUSTER_IP=10.100.0.10
if [[ "$TEN_RANGE" != "0" ]] ; then
    DNS_CLUSTER_IP=172.20.0.10;
fi

KUBELET_CONFIG=/etc/kubernetes/kubelet/kubelet-config.json
echo "$(jq .clusterDNS=[\"$DNS_CLUSTER_IP\"] $KUBELET_CONFIG)" > $KUBELET_CONFIG

INTERNAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
INSTANCE_TYPE=$(curl -s http://169.254.169.254/latest/meta-data/instance-type)

initCNI(){
    echo "Disable AWS CNI"
    kubectl --kubeconfig /var/lib/kubelet/kubeconfig delete ds aws-node -n kube-system
    echo "Reinstall AWS CNI"
    kubectl --kubeconfig=$KUBECONFIG set env ds aws-node -n kube-system AWS_VPC_K8S_CNI_EXTERNALSNAT=true
    echo "Install CNI Genie"
    kubectl --kubeconfig=$KUBECONFIG apply -f https://raw.githubusercontent.com/Huawei-PaaS/CNI-Genie/master/conf/1.8/genie-plugin.yaml
    #WEAVE
    initWeave
}

initWeave(){
    echo "Install Weave CNI"
    curl --location -o ./weave-net.yaml "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.IPALLOC_RANGE=192.168.0.0/16"
    kubectl --kubeconfig /var/lib/kubelet/kubeconfig apply -f weave-net.yaml
}

if [[ "$USE_MAX_PODS" = "true" ]]; then
    MAX_PODS_FILE="/etc/eks/eni-max-pods.txt"
    set +o pipefail
    MAX_PODS=$(grep $INSTANCE_TYPE $MAX_PODS_FILE | awk '{print $2}')
    set -o pipefail
    if [[ -n "$MAX_PODS" ]]; then
        echo "$(jq .maxPods=$MAX_PODS $KUBELET_CONFIG)" > $KUBELET_CONFIG
    else
        echo "No entry for $INSTANCE_TYPE in $MAX_PODS_FILE. Not setting max pods for kubelet"
        initCNI
    fi
fi

cat <<EOF > /etc/systemd/system/kubelet.service.d/10-kubelet-args.conf
[Service]
Environment='KUBELET_ARGS=--node-ip=$INTERNAL_IP --pod-infra-container-image=602401143452.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/eks/pause-amd64:3.1'
EOF

if [[ -n "$KUBELET_EXTRA_ARGS" ]]; then
    cat <<EOF > /etc/systemd/system/kubelet.service.d/30-kubelet-extra-args.conf
[Service]
Environment='KUBELET_EXTRA_ARGS=$KUBELET_EXTRA_ARGS'
EOF
fi

initServiceAccount(){
    ISSUER_URL=$(aws eks describe-cluster --name ${CLUSTER_NAME} --region ${AWS_DEFAULT_REGION} --query cluster.identity.oidc.issuer --output text )
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
                        --region ${AWS_DEFAULT_REGION} || echo "A provider for $ISSUER_URL already exists"
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

    ROLE_NAME=solodev-usage-${CLUSTER_NAME}
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

    POLICY_ARN=$(aws iam create-policy --policy-name AWSMarketplacePolicy-${CLUSTER_NAME} --policy-document file://iam-policy.json --query Policy.Arn | sed 's/"//g')
    echo ${POLICY_ARN}
    aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN
    echo $ROLE_NAME
    applyServiceAccount $ROLE_NAME
}

applyServiceAccount(){
    ROLE_NAME="${args[1]}"
    NAMESPACE="default"
    echo "Role="$ROLE_NAME
    ROLE_ARN=$(aws iam get-role --role-name ${ROLE_NAME} --query Role.Arn --output text)
    kubectl --kubeconfig /var/lib/kubelet/kubeconfig create sa solodev-serviceaccount --namespace ${NAMESPACE}
    kubectl --kubeconfig /var/lib/kubelet/kubeconfig annotate sa solodev-serviceaccount eks.amazonaws.com/role-arn=$ROLE_ARN --namespace ${NAMESPACE}
    echo "Service Account Created: solodev-serviceaccount"
}

initNetwork(){
    helm --kubeconfig /var/lib/kubelet/kubeconfig install --name nginx-ingress stable/nginx-ingress --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-type"=nlb --set controller.publishService.enabled=true,controller.stats.enabled=true,controller.metrics.enabled=true,controller.hostNetwork=true,controller.kind=DaemonSet

    helm --kubeconfig /var/lib/kubelet/kubeconfig install --name external-dns stable/external-dns --set logLevel=debug \
        --set policy=sync --set domainFilters={${DOMAIN}} --set rbac.create=true \
        --set aws.zoneType=public --set txtOwnerId=${OWNERID} 
        # --set controller.hostNetwork=true,controller.kind=DaemonSet
}

if [[ "$SOLODEV_NETWORK" = "true" ]]; then
    initServiceAccount
    initNetwork
fi

systemctl daemon-reload
systemctl enable kubelet
systemctl start kubelet
