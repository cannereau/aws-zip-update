# AWS Lambda ZIP Package automatic updates

This is a Terraform module to build an AWS EventBridge rule
which catches S3 ZIP Package POST events and
triggers updates to Lambda functions


The ZIP Package Object name identifies the Lambda Function name  
For example, if *my-code.zip* is uploaded then
the Lambda Function named *my-code* will be automaticaly updated


A common AWS SQS dead letter queue collects
unprocessed *Event* and *Lambda* invocations

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| archive | >= 2.6.0 |
| aws | >= 6.21.0 |
| random | >= 3.6.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket | S3 Bucket's name hosting Lambda ZIP Package objects | `string` | n/a | yes |
| concurrents | Reserved concurrent Lambda executions | `number` | `4` | no |
| event\_state | EventBridge rule's state. Valid values are ('ENABLED', 'DISABLED') | `string` | `"ENABLED"` | no |
| prefix\_module | Prefix for naming AWS resources of this module | `string` | `"zip-update"` | no |
| retention | Lambda logs retention in days | `number` | `30` | no |
| runtime | Lambda runtime version | `string` | `"python3.14"` | no |
| tags | Tags that will be applied to the module's resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| event\_rule | EventBridge rule's ARN |
| lambda\_function | Lambda function's ARN |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.zip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.zip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.zip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.zip_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.zip_running](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_function.zip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.zip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sqs_queue.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [archive_file.lambda_handler](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.running](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
<!-- END_TF_DOCS -->
