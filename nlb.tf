data "aws_subnet_ids" "this" {
  vpc_id = var.vpc_id

  tags = {
    Tier = "Private"
  }
}

# Network Load Balancer
resource "aws_lb" "nlb" {
  name               = "example-nlb"
  internal           = true
  load_balancer_type = "network"
  security_groups    = [aws_security_group.this.id]
  subnets            = data.aws_subnet_ids.this.id  # replace with your subnet IDs

  enable_deletion_protection = false

  tags = {
    Name = "example-nlb"
  }
}



