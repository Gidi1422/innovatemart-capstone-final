module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name    = "project-bedrock-cluster"
  cluster_version = "1.34"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # Enables the new EKS Access Entry API
  authentication_mode = "API_AND_CONFIG_MAP"

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # REDUNDANT LINE REMOVED: enable_cluster_creator_admin_permissions 
  # This was causing the "ResourceInUse" 409 error.

  access_entries = {
    valentine_user = {
      principal_arn     = "arn:aws:iam::557690612185:user/Valentine"
      type              = "STANDARD"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  eks_managed_node_groups = {
    main = {
      min_size     = 1
      max_size     = 4
      desired_size = 3 
      
      instance_types = ["t3.small"]

      tags = {
        ScalingUpdate = "Force-to-3"
      }
    }
  }

  tags = {
    Project = "Bedrock"
  }
}