output "prod_eks_cluster_name" {
  value       = aws_eks_cluster.prod_eks_cluster.name
  description = "Prod EKS Cluster Name"
}

output "prod_eks_cluster_endpoint" {
  value       = aws_eks_cluster.prod_eks_cluster.endpoint
  description = "Prod EKS Cluster Endpoint"
}

output "prod_eks_cluster_ca_certificate" {
  value       = aws_eks_cluster.prod_eks_cluster.certificate_authority[0].data
  description = "Prod EKS Cluster Certificate"
}
