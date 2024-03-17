terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.1.0"
    }
  }
   backend "s3" {
     bucket         = "dev-state-terraform-xyz"
     key            = "terraform/terraform.tfstate"
     region         = "ap-south-1"
     profile        = "terraform" # Use your corresponding profile
     dynamodb_table = "TERRAFORM-STATE-LOCK"
     encrypt        = true
   }
}



provider "aws" {
  region  = var.region
  profile = "terraform" # Use your corresponding profile
}
