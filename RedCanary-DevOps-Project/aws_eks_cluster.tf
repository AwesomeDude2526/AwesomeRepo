# EKS Cluster
resource "aws_eks_cluster" "prod_eks_cluster" {
  name     = "${var.project}-prod_eks_cluster"
  role_arn = aws_iam_role.prod_eks_cluster.arn

  vpc_config {
    subnet_ids = flatten([aws_subnet.public_subnet[*].id, aws_subnet.private_subnet[*].id])
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}


# EKS Cluster IAM Role
resource "aws_iam_role" "prod_eks_cluster" {
  name = "${var.project}-prod-eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.prod_eks_cluster.name
}


# EKS Cluster Security Group
resource "aws_security_group" "prod_eks_cluster_sg" {
  name        = "${var.project}-prod-eks-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "${var.project}-prod-eks-cluster-sg"
  }
}

resource "aws_security_group_rule" "cluster_inbound" {
  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.prod_eks_cluster_sg.id
  source_security_group_id = aws_security_group.prod_eks_cluster_sg.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_outbound" {
  description              = "Allow cluster API Server to communicate with the worker nodes"
  from_port                = 1024
  protocol                 = "tcp"
  security_group_id        = aws_security_group.prod_eks_cluster_sg.id
  source_security_group_id = aws_security_group.prod_eks_cluster_sg.id
  to_port                  = 65535
  type                     = "egress"
}

# EKS Node Groups
resource "aws_eks_node_group" "prod-eks-node-group" {
  cluster_name    = aws_eks_cluster.prod_eks_cluster.name
  node_group_name = var.project
  node_role_arn   = aws_iam_role.prod_eks_cluster.arn
  subnet_ids      = aws_subnet.private_subnet[*].id

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}

# EKS Node IAM Role
resource "aws_iam_role" "prod_eks_node" {
  name = "${var.project}-Worker-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.prod_eks_node.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.prod_eks_node.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.prod_eks_node.name
}


# EKS Node Security Group
resource "aws_security_group" "prod_eks_nodes" {
  name        = "${var.project}-prod_eks_node-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = aws_vpc.prod_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-prod-eks-node-sg"
  }
}

resource "aws_security_group_rule" "prod_eks_nodes_internal" {
  description              = "Allow nodes to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.prod_eks_nodes.id
  source_security_group_id = aws_security_group.prod_eks_nodes.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "nodes_cluster_inbound" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.prod_eks_nodes.id
  source_security_group_id = aws_security_group.prod_eks_cluster_sg.id
  to_port                  = 65535
  type                     = "ingress"
}
