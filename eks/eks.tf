#https://antonputra.com/amazon/create-aws-eks-fargate-using-terraform/#deploy-app-to-aws-fargate
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.3"

  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  enable_irsa = var.irsa
  cluster_addons = { #https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon
    coredns = {
      most_recent = var.coredns
      timeouts = {
        create = "15m"
        delete = "15m"
      } 
    }
    kube-proxy = {
      most_recent = var.kube_proxy
    }
    vpc-cni = {
      most_recent = var.vpc_cni
      service_account_role_arn = module.vpc_cni.iam_role_arn
    }
    aws-ebs-csi-driver = { 
      most_recent = var.aws-ebs-csi-driver #Required to install EBS CSI Driver needed for provisioning EBS volumes for persistent volume storage config. This is also tied to the service account created separately
      service_account_role_arn = module.ebs_csi_role.iam_role_arn
    }
  }

  eks_managed_node_groups = {
    db = {
      Name = "SSJ"
      instance_types = var.goku
      subnet_ids = module.vpc.private_subnets
      ebs_optimized = var.krillin
      disk_size = var.tien
      use_custom_launch_template = var.use_custom_launch_template
      remote_access = {
                        ec2_ssh_key  = var.piccolo
                      }

      min_size     = var.vegeta
      max_size     = var.gohan
      desired_size = var.frieza
      update_config = {
                        max_unavailable = var.broly
                      }
      
    }
  }

   fargate_profile_defaults = {
    iam_role_additional_policies = {
      additional = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
    }
  }

  fargate_profiles = {
    arsenal = {
      name = "arsenal"
      selectors = [
        {
          namespace = "arsenal"
          labels = {
              app = "arsenal"
            }
        }
      ]
      timeouts = {
        create = "15m"
        delete = "15m"
      }
    }
    arsenalspring = {
      name = "arsenalspring"
      selectors = [
        {
          namespace = "springapp"
          labels = {
              app = "springapp" #app.kubernetes.io/name=springapp
            }
        }
      ]
      timeouts = {
        create = "15m"
        delete = "15m"
      }
    }
  }

  enable_cluster_creator_admin_permissions = true
  
  tags = {
    "kubernetes.io/cluster/DB" = "owned"
    name = "kubernetes.io/cluster/DB"
  }
}

