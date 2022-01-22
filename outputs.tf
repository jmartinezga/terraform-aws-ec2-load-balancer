#https://www.terraform.io/language/values/outputs
output "id" {
  description = "Load Balancer id."
  value       = aws_lb.this.id
}

output "arn" {
  description = "Load Balancer arn."
  value       = aws_lb.this.arn
}

output "tg_id" {
  description = "Load Balancer target group id."
  value       = aws_lb_target_group.this.id
}

output "tg_arn" {
  description = "Load Balancer target group arn."
  value       = aws_lb_target_group.this.arn
}

output "tg_name" {
  description = "Load Balancer target group name."
  value       = local.tg_name
}
