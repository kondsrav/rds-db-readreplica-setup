variable "db_instance_identifier" {
  type        = string
  description = "DB instance identifier"
}

variable "instance_class" {
  type        = string
  description = "Instance class for RDS"
}

variable "allocated_storage" {
  type        = number
  description = "Storage size in GiB"
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ deployment"
}

variable "master_username" {
  type        = string
  description = "Master DB username"
}

variable "secret_name" {
  type        = string
  description = "Name for the secret in Secrets Manager"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs"
}
variable "create_read_replica" {
  type        = bool
  description = "Whether to create a read replica"
}

variable "replica_instance_class" {
  type        = string
  description = "Instance class for read replica"
}

