data "aws_availability_zones" "available" {}

provider "aws" {
    region = "ap-south-1"
    access_key = "provide your key"
    secret_key = "provide your key" 
}

resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
     "Name", "terraform-eks-demo-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "demo" {
  count = 3

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.demo.id}"

  tags = "${
    map(
     "Name", "terraform-eks-demo-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}


# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "demo-key"
  public_key = "${file("${var.key_path}")}"
}
