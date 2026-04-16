output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "EKS cluster Kubernetes version"
  value       = module.eks.cluster_version
}

output "vpc_id" {
  description = "VPC ID"
  value       = data.aws_vpc.existing.id
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = var.private_subnet_ids
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = var.public_subnet_ids
}

output "node_group_name" {
  description = "Node group name"
  value       = "${var.cluster_name}-node-group"
}
