# Crear un grupo de subredes para ElastiCache usando las subnets privadas
resource "aws_elasticache_subnet_group" "cache_subnet_group" {
  name       = var.cache_subnet_group_name
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = var.cache_subnet_group_name
  }
}

# Crear un cluster de ElastiCache (por ejemplo, Redis)
resource "aws_elasticache_cluster" "cache_cluster" {
  cluster_id           = var.cache_cluster_id
  engine               = var.cache_engine
  node_type            = var.cache_node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  port                 = var.cache_port

  subnet_group_name  = aws_elasticache_subnet_group.cache_subnet_group.name
  security_group_ids = var.cache_sg_ids

  tags = {
    Name = var.cache_cluster_id
  }
}
