#https://www.terraform.io/language/values/outputs
output "lb_id" {
  description = "Load Balancer id."
  value       = aws_lb.this.id
}

output "lb_arn" {
  description = "Load Balancer arn."
  value       = aws_lb.this.arn
}

output "lb_tg_id" {
  description = "Load Balancer target group id."
  value       = aws_lb.this.id
}

output "lb_tg_arn" {
  description = "Load Balancer target group arn."
  value       = aws_lb.this.arn
}
