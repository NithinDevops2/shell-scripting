resource "aws_security_group" "allow-app" {
  name = "allow-${var.COMPONENT}"
  description = "Allow inbound for ${var.COMPONENT} Component"

  ingress {
    description = "TLS from VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "APPPORT"
    from_port = var.PORT
    to_port = var.PORT
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "allow-${var.COMPONENT}"
  }
}
