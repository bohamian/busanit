provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_launch_configuration" "busanit-std22" {
  image_id        = "ami-04876f29fd3a5e8ba"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "busanit-std22" {
  launch_configuration = aws_launch_configuration.busanit-std22.name
  vpc_zone_identifier  = data.aws_subnets.default.ids  

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "std22-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance" {
  name = var.instance_security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}