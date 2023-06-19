resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "cint-rds-instance"
  db_name              = "cintRDS"
  parameter_group_name = "default.mysql5.7"

  username = var.rds_username
  password = var.rds_password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.rds.name
  vpc_security_group_ids    = [aws_security_group.rds_sg.id]
  multi_az = true
}

resource "aws_db_subnet_group" "rds" {
    name = "rds"
    subnet_ids = [aws_subnet.private[1].id,aws_subnet.public[2].id]

    tags = {
        Name = "RDS_subnetGroup"
    }
}