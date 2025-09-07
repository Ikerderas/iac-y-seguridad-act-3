terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Región AWS"
}

variable "base_bucket_name" {
  type        = string
  default     = "ikerderas"
  description = "Prefijo base del bucket (minúsculas, sin espacios)"
}

provider "aws" {
  region = var.aws_region
}

resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  bucket_name = "${var.base_bucket_name}-tf-${random_id.suffix.hex}"
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  tags = {
    Name      = local.bucket_name
    Owner     = "Iker Deras"
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

output "bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = "Nombre final del bucket"
}

output "bucket_region" {
  value       = var.aws_region
  description = "Región del bucket"
}