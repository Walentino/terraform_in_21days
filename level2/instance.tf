data "aws_ami" "amazonlinux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}


resource "aws_instance" "public" {

  ami                         = data.aws_ami.amazonlinux.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "terra_main"
  vpc_security_group_ids      = [aws_security_group.public.id]
  subnet_id                   = aws_subnet.public[0].id
  user_data                   = file("user-data.sh")
  tags = {
    Name = "${var.env_code}-public"
  }
}

resource "aws_instance" "private" {

  ami                    = data.aws_ami.amazonlinux.id
  instance_type          = "t2.micro"
  key_name               = "terra_main"
  vpc_security_group_ids = [aws_security_group.private.id]
  subnet_id              = aws_subnet.private[0].id

  tags = {
    Name = "${var.env_code}-private"
  }
}

resource "aws_security_group" "public" {
  name        = "${var.env_code}-publicSG"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.mypublicip]

  }
  ingress {
    description = "HTTP from public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    name = "${var.env_code}-publicSG"
  }
}

resource "aws_security_group" "private" {
  name        = "${var.env_code}-privateSG"
  description = "Allow SSH from VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]

  }

  tags = {
    Name = "${var.env_code}-privateSG"
  }
}


