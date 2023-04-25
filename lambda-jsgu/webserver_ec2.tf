data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "KAL_DevOps_PoC"
    workspaces = {
      name = "tfcb-jsgu-vpc"
    }
  }
}

# Terraform >= 0.12
resource "aws_instance" "foo" {
  # ...
  subnet_id = data.terraform_remote_state.vpc.outputs.pub_subnet_id
}


resource "aws_instance" "webserver" {
  ami                    = "ami-081511b9e3af53902"
  instance_type          = "t3.micro"
  key_name               = "seoul"
  subnet_id              = data.terraform_remote_state.vpc.outputs.pub_subnet_id
  vpc_security_group_ids = ["${aws_security_group.webserversg.id}"]
  user_data              = <<-EOF
                           #!/bin/bash
                           sudo yum install -y httpd
                           echo "Honglab WebServer" > /var/www/html/index.html
                           sudo systemctl start httpd
                           sudo systemctl enable httpd
                           EOF

  tags = {
    Name = "webserver"
  }

  depends_on = [data.terraform_remote_state.vpc.outputs.igw_id]
}

resource "aws_security_group" "webserversg" {
  name        = "webserversg"
  description = "allow 22, 80"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
}

resource "aws_security_group_rule" "websg_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserversg.id
  description       = "ssh"
}

resource "aws_security_group_rule" "websg_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserversg.id
  description       = "http"
}

resource "aws_security_group_rule" "websg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserversg.id
  description       = "outbound"
}