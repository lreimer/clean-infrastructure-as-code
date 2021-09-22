terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "aurora_serverless" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "5.0.0"

  name = var.cluster_name

  engine            = "aurora-postgresql"
  engine_mode       = "serverless"
  storage_encrypted = true

  vpc_id  = var.vpc_id
  subnets = var.database_subnets

  create_security_group      = true
  security_group_description = ""
  allowed_cidr_blocks        = var.allowed_cidr_blocks
  port                       = var.port

  database_name          = var.database_name
  username               = var.username
  create_random_password = true

  replica_scale_enabled = false
  replica_count         = 0

  monitoring_interval          = var.monitoring_interval
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  auto_minor_version_upgrade   = true
  allow_major_version_upgrade  = false

  deletion_protection = var.deletion_protection
  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.aurora_serverless.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_serverless.id

  scaling_configuration = {
    auto_pause               = true
    min_capacity             = var.min_capacity
    max_capacity             = var.max_capacity
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

  tags = var.tags
}

resource "aws_db_parameter_group" "aurora_serverless" {
  name        = "${var.cluster_name}-postgres-db-parameter-group"
  family      = "aurora-postgresql10"
  description = "${var.cluster_name}-postgres-db-parameter-group"
  tags        = var.tags
}

resource "aws_rds_cluster_parameter_group" "aurora_serverless" {
  name        = "${var.cluster_name}-postgres-cluster-parameter-group"
  family      = "aurora-postgresql10"
  description = "${var.cluster_name}-postgres-cluster-parameter-group"
  tags        = var.tags
}