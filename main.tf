#https://registry.terraform.io/providers/hashicorp/aws/latest/docs
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
locals {
  lb_name        = "${var.environment}-${var.lb_name}"
  tg_name        = "${var.environment}-${var.lb_name}-tg"
  tf_version     = trimspace(chomp(file("./tf_version")))
  module_version = trimspace(chomp(file("./version")))
  last_update    = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  tags = merge(var.tags, {
    environment    = "${var.environment}",
    application    = "${var.application}",
    module_name    = "terraform-aws-ec2-load-balancer",
    module_version = "${local.module_version}",
    terraform      = "${local.tf_version}",
    last_update    = "${local.last_update}"
  })
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "this" {
  name                       = local.lb_name
  load_balancer_type         = var.lb_type
  internal                   = var.lb_internal
  security_groups            = var.lb_security_group_list
  subnets                    = var.lb_subnets_list
  enable_deletion_protection = var.environment == "prd" ? true : false
  tags                       = merge(local.tags, { Name = "${local.lb_name}" })
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "this" {
  name     = local.tg_name
  port     = 8000
  protocol = var.lb_listener_protocol
  vpc_id   = var.lb_vpc_id

  slow_start           = 30
  deregistration_delay = 30

  health_check {
    path                = try(var.lb_health_check.path, "/")
    healthy_threshold   = try(var.lb_health_check.healthy_threshold, 5)
    unhealthy_threshold = try(var.lb_health_check.unhealthy_threshold, 2)
    timeout             = try(var.lb_health_check.timeout, 5)
    interval            = try(var.lb_health_check.interval, 30)
    matcher             = try(var.lb_health_check.matcher, "200")
  }

  tags = merge(local.tags, { Name = "${local.tg_name}" })
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
#resource "aws_lb_target_group_attachment" "this" {
#  target_group_arn = aws_lb_target_group.this.arn
#  target_id        = aws_lb.this.id
#  port             = 8000
#}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
#tfsec:ignore:AWS004
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol
  ssl_policy        = var.lb_listener_protocol == "HTTPS" ? var.lb_listener_ssl_policy : null
  certificate_arn   = var.lb_listener_protocol == "HTTPS" ? var.lb_listener_certificate_arn : null

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
