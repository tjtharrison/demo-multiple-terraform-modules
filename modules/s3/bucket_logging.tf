resource "aws_s3_bucket_logging" "example" {
  count  = var.access_logging ? 1 : 0
  bucket = aws_s3_bucket.this.id

  # If bucket specified, otherwise use created
  target_bucket = var.access_logging_bucket == null ? aws_s3_bucket.access_logs[0].id : var.access_logging_bucket
  target_prefix = "log/${var.bucket_name}"
}

resource "aws_s3_bucket" "access_logs" {
  count  = var.access_logging ? var.access_logging_bucket == null ? 1 : 0 : 0
  bucket = var.access_logging_bucket
}
