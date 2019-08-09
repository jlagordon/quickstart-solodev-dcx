#!/usr/bin/env bash

echo "Create Solodev DCX for EKS"
echo $(aws s3 cp s3://build-secure/params/solodev-dcx-eks.json - ) > solodev-dcx-eks.json
aws cloudformation create-stack --disable-rollback --stack-name eks-tmp-${DATE} --disable-rollback --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --parameters file:///${CODEBUILD_SRC_DIR}/solodev-dcx-eks.json \
    --template-url https://s3.amazonaws.com/solodev-eks/solodev-dcx.yaml \
    --notification-arns $NOTIFICATION_ARN
