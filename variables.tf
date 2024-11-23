variable "disable_configuration_bucket" {
  description = "Disable the creation of the configuration bucket."
  default     = false
  type        = bool
}

variable "disable_logs_bucket" {
  description = "Disable the creation of the logs bucket."
  default     = false
  type        = bool
}

variable "disable_ssm" {
  description = "Do not attach the AmazonSSMManagedInstanceCore policy to the instance profile."
  default     = false
  type        = bool
}

variable "log_groups_root" {
  description = <<EOT
Attach a policy to the instance profile to allow RW access to this CloudWatch log groups with this root prefix.
In the default case, no policy is attached for CloudWatch log group access.
EOT
  default     = null
  type        = string
}