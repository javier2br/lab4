variable "db_subnet_group_name" {
  description = "Nombre del grupo de subnets para RDS"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  type        = list(string)
}

variable "db_identifier" {
  description = "Identificador de la instancia RDS"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
}

variable "rds_sg_ids" {
  description = "IDs de los Security Groups permitidos para RDS"
  type        = list(string)
}
