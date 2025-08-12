
resource "aws_instance" "example" {
  ami           = var.ami.id  # Amazon Linux 2 AMI for us-east-1
  instance_type = "t3.micro"              # Free tier eligible

  tags = {
    Name = "server"
  }
}
