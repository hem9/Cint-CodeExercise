resource "aws_launch_configuration" "launchConfig" {
  name          = "cint-launch-configuration"
  image_id      = var.ami_id  
  instance_type = "t2.micro"  
  security_groups = [aws_security_group.app_sg.id]

}

resource "aws_autoscaling_group" "autoscalingGroup" {
  name                      = "autoscaling_Group"
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.private[1].id,aws_subnet.private[2].id]
  launch_configuration = aws_launch_configuration.launchConfig.name
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscalingGroup.id
  lb_target_group_arn    = aws_lb_target_group.targetGroup.arn
} 

