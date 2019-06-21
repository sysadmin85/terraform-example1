output "aws_vpc_id" {
    description = "AWS VPC ID"
    value = "${aws_vpc.demo.id}"
}

output "private_subnet_ids" {
    description = "List with IDs of the private subnets"
    value = "${aws_subnet.demo.*.id}"
}

output "iam_role_id" {
  value = "${aws_iam_role.demo-cluster-iam.id}"
}

