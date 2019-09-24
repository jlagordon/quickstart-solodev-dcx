#!/bin/bash
args=("$@")

export EKSName=""
export Region="us-east-1"

initServiceAccount(){
    eksctl utils associate-iam-oidc-provider --region=${Region} --name=${EKSName} --approve
    echo "aws eks describe-cluster --name ${EKSName} --region ${Region} --query cluster.identity.oidc.issuer --output text"
    ISSUER_URL=$(aws eks describe-cluster --name ${EKSName} --region ${Region} --query cluster.identity.oidc.issuer --output text )
    echo $ISSUER_URL
    ISSUER_URL_WITHOUT_PROTOCOL=$(echo $ISSUER_URL | sed 's/https:\/\///g' )
    ISSUER_HOSTPATH=$(echo $ISSUER_URL_WITHOUT_PROTOCOL | sed "s/\/id.*//" )
    echo $ISSUER_URL
    ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    PROVIDER_ARN="arn:aws:iam::$ACCOUNT_ID:oidc-provider/$ISSUER_HOSTPATH"
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
                "${ISSUER_HOSTPATH}:sub": "system:serviceaccount:default:solodev-serviceaccount"
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
    aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN
    applyServiceAccount $ROLE_NAME
}

applyServiceAccount(){
    ROLE_NAME="${args[1]}"
    S3_ROLE_ARN=$(aws iam get-role --role-name $ROLE_NAME --query Role.Arn --output text)
    kubectl create sa solodev-serviceaccount --namespace ${NAMESPACE}
    kubectl annotate sa solodev-serviceaccount eks.amazonaws.com/role-arn=$S3_ROLE_ARN --namespace ${NAMESPACE}
    echo "Service Account Created: solodev-serviceaccount"
}


$*