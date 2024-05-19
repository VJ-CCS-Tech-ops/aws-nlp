esource "aws_lb_target_group" "this" {
  for_each = var.ports

  port        = each.value
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  depends_on = [
    aws_lb.this
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "this" {
  for_each = local.ports_ips_product

  target_group_arn  = aws_lb_target_group.this[each.value.port].arn
  target_id         = each.value.ip
  availability_zone = "all"
  port              = each.value
}

locals {
  ports_ips_product = flatten(
    [
      for port in values(var.ports): [
      for eni in keys(data.aws_network_interface.this): {
        port = port
        ip   = data.aws_network_interface.this[eni].private_ip
      }
    ]
    ]
  )
}

data "aws_network_interfaces" "this" {
  filter {
    name   = "description"
    values = ["ENI for target"]
  }
}

data "aws_network_interface" "this" {
  for_each = toset(data.aws_network_interfaces.this.ids)
  id       = each.key
}