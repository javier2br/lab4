variable "vpc_cidr" {
  description = "CIDR para la VPC"
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "public_subnets" {
  description = "Lista de CIDRs para subnets públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDRs para subnets privadas"
  type        = list(string)
}

variable "public_azs" {
  description = "Lista de Availability Zones para subnets públicas"
  type        = list(string)
}

variable "private_azs" {
  description = "Lista de Availability Zones para subnets privadas"
  type        = list(string)
}

