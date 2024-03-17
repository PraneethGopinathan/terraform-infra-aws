resource "aws_s3_bucket" "bucket" {
  bucket = var.name
  tags = {
    Name       = "bucket"
    managed_by = var.managed_by
  }
}