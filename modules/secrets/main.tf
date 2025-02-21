resource "aws_secretsmanager_secret" "db_secret2" {
  name = "rds-credentials-new"     #######var.secret_name # Cambia a var.secret_name
  
  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_secret2.id
  secret_string = jsonencode({
    username = var.db_username,
    password = var.db_password
  })
}
