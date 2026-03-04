variable "vpc_id" {
  description = "VPC ID for security group placement"
  type        = string
}

output "cidr_block" {
  value = aws_vpc.secure_vpc.cidr_block
}

variable "app_subnet_ids" {
  description = "Application subnet IDs"
  type        = list(string)
}
