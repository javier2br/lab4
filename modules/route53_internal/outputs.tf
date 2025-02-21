output "internal_zone_id" {
  value = aws_route53_zone.internal_zone.zone_id
}
output "internal_zone_name_servers" {
  value = aws_route53_zone.internal_zone.name_servers
}