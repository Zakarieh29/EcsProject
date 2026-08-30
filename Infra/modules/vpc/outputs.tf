output "vpc_id" {
  value = aws_vpc.custom_vpc
}

output "subnet-1_id" {
  value = aws_subnet.subnet-1.id
}

output "subnet-2_id" {
  value = aws_subnet.subnet-2.id
}