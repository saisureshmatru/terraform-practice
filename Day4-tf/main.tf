# Provider configuration
provider "aws" {
  region = var.aws_region
}

# S3 bucket resource
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

# (Optional) Enable bucket versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_vpc" "dev" {
   
  cidr_block = "10.0.0.0/16"
}  

