resource "aws_s3_bucket" "b" {
  bucket = "mybucket-codeaprendiz-26071994"
  acl    = "private"

  tags = {
    Name = "mybucket-codeaprendiz-26071994"
  }
}

