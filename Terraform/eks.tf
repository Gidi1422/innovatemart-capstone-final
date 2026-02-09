module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name    = "project-bedrock-cluster"
  cluster_version = "1.34"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # REQUIRED: This allows the Access Entry resources below to work
  authentication_mode = "API_AND_CONFIG_MAP"

  # Requirement 4.4: Control Plane Logging
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  eks_managed_node_groups = {
    main = {
      min_size     = 1
      max_size     = 4
      # FIXED: Using 3 nodes to solve the "Insufficient memory" and "Too many pods" errors
      desired_size = 3 
      
      # FIXED: Staying with t3.small to avoid the vCPU Quota error we saw before
      instance_types = ["t3.small"] 
    }
  }

  tags = {
    Project = "Bedrock"
  }
}

# --- CONSOLIDATED ACCESS ENTRIES ---

resource "aws_eks_access_entry" "cluster_admin" {
  cluster_name      = module.eks.cluster_name
  principal_arn     = "arn:aws:iam::557690612185:user/Valentine"
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_policy" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::557690612185:user/Valentine"

  access_scope {
    type = "cluster"
  }
}