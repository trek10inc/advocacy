#!/bin/bash
set -e

# ACCOUNT=`aws sts get-caller-identity --output text --query Account`

echo "===== Stage => ${STAGE//-/}, Region => ${REGION} ====="
echo "===== assuming permissions => ${SERVICE_ROLE} ====="
KST=(`aws sts assume-role --role-arn ${SERVICE_ROLE} --role-session-name "deployment-${STAGE}" --query '[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]' --output text`)
unset AWS_SECURITY_TOKEN
export AWS_DEFAULT_REGION=${AWS_CLI_DEFAULT_REGION}
export AWS_ACCESS_KEY_ID=${KST[0]}
export AWS_SECRET_ACCESS_KEY=${KST[1]}
export AWS_SESSION_TOKEN=${KST[2]}
export AWS_SECURITY_TOKEN=${KST[2]}

sls deploy