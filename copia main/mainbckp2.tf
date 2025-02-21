terraform {
  backend "s3" {
    bucket = "lockid-backend"
    key    = "terraform.tfstate"
    region = "eu-west-3"  
    dynamodb_table = "terraform_state"

  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">3.0"
    }
  }
}


data "aws_s3_bucket_object" "archivo" {
  bucket = "lockid-backend"
  key    = "D:/AWS/terraform_1.10.5/archivo.txt"
}

resource "local_file" "archivo_local" {
  content  = data.aws_s3_bucket_object.archivo.body
  filename = "archivo.txt"  # Ruta y nombre del fichero local
}

/*
resource "bucket" "name" {
  

}
 provider "aws" {
  region = "eu-west-3"  # Cambia la región según tu necesidad
}
*/
/*
# Crear el contenedor del secreto
resource "aws_secretsmanager_secret" "mi_secreto" {
  name        = "mi_secreto"
  description = "Secreto de prueba para mostrar en texto plano"
}

# Crear la versión del secreto con el valor (en este ejemplo un JSON)
resource "aws_secretsmanager_secret_version" "mi_secreto_version" {
  secret_id     = aws_secretsmanager_secret.mi_secreto.id
  secret_string = jsonencode({
    usuario  = "Javi que malo eres "
    password = "no tengo ni puta idea"
  })
}

# Recuperar la versión del secreto
data "aws_secretsmanager_secret_version" "mi_secreto_data" {
  secret_id = aws_secretsmanager_secret.mi_secreto.id
}

# Output que muestra el secreto en texto plano
output "mi_secreto_string" {
  value = data.aws_secretsmanager_secret_version.mi_secreto_data.secret_string
}
*/