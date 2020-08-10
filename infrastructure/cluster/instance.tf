resource "aws_instance" "this" {
  ami = var.ami_id
  instance_type = var.instance_type

  # this is optional, but needed if you want to ssh into your ec2 instance
  # here I have manually created a key pair in the console and I'm supplying the
  # name.
  key_name = var.key_pair_name

  user_data = file("${path.module}/install.sh")

  vpc_security_group_ids = [
    aws_security_group.this.id]

  subnet_id = var.subnet_id

  iam_instance_profile = aws_iam_instance_profile.this.id

  tags = {
    Name = "${var.name}-${var.environment_tag}"
    Application = var.name
    Contact = var.contact_tag
    ManagedBy = var.managedby_tag
    Environment = var.environment_tag
  }

  count = var.size
}