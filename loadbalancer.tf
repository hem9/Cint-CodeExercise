resource "aws_lb" "loadBalancer" {
  name               = "cint-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  subnets            = [aws_subnet.public[0].id,aws_subnet.public[1].id]
  security_groups    = [aws_security_group.loadBalancer.id]

  enable_deletion_protection = false

  tags = {
    Name = "cint_ALB"
  }
}

resource "aws_lb_target_group" "targetGroup" {
  name        = "alb-targetgroup"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {     //attach 2 instance to this lb 
  count            = length(aws_instance.ec2_instance)
  target_group_arn = aws_lb_target_group.targetGroup.arn
  target_id        = aws_instance.ec2_instance[count.index].id
  port             = 80
}