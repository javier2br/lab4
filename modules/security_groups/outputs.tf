output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "web_sg_id" {
  value = aws_security_group.web_sg.id
}

output "cache_sg_id" {
  value = aws_security_group.cache_sg.id
}
