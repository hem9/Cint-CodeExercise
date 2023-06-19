variable "name" {
  type        = string
  default     = "cint-code-test"
  description = "Root name for resources in this project"
}

variable "vpc_cidr" {
  default     = "10.1.0.0/16"
  type        = string
  description = "VPC cidr block"
}

variable "newbits" {
  default     = 8
  type        = number
  description = "How many bits to extend the VPC cidr block by for each subnet"
}

variable "public_subnet_count" {
  default     = 3
  type        = number
  description = "How many subnets to create"
}

variable "private_subnet_count" {
  default     = 3
  type        = number
  description = "How many private subnets to create"
}

variable "ami_id" {
  type = string
  default = "ami-07650ecb0de9bd731"
  description = "Amazon Linux 2023 AMI"
}

variable "rds_username" {
  description = "RDS username"
  type        = string
}

variable "rds_password" {
  description = "RDS password"
  type        = string
}

variable "rules_lb" {
  type = list(object({
    port        = number
    proto       = string
    cidr_blocks = list(string)
    })
  )
  description = "loadbalancer"
  default = [{
    port        = 80
    proto       = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    ,
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ,
    {
      port        = 443
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
     {
      port        = 3306
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
