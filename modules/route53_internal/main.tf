resource "aws_route53_zone" "internal_zone" {
  name = var.internal_domain
  vpc {
    vpc_id = var.vpc_id
  }
}
