resource "aws_s3_bucket" "final_build_artifacts" {
  # make sure bucket name is dns compliant
  bucket = lower(replace("${var.deploy_application_name}-artifacts", "_" , "-" ))
  acl = "private"

  tags = {
    Application = var.application_tag
    Contact = var.contact_tag
    ManagedBy = var.managedby_tag
  }
}