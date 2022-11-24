output "conf_bucket_arn" {
  value       = local.configuration_bucket_enabled ? module.conf_bucket.bucket_arn : null
  description = "The ARN for the configuration (read-only) S3 bucket"
}

output "conf_bucket_id" {
  value       = local.configuration_bucket_enabled ? module.conf_bucket.bucket_id : null
  description = "The ID for the configuration (read-only) S3 bucket"
}

output "instance_profile_name" {
  value       = local.enabled ? aws_iam_instance_profile.this[0].name : null
  description = "The name for the IAM instance profile with the attached policies (bucket access and SSM)"
}

output "log_bucket_arn" {
  value       = local.logs_bucket_enabled ? module.log_bucket.bucket_arn : null
  description = "The ARN for the logs (read/write) S3 bucket"
}

output "log_bucket_id" {
  value       = local.logs_bucket_enabled ? module.log_bucket.bucket_id : null
  description = "The ID for the logs (read/write) S3 bucket"
}
