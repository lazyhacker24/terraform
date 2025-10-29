
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "flask_express_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = file("user_data.sh")

  tags = {
    Name = "Flask-Express-Instance"
  }

  security_groups = [aws_security_group.app_sg.name]
}

resource "aws_security_group" "app_sg" {
  name        = "flask-express-sg"
  description = "Allow ports 22, 3000, 5000"

  ingress = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Express"
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Flask"
      from_port   = 5000
      to_port     = 5000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

output "instance_public_ip" {
  value = aws_instance.flask_express_instance.public_ip
}
