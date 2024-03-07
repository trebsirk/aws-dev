#!/bin/bash
cd terraform
Q_URL=$(terraform output -raw queue_url)
echo "Q_URL = $Q_URL"
SNS_ARN=$(terraform output -raw sns_arn)
echo "SNS_ARN = $SNS_ARN"
cd ..


aws sqs purge-queue --queue-url $Q_URL

aws sns publish \
    --topic-arn $SNS_ARN \
    --message file://msg.txt \
    --no-cli-pager
