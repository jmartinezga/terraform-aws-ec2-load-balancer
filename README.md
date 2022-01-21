# Terraform EC2 Load Balancer module

### Install dependencies

<!-- markdownlint-disable no-inline-html -->

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/terraform-docs/terraform-docs)
* [`terragrunt`](https://terragrunt.gruntwork.io/docs/getting-started/install/)
* [`terrascan`](https://github.com/accurics/terrascan)
* [`TFLint`](https://github.com/terraform-linters/tflint)
* [`TFSec`](https://github.com/liamg/tfsec)
* [`infracost`](https://github.com/infracost/infracost)
* [`jq`](https://github.com/stedolan/jq)

### Install the pre-commit hook globally

```bash
DIR=~/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.73.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | (Required) Application name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment (dev, stg, prd) | `string` | n/a | yes |
| <a name="input_lb_health_check"></a> [lb\_health\_check](#input\_lb\_health\_check) | (Optional) Load Balancer Health check. | <pre>object({<br>    path                = string<br>    healthy_threshold   = number<br>    unhealthy_threshold = number<br>    timeout             = number<br>    interval            = number<br>    matcher             = string<br>  })</pre> | <pre>{<br>  "healthy_threshold": 5,<br>  "interval": 30,<br>  "matcher": "200",<br>  "path": "/",<br>  "timeout": 5,<br>  "unhealthy_threshold": 2<br>}</pre> | no |
| <a name="input_lb_internal"></a> [lb\_internal](#input\_lb\_internal) | (Required) Internla Load Balancer (private). | `bool` | n/a | yes |
| <a name="input_lb_listener_certificate_arn"></a> [lb\_listener\_certificate\_arn](#input\_lb\_listener\_certificate\_arn) | (Optional) Load Balancer Listener Certificate arn. | `string` | `"arn:aws:iam::111111111111:server-certificate/test"` | no |
| <a name="input_lb_listener_port"></a> [lb\_listener\_port](#input\_lb\_listener\_port) | (Optional) Load Balancer Listener port. | `number` | `80` | no |
| <a name="input_lb_listener_protocol"></a> [lb\_listener\_protocol](#input\_lb\_listener\_protocol) | (Optional) Load Balancer Listener port. | `string` | `"HTTP"` | no |
| <a name="input_lb_listener_ssl_policy"></a> [lb\_listener\_ssl\_policy](#input\_lb\_listener\_ssl\_policy) | (Optional) Load Balancer Listener SSL policy. | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | (Required) Load Balancer name. | `string` | n/a | yes |
| <a name="input_lb_security_group_list"></a> [lb\_security\_group\_list](#input\_lb\_security\_group\_list) | (Required) Load Balancer security group id list. | `list(string)` | n/a | yes |
| <a name="input_lb_subnets_list"></a> [lb\_subnets\_list](#input\_lb\_subnets\_list) | (Required) Load Balancer subnets id list. | `list(string)` | n/a | yes |
| <a name="input_lb_type"></a> [lb\_type](#input\_lb\_type) | (Required) Load Balancer type. | `string` | n/a | yes |
| <a name="input_lb_vpc_id"></a> [lb\_vpc\_id](#input\_lb\_vpc\_id) | (Required) Load Balancer VPC id. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | (Required) AWS Region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) List of policies arn | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Load Balancer arn. |
| <a name="output_id"></a> [id](#output\_id) | Load Balancer id. |
| <a name="output_tg_arn"></a> [tg\_arn](#output\_tg\_arn) | Load Balancer target group arn. |
| <a name="output_tg_id"></a> [tg\_id](#output\_tg\_id) | Load Balancer target group id. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
