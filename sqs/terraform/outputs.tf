output "queue_url" {
  description = "The URL of the SQS queue"
  value       = try(aws_sqs_queue.demo_queue.url, null)
}

