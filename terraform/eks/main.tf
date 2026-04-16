terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# ── Existing VPC ──────────────────────────────────────────────────────────────

data "aws_vpc" "existing" {
  id = var.vpc_id
}

# ── EKS Cluster ───────────────────────────────────────────────────────────────

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = data.aws_vpc.existing.id
  subnet_ids                     = var.private_subnet_ids
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      name           = "${var.cluster_name}-node-group"
      instance_types = var.node_instance_types

      min_size     = var.node_min_size
      max_size     = var.node_max_size
      desired_size = var.node_desired_size

      disk_size = var.node_disk_size

      labels = {
        Environment = var.environment
      }

      tags = var.tags
    }
  }

  tags = var.tags
}
