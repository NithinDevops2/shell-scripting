# resource "aws_instance" "ec2" {
#   ami = "ami-0bb6af715826253bf"
#   instance_type = "t3.micro"
#   vpc_security_group_ids = [aws_security_group.allow-app.id]

#   tags = {
#     Name = var.COMPONENT
#   }
# }

# Request a spot instance at $0.03
resource "aws_spot_instance_request" "ec2" {
  ami           = "ami-0bb6af715826253bf"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow-app.id]

  tags = {
    Name = var.COMPONENT
  }
}