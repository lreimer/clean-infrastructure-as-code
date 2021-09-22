output "cluster_id" {
  description = "The ID of the cluster"
  value       = module.aurora_serverless.rds_cluster_id
}

output "cluster_arn" {
  description = "The ARN of the cluster"
  value       = module.aurora_serverless.rds_cluster_arn
}

output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.aurora_serverless.rds_cluster_endpoint
}

output "cluster_port" {
  description = "The cluster port"
  value       = module.aurora_serverless.rds_cluster_port
}

output "cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = module.aurora_serverless.rds_cluster_instance_ids
}

output "cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.aurora_serverless.rds_cluster_instance_endpoints
}

output "cluster_hosted_zone_id" {
  description = "Route53 hosted zone id of the created cluster"
  value       = module.aurora_serverless.rds_cluster_hosted_zone_id
}

output "cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = var.database_name
}

output "cluster_master_username" {
  description = "The master username"
  value       = module.aurora_serverless.rds_cluster_master_username
  sensitive   = true
}

output "cluster_master_password" {
  description = "The master password"
  value       = module.aurora_serverless.rds_cluster_master_password
  sensitive   = true
}
