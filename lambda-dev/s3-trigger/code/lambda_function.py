import logging
import os

import boto3

logger = logging.getLogger()
logger.setLevel("INFO")

c = boto3.client("s3")

def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    logger.info(f"object put: {bucket}/{key}")
    #resp = c.get_object(Bucket=bucket, Key=key)
