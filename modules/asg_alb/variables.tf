variable "ami_id" {
  description = "AMI para las instancias EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
}

variable "key_name" {
  description = "Nombre del par de llaves para SSH"
  type        = string
}

variable "ec2_sg_ids" {
  description = "Lista de IDs de Security Groups para las instancias EC2"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs de las subnets privadas para el ASG"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "IDs de las subnets públicas para el ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "alb_sg_ids" {
  description = "IDs de los Security Groups para el ALB"
  type        = list(string)
}
/*
variable "certificate_arn" {
  description = "ARN del certificado ACM validado"
  type        = string
}
*/