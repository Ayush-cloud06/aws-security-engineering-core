terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Primary (Security) Account
/*provider "aws" {
  alias   = "primary"
  region  = "ap-south-1"
  profile = "security"
}*/

# Member Account
provider "aws" {
  region = "ap-south-1"
}
