variable "cache_subnet_group_name" {
  description = "Nombre para el grupo de subredes de ElastiCache"
  type        = string
  default     = "cache-subnet-group"
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subnets privadas para desplegar ElastiCache"
  type        = list(string)
}

variable "cache_cluster_id" {
  description = "ID del cluster de caché"
  type        = string
}

variable "cache_engine" {
  description = "Motor de caché a usar (por ejemplo, redis o memcached)"
  type        = string
  default     = "redis"
}

variable "cache_node_type" {
  description = "Tipo de nodo para el cluster de caché"
  type        = string
  default     = "cache.t2.micro"
}

variable "num_cache_nodes" {
  description = "Número de nodos de caché a crear"
  type        = number
  default     = 1
}

variable "parameter_group_name" {
  description = "Nombre del grupo de parámetros para el cluster de caché"
  type        = string
  default     = "default.redis7"
}

variable "cache_port" {
  description = "Puerto en el que el motor de caché escuchará"
  type        = number
  default     = 6379
}

variable "cache_sg_ids" {
  description = "Lista de IDs de Security Groups permitidos para el cluster de caché"
  type        = list(string)
}
