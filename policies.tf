# policy for lambda role identity
data "aws_iam_policy_document" "lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# policy for lambda running privileges
data "aws_iam_policy_document" "running" {
  statement {
    sid    = "S3Read"
    effect = "Allow"
    actions = [
      "s3:GetObject*"
    ]
    resources = [format("arn:aws:s3:::%s", var.bucket)]
  }
  statement {
    sid    = "LambdaRead"
    effect = "Allow"
    actions = [
      "lambda:ListFunctions"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "LambdaUpdate"
    effect = "Allow"
    actions = [
      "lambda:GetFunction",
      "lambda:UpdateFunctionCode"
    ]
    resources = ["arn:aws:lambda:*:*:function:*"]
  }
}

# policy for lambda monitoring privileges
data "aws_iam_policy_document" "monitoring" {
  statement {
    sid       = "DLQ"
    effect    = "Allow"
    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.dlq.arn]
  }
  statement {
    sid    = "Logging"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      format(
        "arn:aws:logs:*:*:log-group:/aws/lambda/%s-%s:log-stream:*",
        var.prefix_module,
        random_string.suffix.result
      )
    ]
  }
}

# policy for dlq
data "aws_iam_policy_document" "dlq" {
  statement {
    sid       = "DLQ"
    effect    = "Allow"
    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.dlq.arn]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values = [
        aws_cloudwatch_event_rule.zip.arn,
        aws_lambda_function.zip.arn
      ]
    }
  }
}
