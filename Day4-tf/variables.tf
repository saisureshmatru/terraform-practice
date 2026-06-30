# AWS region
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

# Bucket name
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-terraform-s3bucket-123rttrry55655rr545" # Change this to something unique
}

# Environment tag
variable "environment" {
  description = "Environment for tagging"
  type        = string
  default     = "dev"
}


