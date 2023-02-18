# resource "aws_vpc" "dev-vpc" {
#     cidr_block = "13.0.0.0/16"

#     tags = {
#       "Name" = "Dev-VPC"
#     }
  
# }

############################################################
#                   SERVER
############################################################

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "sonar"
  security_groups = [aws_security_group.server-sg.id]

  tags = {
    Name = "Server"
  }
}


##############################################################
#                      SECURITY GROUPS
##############################################################

resource "aws_security_group" "server-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.default.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [aws_vpc.main.cidr_block]
#     ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }
  ingress {
    description      = "Open for everywhere"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Open for World"
  }
}