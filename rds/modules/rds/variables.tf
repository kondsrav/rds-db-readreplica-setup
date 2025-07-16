variable "db_instance_identifier" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "multi_az" {
  type = bool
}

variable "master_username" {
  type = string
}

variable "secret_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}
variable "create_read_replica" {
  type        = bool
  description = "Whether to create a read replica"
  default     = false
}

variable "replica_instance_class" {
  type        = string
  description = "Instance class for read replica"
  default     = "db.m6g.large"
}

