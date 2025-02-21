#############################
# Security Group para ALB
#############################
resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Security Group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.alb_ingress_cidr
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.alb_ingress_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.alb_sg_name
  }
}

#############################
# Security Group para RDS
#############################
resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = "Security Group for RDS PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.rds_ingress_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_sg_name
  }
}

#############################
# Security Group para Instancias Web
#############################
resource "aws_security_group" "web_sg" {
  name        = var.web_sg_name
  description = "Security Group for Web Instances"
  vpc_id      = var.vpc_id

  # Permite tráfico HTTP desde el SG del ALB
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # permitir trafico https desde el SG del ALB
    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }   

/*
  # Permite acceso SSH desde un rango específico (ajusta según necesidad)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }
*/
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.web_sg_name
  }
}
#############################
# Security Group para Caché (ElastiCache)
#############################
resource "aws_security_group" "cache_sg" {
  name        = var.cache_sg_name
  description = "Security Group for ElastiCache (Redis)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = var.cache_ingress_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.cache_sg_name
  }
}
#############################