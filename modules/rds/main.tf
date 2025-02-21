resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_instance" "postgres_instance" {
  identifier              = var.db_identifier
  engine                  = "postgres"
  engine_version          = "16.3"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = var.rds_sg_ids
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot     = true
# Habilitar Multi-AZ para alta disponibilidad
  multi_az                = true
  tags = {
    Name = var.db_identifier
  }
}
