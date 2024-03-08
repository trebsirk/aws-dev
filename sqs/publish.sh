#!/bin/bash
cd terraform
Q_URL=$(terraform output -raw queue_url)
echo "Q_URL = $Q_URL"
cd ..

# can only call this once every 60 seconds
aws sqs purge-queue --queue-url $Q_URL

aws sqs send-message --queue-url $Q_URL \
    --message-body file://msg.txt \
    --no-cli-pager
