## AWS SQS demo

This project contains terraform to provision an SQS queue, and bash scripts to publish a message to and read from the queue. 

#### usage

```bash
cd terraform
terraform init
terraform plan
terraform apply
# or ./setup.sh && ./provision.sh
cd ..

chmod +x publish.sh read.sh
./publish.sh
./read.sh
# dev
./destroy.sh
```