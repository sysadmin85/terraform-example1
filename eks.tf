resource "aws_eks_cluster" "demo" {
    count = 3
    name            = "${var.eks-cluster-demo}"
    role_arn        = "${aws_iam_role.demo-cluster-iam.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.demo-cluster-sg.id}"]
    subnet_ids         = ["${aws_subnet.demo.0.id}", "${aws_subnet.demo.1.id}", "${aws_subnet.demo.2.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSServicePolicy",
  ]
}


locals {
  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.demo.0.endpoint}
    certificate-authority-data: ${aws_eks_cluster.demo.0.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.eks-cluster-demo}"
KUBECONFIG
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}


