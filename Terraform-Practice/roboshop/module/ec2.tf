# resource "aws_instance" "ec2" {
#   ami = "ami-0bb6af715826253bf"
#   instance_type = "t3.micro"
#   vpc_security_group_ids = [aws_security_group.allow-app.id]

#   tags = {
#     Name = var.COMPONENT
#   }
# }

# Request a spot instance at $0.03
resource "aws_spot_instance_request" "cheap_worker" {
  ami           = "ami-0bb6af715826253bf"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow-app.id]
  wait_for_fulfillment = true

  tags = {
    Name = var.COMPONENT
  }
}

resource "aws_ec2_tag" "ec2_name_tag" {
  resource_id = aws_spot_instance_request.cheap_worker.spot_instance_id
  key         = "Name"
  value       = var.COMPONENT
}