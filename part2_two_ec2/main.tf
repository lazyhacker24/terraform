provider "aws" {
  region = var.aws_region
}

# ---------- VPC ----------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "flask-express-vpc" }
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "main-igw" }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}

# ---------- Security Group ----------
resource "aws_security_group" "main_sg" {
  name        = "flask-express-sg"
  description = "Allow SSH, Flask (5000), Express (3000)"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Flask"
      from_port   = 5000
      to_port     = 5000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Express"
      from_port   = 3000
      to_port     = 3000
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

# ---------- Flask Instance ----------
resource "aws_instance" "flask_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet.id
  key_name      = var.key_name
  security_groups = [aws_security_group.main_sg.id]
  user_data     = file("user_data_flask.sh")

  tags = { Name = "Flask-Backend" }
}

# ---------- Express Instance ----------
resource "aws_instance" "express_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet.id
  key_name      = var.key_name
  security_groups = [aws_security_group.main_sg.id]
  user_data     = file("user_data_express.sh")

  tags = { Name = "Express-Frontend" }
}

output "flask_public_ip" {
  value = aws_instance.flask_instance.public_ip
}

output "express_public_ip" {
  value = aws_instance.express_instance.public_ip
}
