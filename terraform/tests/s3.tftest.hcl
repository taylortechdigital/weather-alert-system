# s3_bucket_test.tftest.hcl

run "s3_bucket_exists_and_is_encrypted" {
  command = plan

  variables {
    logs_bucket_name = "expected-logs-bucket"  # Set this to the bucket name you expect (or override via terraform.tfvars)
  } 
  # Assert that the S3 logs bucket has the expected bucket name.
  assert {
    condition     = aws_s3_bucket.logs[0].bucket == var.logs_bucket_name
    error_message = "S3 logs bucket name did not match expected. Got: ${aws_s3_bucket.logs[0].bucket}"
  }

  # Assert that the S3 logs bucket encryption configuration is set to AES256.
  assert {
    condition     = aws_s3_bucket_server_side_encryption_configuration.logs_encryption[0].rule[0].apply_server_side_encryption_by_default.sse_algorithm == "AES256"
    error_message = "Expected the S3 logs bucket encryption to be set to AES256."
  }
}
