# AWS and Terraform
project    = "dev"
managed_by = "terraform"
region     = "ap-south-1"

#VPC
vpc_name = "dev-vpc"

#S3
s3_bucket_name = "dev-s3"

# EKS
eks_iam_name                 = "eks_cluster_iam"
eks_cluster_name             = "dev"
eks_cluster_version          = "1.29"
eks_node_group_iam_name      = "eks-node-group-iam-general"
eks_node_group_name          = "eks-nodes-general"
eks_node_group_desired_size  = 1
eks_node_group_min_size      = 1
eks_node_group_max_size      = 2
eks_node_group_ami_type      = "AL2_x86_64"
eks_node_group_capacity_type = "ON_DEMAND"
eks_node_group_disk_size     = 80
eks_node_group_instance_type = "t3.xlarge"

# RDS
rds_allocated_storage = 20
rds_engine            = "postgres"
rds_engine_version    = "15.5"
rds_instance_class    = "db.t3.small"
rds_identifier        = "test-1"
rds_db_name           = "devdb"
rds_username          = "postgres"
rds_parameter_name    = "-rds-parameter-group"
rds_parameter_family  = "postgres15"
