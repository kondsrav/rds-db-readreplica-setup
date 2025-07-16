resource "random_password" "rds_password" {
  length  = 20
  special = true
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name        = var.secret_name
  description = "RDS credentials for ${var.db_instance_identifier}"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.master_username
    password = random_password.rds_password.result
  })
}

resource "aws_db_subnet_group" "rds" {
  name       = "${var.db_instance_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.db_instance_identifier}-subnet-group"
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier              = var.db_instance_identifier
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  engine                  = "postgres"
  engine_version          = "16.6"
  username                = var.master_username
  password                = random_password.rds_password.result
  multi_az                = var.multi_az
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 7  # ✅ enable automated backups (required for read replica)

  tags = {
    Name = var.db_instance_identifier
  }
}

resource "aws_db_instance" "read_replica" {
  count                      = var.create_read_replica ? 1 : 0
  identifier                 = "${var.db_instance_identifier}-replica"
  instance_class             = var.replica_instance_class
  replicate_source_db        = aws_db_instance.rds_instance.arn
  publicly_accessible        = false
  db_subnet_group_name       = aws_db_subnet_group.rds.name
  vpc_security_group_ids     = var.vpc_security_group_ids
  skip_final_snapshot        = true
  deletion_protection        = false

  tags = {
    Name = "${var.db_instance_identifier}-replica"
  }
}
