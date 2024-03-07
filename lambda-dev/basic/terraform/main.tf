provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "my_lambda_function" {
  function_name = "lambda-dev-demo"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  filename      = "${path.module}/../artifacts/lambda_function.zip"  # Path to your local Python file
  source_code_hash = filebase64sha256("${path.module}/../artifacts/lambda_function.zip")
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-dev-role"
  
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
