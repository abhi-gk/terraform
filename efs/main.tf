
#---------------------------------------------#
# Author: Adam WezvaTechnologies
# Call/Whatsapp: +91-9739110917
#---------------------------------------------#

provider "aws" {
  region = "ap-south-1"
}

resource "aws_efs_file_system" "wezvatech" {
  creation_token = "jrp1.0"
  encrypted      = true

  tags = {
    Name = "jrp"
  }
}

#---------------------------------------------#
# Author: Adam WezvaTechnologies
# Call/Whatsapp: +91-9739110917
#---------------------------------------------#
