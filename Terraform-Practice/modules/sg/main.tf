resource "aws_security_group" "allow-tls" {
  name = "allow-tls"
  description = "Allow tls inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port = 22
    to_port = 22
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
    name = "allow-tls"
  }
}

output "SG_ID" {
  value = aws_security_group.allow-tls.id
}