#---------------------------------------------#
# Author: Adam WezvaTechnologies
# Call/Whatsapp: +91-9739110917
#---------------------------------------------#

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./network"

  vpc_cidr = "10.0.0.0/16"
  
  sg_public_ingress = [
    {
      description = "Allows SSH access"
      port        = 22
      protocol    = "tcp"
    },
    {
      description = "Allows HTTP traffic"
      port        = 80
      protocol    = "tcp"
    },
  ]
  
  sg_public_egress  =  [443]
  
  public_subnets  = ["10.0.101.0/24"]

  sg_private_ingress = [8080, 2049]

  sg_private_egress  =  [443]

  private_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]

  enable_nat_gateway = true
}

#---------------------------------------------#
# Author: Adam WezvaTechnologies
# Call/Whatsapp: +91-9739110917
#---------------------------------------------#
