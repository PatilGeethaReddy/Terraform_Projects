// This variable is to set the AWS region that everything will be created in
variable "region" {
  type = string
}
variable "vpc_id" {
  type = string
} 
//This variable contains the database master user  
variable "username" {
  type = string
}
//This variable contains the database master password  
variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = false
}
variable "db-instance-class" {
  description = "The Database instance Type"
  type        = string
  }
  variable "db-instance-identifier" {
  description = "The Database Identifier "
  type        = string
  }
  variable "subnet_ids" {
    type = list
  }
  variable "kms_key_id" {
    type = string
  }
  variable "engine" {
    type = string
  }
  variable "engine_version" {
    type = string
  }
  variable "license_model" {
    type = string
  }
  variable "allocated_storage" {
    type = number
  }
  variable "max_allocated_storage" {
    type = number
  }
  variable "character_set_name" {
    type = string
  }
  variable "storage_type" {
    type = string
  }
  variable "publicly_accessible" {
    type = bool
    default = false
  }
  variable "skip_final_snapshot" {
    type = bool
    default = true
  }
  variable "storage_encrypted" {
    type = bool
    default = true
  }
  variable "parameter_group_name" {
    type = string
  }
  variable "backup_retention_period" {
    type = number
  }
  variable "db_name" {
    type = string
  }
  variable "enabled_cloudwatch_logs_exports" {
    type = list(string)
  }
  variable "aws_db_parameter_group" {
    type = string
  }
  variable "aws_db_parameter_group_family" {
    type = string
  }
variable "multi_az" {
  type = bool
}
variable "copy_tags_to_snapshot" {
  type = bool
}
variable "auto_minor_version_upgrade" {
  type = bool
}
variable "performance_insights_enabled" {
  type = bool
}
variable "db_subnet_group_name" {
  type = string
}
variable "zone_id" {
  type = string
}
variable "record_name" {
  type = string
}
variable "record_type" {
  type = string
}
variable "record_ttl" {
  type = number
}
variable "aws_security_group_name" {
  type = string
}
variable "vpc_cidr" {
  type = list(string)
}
variable "port" {
  type = number
}
variable "protocol" {
  type = string
}