terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "ec2_instance" {
  count = 2
  subnet_id = aws_subnet.private[count.index].id
  ami           = var.ami_id 
  instance_type = "t2.micro"     
  security_groups = [aws_security_group.app_sg.id]
  # Other instance configuration parameters...

  tags = {
    Name        = "EC2 Instance ${count.index + 1}"
    Description = "Terraform-created EC2 instance ${count.index + 1}"
  }
}

# Output the DNS name of the ALB
output "load_balancer_dns" {
  value = aws_lb.loadBalancer.dns_name
}