provider "aws" {
  access_key = "insert AWS access key"
  secret_key = "insert AWS secret key"
  region = "us-east-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "my-awesome-bucket"
  acl    = "private"   ### Set it to "public-read" to make it public

  tags = {
    Name        = "My_bucket"
    Environment = "Dev"
  }
}
