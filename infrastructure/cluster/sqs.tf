resource "aws_sqs_queue" "terraform_queue" {
  name                      = "${var.name}.fifo"
  fifo_queue = true
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10


  tags = {
    Contact = var.contact_tag
    ManagedBy = var.managedby_tag
    Environment = var.environment_tag
  }
}