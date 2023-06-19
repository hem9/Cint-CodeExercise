# Create a security group for the EC2 instances
resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Security group for the application"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.loadBalancer.id]
  }
    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.loadBalancer.id]
  }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
    Name = "EC2_SG"
  }
}

# Create a security group for the RDS instances
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  vpc_id = aws_vpc.main.id
  description = "Security group for the rds"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.ec2_instance[0].private_ip}/32","${aws_instance.ec2_instance[1].private_ip}/32"]
  }

    ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.ec2_instance[0].private_ip}/32","${aws_instance.ec2_instance[1].private_ip}/32"]
  }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
    Name = "RDS_SG"
  }
}

resource "aws_security_group" "loadBalancer" {
  name        = "Loadbalancer-sg"
  description = "Allow TCP/22"
  vpc_id      = aws_vpc.main.id
  dynamic "ingress" {
    for_each = var.rules_lb
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ALB_SG"
  }
}