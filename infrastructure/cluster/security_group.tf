# TODO restrict all security groups to VPN ip address range

resource "aws_security_group" "this" {
  name = "${var.name}-${var.environment_tag}-v2"
  description = "allow ssh & rdp"
  vpc_id = var.vpc_id

  ingress {
    description = "TLS"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    description = "FireWS"
    from_port = 4001
    to_port = 4001
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    description = "ICMP"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [
      "10.0.1.0/24"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-${var.environment_tag}"
    Application = var.name
    Contact = var.contact_tag
    ManagedBy = var.managedby_tag
    Environment = var.environment_tag
  }
}