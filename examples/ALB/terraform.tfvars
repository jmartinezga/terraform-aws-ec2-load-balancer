# Common variables
region      = "eu-west-1"
application = "helloworld"
environment = "dev"

# Module variables
lb_name                       = "app-lb"
lb_type                       = "application"
lb_internal                   = false
lb_security_group_list        = ["sg-0f9b6027906ee01af"]
lb_subnets_list               = ["subnet-0612add211762730f", "subnet-0182bb9320e96014f"]
lb_enable_deletion_protection = true
lb_vpc_id                     = "vpc-0dcef6ce0aed94c3e"

lb_health_check = {
  path                = "/users/1"
  healthy_threshold   = 5
  unhealthy_threshold = 2
  timeout             = 5
  interval            = 30
  matcher             = "200"
}
