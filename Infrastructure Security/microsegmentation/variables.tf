variable "vpc_id" {
  description = "VPC ID for security group placement"
  type        = string
}

output "cidr_block" {
  value = aws_vpc.secure_vpc.cidr_block
}
