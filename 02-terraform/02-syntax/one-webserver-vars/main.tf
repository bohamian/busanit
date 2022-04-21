provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "busanit-std22" {
  ami                    = "ami-04876f29fd3a5e8ba"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World" > index.html
            nohup busybox httpd -f -p 8080 &
            EOF

  tags = {
    Name = "std22"
  }
}

resource "aws_security_group" "instance" {

  name = var.security_group_name

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "std22-web"
}

output "public_ip" {
  value       = aws_instance.busanit-std22.public_ip
  description = "The public IP of the Instance"
}