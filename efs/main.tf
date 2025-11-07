
#---------------------------------------------#
# Author: Adam WezvaTechnologies
# Call/Whatsapp: +91-9739110917
#---------------------------------------------#

provider "aws" {
  region = "ap-south-1"
}

variable "default_vpc_id" {
 default = "vpc-0e53618e41f946146"
}

variable "default_subnet_id" {
 default = ["subnet-034ae6bc268a8a248", "subnet-0d4876621a535c5f1", "subnet-06ae91a8b23fe0ce6"]
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
