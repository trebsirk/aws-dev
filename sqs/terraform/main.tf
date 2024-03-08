
resource "aws_sqs_queue" "demo_queue" {
  name = "sqs-dev-demo"
}


data "aws_iam_policy_document" "test" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.demo_queue.arn]
    
  }
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.demo_queue.id
  policy    = data.aws_iam_policy_document.test.json
}