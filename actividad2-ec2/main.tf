terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "aws_region" {
  description = "Región AWS"
  type        = string
  default     = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "ikerderas_server_terr" {
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t3.micro"

  tags = {
    Name        = "IkerderasServerTerraform"
    Owner       = "Iker Deras"
    Provisioner = "Terraform"
  }
}

output "instance_id" {
  value       = aws_instance.ikerderas_server_terr.id
  description = "ID de la instancia"
}

output "public_ip" {
  value       = aws_instance.ikerderas_server_terr.public_ip
  description = "IP pública"
}

output "ami_usada" {
  value       = data.aws_ssm_parameter.al2023.value
  sensitive   = true
  description = "AMI (sensitive por provider)"
}