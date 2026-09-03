resource "aws_lb" "myapp_lb" {
  name               = "myapp_lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_sn.id]

  enable_deletion_protection = false

  tags = {
    Environment = "myapps_alb"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "alb_tg"
  port     = 3000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = aws_vpc.custom_vpc

  health_check {
    path                = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    name = "myapp_tg"
  }
}