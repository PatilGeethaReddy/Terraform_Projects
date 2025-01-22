//Here we are using existing db subnet group
data "aws_db_subnet_group" "db-subnet-group" {
  name = var.db_subnet_group_name
}
//Here we are using default kms key id 
data "aws_kms_key" "rds-kms-key-id" {
  key_id = var.kms_key_id
}
// create DB instance named "Amdocs99" 
resource "aws_db_instance" "Amdocs99"  {

//Here are the list of arguments we are using for creating RDS db instance
  db_name                = var.db_name
  identifier             = var.db-instance-identifier
  engine                 = var.engine   
  engine_version         = var.engine_version
  instance_class         = var.db-instance-class
  username               = var.username
  password               = var.db_password
  license_model          = var.license_model
  parameter_group_name   = var.parameter_group_name  
  publicly_accessible    = var.publicly_accessible
  skip_final_snapshot    = var.skip_final_snapshot
  allocated_storage      = var.allocated_storage    
  max_allocated_storage  = var.max_allocated_storage  
  vpc_security_group_ids = [aws_security_group.amp-rds-sg.id]
  character_set_name     = var.character_set_name
  storage_encrypted      = var.storage_encrypted
  storage_type           = var.storage_type
  backup_retention_period = var.backup_retention_period
  kms_key_id             = data.aws_kms_key.rds-kms-key-id.arn
  db_subnet_group_name   = data.aws_db_subnet_group.db-subnet-group.name
  multi_az               = var.multi_az
  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_kms_key_id = data.aws_kms_key.rds-kms-key-id.arn
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
   }
// Creating db parameter group
  resource "aws_db_parameter_group" "amdocs-amp" {
  name   = var.aws_db_parameter_group
  family = var.aws_db_parameter_group_family
}
//DNS record creation for rds
resource "aws_route53_record" "rds_record" {
zone_id  = var.zone_id
name    = var.record_name                                                 
type    = var.record_type
ttl     = var.record_ttl
records = [aws_db_instance.amdocs99.endpoint] 
}