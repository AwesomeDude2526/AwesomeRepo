provider "aws" {
  access_key = "insert AWS access key"
  secret_key = "insert AWS secret key"
  region = "us-east-1"
}

resource "aws_instance" "pikachu" {
  ami = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
  
  tags = {
    Name = "LinuxEC2"
}
}
