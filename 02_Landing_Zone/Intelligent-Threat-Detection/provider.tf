//Here is where we are defining our Terraform setting 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}
// Here we are configuring our AWS provider 
provider "aws" {
  region     = var.region 
}
