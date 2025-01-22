
//Here is where we are defining our Terraform setting 
terraform {
  required_providers {
    aws = {
      // The only required provider we need is aws , and we want version 5.0.0
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

// Here we are configuring our aws provider 
// we are setting the region to the region of our variable "region"

provider "aws"{
  region     = var.region
}
