resource "aws_lb_listener" "this" {
  for_each = var.ports

  load_balancer_arn = aws_lb.nlb.arn

  protocol          = "TCP"
  port              = each.value

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }
}