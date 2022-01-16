#https://www.terraform.io/language/values/variables
###############################################################################
# Required variables
###############################################################################
variable "lb_name" {
  description = "(Required) Load Balancer name."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.lb_name) > 0
    error_message = "Load Balancer name is required."
  }
}

variable "lb_type" {
  description = "(Required) Load Balancer type."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("application|gateway|network", var.lb_type))
    error_message = "You must put a valid type (application, gateway, or network)."
  }
}

variable "lb_internal" {
  description = "(Required) Internla Load Balancer (private)."
  type        = bool
  nullable    = false
}

variable "lb_security_group_list" {
  description = "(Required) Load Balancer security group id list."
  type        = list(string)
  nullable    = false
}

variable "lb_subnets_list" {
  description = "(Required) Load Balancer subnets id list."
  type        = list(string)
  nullable    = false
}

variable "lb_vpc_id" {
  description = "(Required) Load Balancer VPC id."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("vpc-[a-z0-9]{17}", var.lb_vpc_id))
    error_message = "You must put a valid vpc id (ex: vpc-0dcef6ce0aed94c3e)."
  }
}

###############################################################################
# Optional variables
###############################################################################
variable "lb_listener_protocol" {
  description = "(Optional) Load Balancer Listener port."
  type        = string
  default     = "HTTP"

  validation {
    condition     = can(regex("HTTP|HTTPS", var.lb_listener_protocol))
    error_message = "You must put a valid listener protocol (HTTP or HTTPS)."
  }
}

variable "lb_listener_port" {
  description = "(Optional) Load Balancer Listener port."
  type        = number
  default     = 80

  validation {
    condition     = can(regex("80|443", var.lb_listener_port))
    error_message = "You must put a valid listener port (80 or 443)."
  }
}

variable "lb_listener_ssl_policy" {
  description = "(Optional) Load Balancer Listener SSL policy."
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "lb_listener_certificate_arn" {
  description = "(Optional) Load Balancer Listener Certificate arn."
  type        = string
  default     = "arn:aws:iam::111111111111:server-certificate/test"

  validation {
    condition     = can(regex("arn:aws:iam::[0-9]{12}:server-certificate[/]{1}[a-z0-9-_]*", var.lb_listener_certificate_arn))
    error_message = "You must put a valid listener certificate arn (ex: arn:aws:iam::111111111111:server-certificate/test)."
  }
}

variable "lb_health_check" {
  description = "(Optional) Load Balancer Health check."
  type = object({
    path                = string
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    interval            = number
    matcher             = string
  })
  default = {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}
variable "tags" {
  description = "(Optional) List of policies arn"
  type        = any
  default     = {}
}
