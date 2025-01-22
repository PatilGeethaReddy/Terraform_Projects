//create an EFS file system named efs
resource "aws_efs_file_system" "efs" {
   creation_token = var.efs-file-name
   performance_mode = var.performance_mode
   throughput_mode = var.throughput_mode
   encrypted = true
   lifecycle_policy {
     transition_to_ia = var.transition_to_ia
   }
 tags = {
     Name = var.efs-file-name
   }
 }
 resource "aws_efs_backup_policy" "backup-policy" {
  file_system_id = aws_efs_file_system.efs.id

  backup_policy {
    status = var.backup_policy_status
  }
 }
 resource "aws_efs_mount_target" "efs-mt" {
   count = length(var.subnet_ids)
   //file sytem id 
   file_system_id  = aws_efs_file_system.efs.id
   //Adding subnet ids 
   subnet_id = var.subnet_ids[count.index] 
   //It holds security group id
   security_groups =[aws_security_group.efs-sg.id]    
 }























