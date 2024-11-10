
#---------------------------------------------#
# Author: Adam WezvaTechnologies
# Call/Whatsapp: +91-9739110917
#---------------------------------------------#

provider "aws" {
  region = "ap-south-1"
}

variable "default_vpc_id" {
 default = "vpc-08b3ea433e2014c6a"
}

variable "default_subnet_id" {
 default = ["subnet-0b134c01fd2ce1ece", "subnet-0e15e72c9967f4bd1","subnet-0e56ccfe47eb41d47"]
}

resource "aws_efs_file_system" "wezvatech" {
  creation_token = "jrp"
  encrypted = true

  tags = {
    Name = "jrp"
  }
}

resource "aws_efs_mount_target" "example" {
 for_each = toset(var.default_subnet_id)
 file_system_id = aws_efs_file_system.wezvatech.id
 subnet_id = each.key
}

#---------------------------------------------#
# Author: Adam WezvaTechnologies
# Call/Whatsapp: +91-9739110917
#---------------------------------------------#
