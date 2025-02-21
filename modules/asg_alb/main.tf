#############################
# Launch Template para instancias
#############################
resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = "ami-00c589b38b4ec4597"    ##var.ami_id  # ID de una AMI de Linux (por ejemplo, Amazon Linux 2)
  instance_type = var.instance_type
  # key_name      = var.key_name

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Bienvenido a mi CMS</h1>" > /var/www/html/index.html
              EOF
  )

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = var.ec2_sg_ids
  }
}

#############################
# Auto Scaling Group
#############################
resource "aws_autoscaling_group" "web_asg" {
  name                      = "web-asg"
  max_size                  = 3
  min_size                  = 2
  desired_capacity          = 2
  vpc_zone_identifier       = var.private_subnet_ids
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "Web-Instance"
    propagate_at_launch = true
  }
}

#############################
# ALB y Target Group
#############################
resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_sg_ids
  subnets            = var.public_subnet_ids
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-3:640168456957:certificate/beece9c2-41e0-48c0-87ce-dec4005861cc"  # var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}
