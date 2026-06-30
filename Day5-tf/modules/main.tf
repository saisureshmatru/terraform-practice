resource "aws_instance" "ec2" {
  ami = "ami-0db56f446d44f2f09" 
  instance_type ="m7i-flex.large"
  lifecycle {
    prevent_destroy =false
  }
  tags ={
    Name ="ser"
  } 
}