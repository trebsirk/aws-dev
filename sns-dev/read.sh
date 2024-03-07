#!/bin/bash
cd terraform
Q_URL=$(terraform output -raw queue_url)
echo "Q_URL = $Q_URL"
SNS_TOPIC=$(terraform output -raw sns_topic)
echo "SNS_TOPIC = $SNS_TOPIC"
cd ..
aws sqs list-queues --no-cli-pager
aws sqs receive-message \
    --queue-url $Q_URL