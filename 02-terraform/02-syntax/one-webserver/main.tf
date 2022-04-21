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
  name = "std22-web"

  ingress {
    from_port    = 8080
    to_port      = 8080
    protocol     = "tcp"
    cidr_blocks   = ["0.0.0.0/0"]
  }
}