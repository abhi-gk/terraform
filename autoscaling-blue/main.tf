
#---------------------------------------------#
# Author: Adam WezvaTechnologies
# Call/Whatsapp: +91-9739110917
#---------------------------------------------#

provider "aws" {
  region = "ap-south-1"
}

module "autoscaling" {
  source = "./autoscaling"
  name = "asg-blue"
  create_launch_template = true
  vpc_zone_identifier       = ["subnet-0b134c01fd2ce1ece", "subnet-0e15e72c9967f4bd1","subnet-0e56ccfe47eb41d47"]
  load_balancers            = ["wezvatech"]
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  health_check_type         = "EC2"
  health_check_grace_period = 30

  launch_template_name        = "lt-blue"
  image_id          = "ami-0a7cf821b91bcccbc"
  key_name          = "jan24master"
  instance_type     = "t3.micro"
  security_groups   = ["sg-024da43ccf9b0816d"]
}

#---------------------------------------------#
# Author: Adam WezvaTechnologies
# Call/Whatsapp: +91-9739110917
#---------------------------------------------#
