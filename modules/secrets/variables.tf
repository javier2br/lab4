variable "secret_name" {
  description = "Nombre del secreto en Secrets Manager"
  type        = string
}

variable "environment" {
  description = "Entorno (p.ej. LAB4)"
  type        = string
}

variable "db_username" {
  description = "Usuario para la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña para la base de datos"
  type        = string
  sensitive   = true
}
