provider "aws" {
  region = "us-east-1"
}

# Backend configuration for storing state
/*terraform {
  backend "s3" {
    # S3 bucket and key settings
  }
}*/

# Include environments
module "dev" {
  source = "./environments/dev"
}

/*
module "stage" {
  source = "./environments/stage"
}

module "prod" {
  source = "./environments/prod"
}*/

