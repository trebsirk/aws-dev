# test different invokations of aws lambda func
# takes 1 arg: TEST_ALL, defaults to false

# invoke synchronously - invocation-type is RequestResponse by default 
aws lambda invoke --function-name lambda-dev-demo output.json
# same as 
# aws lambda invoke --function-name lambda-dev-demo --invocation-type RequestResponse output.json

TEST_ALL=${1:-false}

if [ "$TEST_ALL" != "true" ]; then
    echo "TEST_ALL = $TEST_ALL. exiting..."
    exit 0
fi

# invoke asynchronously
aws lambda invoke --function-name lambda-dev-demo --invocation-type Event output.async.json 

# DryRun - Validate parameter values and verify that the user or 
# role has permission to invoke the function
aws lambda invoke --function-name lambda-dev-demo --invocation-type DryRun output.dryrun.json 

# add a payload - won't matter here as the demo lambda takes no payload
# The cli-binary-format option is required for AWS CLI version 2
# currently using aws-cli/2.15.24 Python/3.11.6 Darwin/23.3.0 exe/x86_64 prompt/off
aws lambda invoke --function-name lambda-dev-demo --invocation-type DryRun --cli-binary-format raw-in-base64-out --payload '{ "key": "value" }' output.dryrun.withpayload.json

