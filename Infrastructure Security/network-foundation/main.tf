terraform {

  required_version = ">= 1.6"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

  }

  backend "s3" {

    bucket = "ayka-terraform-state-secure-bucket"
    key    = "infrastructure-security/network-foundation/terraform.tfstate"
    region = "ap-south-1"

    encrypt = true

    dynamodb_table = "terraform-locks"

  }

}

provider "aws" {

  region = "ap-south-1"

  default_tags {

    tags = {

      Project     = "aws-Security-Core"
      Domain      = "Infrastructure-Security"
      Component   = "Network-Foundation"
      ManagedBy   = "Terraform"
      Environment = "Security"

    }

  }

}
