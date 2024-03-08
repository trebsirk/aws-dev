
output "sns_topic" {
  value       = aws_sns_topic.demo_topic.name
  description = "SNS topic."
}

output "sns_arn" {
  value       = aws_sns_topic.demo_topic.arn
  description = "SNS ARN."
}

output "queue_url" {
  description = "The URL of the SQS queue"
  value       = try(aws_sqs_queue.demo_queue.url, null)
}

