## AWS SNS demo

This project contains terraform to provision an SNS topic and corresponding SQS subscription, and bash scripts to publish a message to the topic and read from the queue. 

#### usage

```bash
cd terraform
terraform init
terraform plan
terraform apply

cd ..
chmod +x publish.sh read.sh
./publish.sh
./read.sh
```