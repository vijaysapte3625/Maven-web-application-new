resource "aws_launch_configuration" "this" {
  name_prefix   = "nexus-"
  image_id      = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro"

  security_groups = var.security_group_ids
}

resource "aws_autoscaling_group" "this" {
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = aws_launch_configuration.this.id
}
