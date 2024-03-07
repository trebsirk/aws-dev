### Basic AWS Lambda demo

#### goals
generate infrastructure and code for lambda function

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
