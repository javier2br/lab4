variable "vpc_id" {
  description = "ID de la VPC donde se crearán los Security Groups"
  type        = string
}

variable "alb_sg_name" {
  description = "Nombre para el Security Group del ALB"
  type        = string
  default     = "alb-sg"
}

variable "alb_ingress_cidr" {
  description = "CIDR(s) permitidos para el tráfico entrante al ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "rds_sg_name" {
  description = "Nombre para el Security Group de RDS"
  type        = string
  default     = "rds-sg"
}

variable "rds_ingress_cidr" {
  description = "CIDR(s) permitidos para el tráfico entrante a RDS"
  type        = list(string)
  # Puedes ajustar esto para limitarlo a la VPC o a un SG en específico
  default     = ["10.0.0.0/16"]
}

variable "web_sg_name" {
  description = "Nombre para el Security Group de las instancias web"
  type        = string
  default     = "web-sg"
}

variable "cache_sg_name" {
  description = "Nombre para el Security Group de caché"
  type        = string
  default     = "cache-sg"
}

variable "cache_ingress_cidr" {
  description = "Lista de CIDR permitidos para el tráfico de caché (por ejemplo, el rango de la VPC)"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

/*
variable "ssh_allowed_cidrs" {
  description = "Lista de CIDR desde los cuales se permite acceso SSH a las instancias web"
  type        = list(string)
  default     = ["x.x.x.x/32"]  # Reemplaza con tu IP
}
*/