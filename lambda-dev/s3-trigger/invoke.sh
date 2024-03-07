#!/bin/bash

# test invocations via s3 file upload to bucket lambda-dev-s3-trigger

FILE=test.txt
BUCKET=lambda-dev-s3-trigger
URL=s3://$BUCKET

echo "s3 trigger test file" > $FILE
echo "copying $FILE to $URL/"
echo "file contents:"
cat $FILE

# delete file in case it already exists
aws s3 rm $URL/$FILE
# put in s3
aws s3 cp $FILE $URL/
# delete for next time
aws s3 rm $URL/$FILE

# clean up 
rm $FILE
