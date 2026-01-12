variable "bucket" {
  type        = string
  description = "S3 Bucket's name hosting Lambda ZIP Package objects"
}

variable "event_state" {
  type        = string
  default     = "ENABLED"
  description = "EventBridge rule's state. Valid values are ('ENABLED', 'DISABLED')"
  validation {
    condition     = contains(["ENABLED", "DISABLED"], var.event_state)
    error_message = "Valid values for var: event_state are ('ENABLED', 'DISABLED')"
  }
}

variable "prefix_module" {
  type        = string
  default     = "zip-update"
  description = "Prefix for naming AWS resources of this module"
}

variable "retention" {
  type        = number
  default     = 30
  description = "Lambda logs retention in days"
}

variable "concurrents" {
  type        = number
  default     = 4
  description = "Reserved concurrent Lambda executions"
}

variable "runtime" {
  type        = string
  default     = "python3.14"
  description = "Lambda runtime version"
}

variable "tags" {
  type        = map(string)
  description = "Tags that will be applied to the module's resources"

  default = {
    DeploymentTool = "OpenTofu"
  }
}
