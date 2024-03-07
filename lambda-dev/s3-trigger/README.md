### AWS S3 bucket notification to Lambda demo

#### goals
generate infrastructure and code for lambda function and the following triggers and destinations

##### done
1. S3 -> lambda -> log 

##### todo
2. S3 -> lambda -> S3
3. {S3,SNS,SQS} -> lambda -> {S3,SNS,SQS}
4. work on lamp on ec2 in aws-dev/ec2-dev/

#### status
Lambda is triggered when S3 object is created. The Lambda function reads the object name is logs it to CloudWatch. 

#### section 1a (above) - tiny ETL
S3 object could be a `.csv` file and the lambda could convert the rows to (data)classes and write them to another S3 object. 

#### python deps
```bash
pipenv shell --python 3.12
pipenv install boto3
pipenv requirements > requirements.txt
```

#### ci/cd
```bash
./setup.sh
cd code
# write code
# return to main project dir
cd ..
# package artifact
./zip-py.sh
# provision infra
./provision.sh
# test
./invoke.sh
# if tests pass, use it 
# tear down infra
./destroy.sh
```
