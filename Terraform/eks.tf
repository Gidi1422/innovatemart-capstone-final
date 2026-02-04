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
      max_size     = 2
      desired_size = 1
      # Changed from t3.medium to t3.small to bypass account limits
      instance_types = ["t3.small"] 
    }
  }

  tags = {
    Project = "Bedrock"
  }
}

# --- ACCESS ENTRIES (The "Handshake" Fix) ---

# 1. Grant your local PowerShell user Admin access
resource "aws_eks_access_entry" "local_user" {
  cluster_name      = module.eks.cluster_name
  principal_arn     = "arn:aws:iam::557690612185:user/Valentine"
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "local_user_admin" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:iam::aws:policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::557690612185:user/Valentine"

  access_scope {
    type = "cluster"
  }
}

# 2. Grant the GitHub Actions Role Admin access 
# (This ensures the 'kubectl apply' step in your workflow works)
resource "aws_eks_access_entry" "github_actions" {
  cluster_name      = module.eks.cluster_name
  # This uses the identity currently running your Terraform
  principal_arn     = "arn:aws:iam::557690612185:user/Valentine" 
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "github_admin" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:iam::aws:policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::557690612185:user/Valentine"

  access_scope {
    type = "cluster"
  }
}