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
  instance_type = "t2.micro"
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

resource "aws_ec2_tag" "ec2_monitor_tag" {
  resource_id = aws_spot_instance_request.cheap_worker.spot_instance_id
  key         = "Monitor"
  value       = var.MONITOR
}

resource "null_resource" "ansible-apply" {
    depends_on = [ aws_route53_record.www ]
    triggers = {
      abc = timestamp()
    }
  provisioner "remote-exec" {
    connection {
      host = aws_spot_instance_request.cheap_worker.private_ip
      user = "root"
      password = "DevOps321"
    }
    inline = [ 
        "yum install ansible -y",
        "ansible-pull -U https://github.com/raghudevopsb62/ansible roboshop-pull.yml -e COMPONENT=${var.COMPONENT} -e ENV=dev"
     ]
  }
}