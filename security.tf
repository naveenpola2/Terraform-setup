resource "aws_security_group" "mysg" {
name = "terraform-sg"
description= "it is created by terraform"

ingress{
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress{
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
}
