variable "dashboard_name" {
  description = "Nombre del dashboard de CloudWatch"
  type        = string
  default     = "lab4-dashboard"
}

variable "asg_name" {
  description = "Nombre del Auto Scaling Group para agrupar métricas de EC2"
  type        = string
}

variable "rds_identifier" {
  description = "Identificador de la instancia RDS a monitorear"
  type        = string
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "eu-west-3"
}
