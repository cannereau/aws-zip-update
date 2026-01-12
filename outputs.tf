output "event_rule" {
  value       = aws_cloudwatch_event_rule.zip.arn
  description = "EventBridge rule's ARN"
}

output "lambda_function" {
  value       = aws_lambda_function.zip.arn
  description = "Lambda function's ARN"
}
