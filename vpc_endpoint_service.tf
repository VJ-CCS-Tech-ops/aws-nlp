resource "aws_vpc_endpoint_service" "rds_endpoint_service" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.nlb.arn]
}