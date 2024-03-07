provider "aws" {
  region = "us-east-1"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-dev-s3-trigger-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.lambda_dev_s3_trigger.arn
}

resource "aws_lambda_function" "func" {
  function_name = "lambda-dev-s3-trigger-demo"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  filename      = "${path.module}/../artifacts/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/../artifacts/lambda_function.zip")
}

resource "aws_s3_bucket" "lambda_dev_s3_trigger" {
  bucket = "lambda-dev-s3-trigger"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.lambda_dev_s3_trigger.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:*"]
    # filters for inclusion, not exclusion, e.g. only notify .log files 
    # filter_prefix       = "AWSLogs/"
    # filter_suffix       = ".log"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}



resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.lambda_dev_s3_trigger.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.lambda_dev_s3_trigger.id
  acl    = "private"
}

/*

resource "aws_lambda_function" "my_lambda_function" {
  function_name = "lambda-dev-s3-trigger-demo"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  filename      = "${path.module}/../artifacts/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/../artifacts/lambda_function.zip")

  environment {
    variables = {
      # Add any environment variables you need for your Lambda function
      # For example:
      # EXAMPLE_VAR = "example_value"
    }
  }
}


resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.lambda_dev_s3_trigger.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.lambda_dev_s3_trigger.id
  acl    = "private"
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.lambda_dev_s3_trigger.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.my_lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-dev-s3-trigger-role"
  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
*/