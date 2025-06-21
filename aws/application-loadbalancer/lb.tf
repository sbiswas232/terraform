# Create an Application Load-Balancer
resource "aws_lb" "vpc_lb" {
  name                       = "${var.project}-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.vpc_sg.id]
  subnets                    = [for subnet in aws_subnet.subnet[*] : subnet.id]
  enable_deletion_protection = false       #"true", when we will create ALB for realtime Production Env.
                                           # because the DNS name of LB is Register with Public DNS. 
  tags = {
    Name = "${var.project}-lb"
  }
}

# Create Target-Group
resource "aws_lb_target_group" "vpc_lb_tg" {
  name             = "${var.project}-lb-tg"
  port             = 80
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  target_type      = "instance"
  vpc_id           = aws_vpc.vpc.id
}

# Create Load Balancer Listener
resource "aws_lb_listener" "vpc_lb_listener" {
  load_balancer_arn = aws_lb.vpc_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vpc_lb_tg.arn
  }
}

# Create Target-Group Attachment
resource "aws_lb_target_group_attachment" "lb_tg1" {
  target_group_arn = aws_lb_target_group.vpc_lb_tg.arn
  target_id        = aws_instance.subnet1_instance1.id # EC2 Instance Id.
  port             = 80
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "lb_tg2" {
  target_group_arn = aws_lb_target_group.vpc_lb_tg.arn
  target_id        = aws_instance.subnet2_instance1.id # EC2 Instance Id.
  port             = 80
  lifecycle {
    create_before_destroy = true
  }
}

