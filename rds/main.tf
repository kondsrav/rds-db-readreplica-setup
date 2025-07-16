module "rds" {
  source = "./modules/rds"

  db_instance_identifier   = var.db_instance_identifier
  instance_class           = var.instance_class
  allocated_storage        = var.allocated_storage
  multi_az                 = var.multi_az
  master_username          = var.master_username
  secret_name              = var.secret_name
  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  vpc_security_group_ids   = var.vpc_security_group_ids
create_read_replica      = var.create_read_replica
  replica_instance_class   = var.replica_instance_class
}
