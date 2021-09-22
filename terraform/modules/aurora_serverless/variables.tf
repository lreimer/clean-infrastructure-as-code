variable "cluster_name" {
  description = "Name for Aurora DB cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to use"
  type        = string
}

variable "database_subnets" {
  description = "A list of database subnets to use"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "A list of allowed CIDR ranges allowed to access the database (e.g. the private subnet ranges)"
  type        = list(string)
}

variable "database_name" {
  description = "Name of the initial database"
  type        = string
  default     = ""
}

variable "username" {
  description = "Name of the master user"
  type        = string
  default     = "postgres"
}

variable "port" {
  description = "The database port"
  type        = number
  default     = 5432
}

variable "min_capacity" {
  description = "The minimum ACU"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "The maximum ACU"
  type        = number
  default     = 4
}

variable "monitoring_interval" {
  description = "The monitoring interval in seconds"
  type        = number
  default     = 60
}

variable "backup_retention_period" {
  description = "The backup retention period in days"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "The preferred backup window time slot"
  type        = string
  default     = "02:00-03:00"
}

variable "preferred_maintenance_window" {
  description = "The preferred time slot for DB maintenance"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "deletion_protection" {
  description = "If the DB instance should be deletion protection enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to set on the Aurora DB cluster and associated resources"
  type        = map(string)
  default     = {}
}
