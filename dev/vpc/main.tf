resource "aws_vpc" "dev-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name       = "dev-vpc"
    managed_by = var.managed_by
  }
}
