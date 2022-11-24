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
