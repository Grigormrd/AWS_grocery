variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "grocerymate"
}

variable "allowed_ssh_cidr" {
  description = "Your public IP / CIDR allowed to SSH (recommended: your_ip/32)"
  type        = string
}

variable "app_port" {
  description = "Application port exposed on EC2"
  type        = number
  default     = 5000
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ec2_key_name" {
  description = "Existing EC2 key pair name for SSH"
  type        = string
}

variable "avatars_bucket_name" {
  description = "Globally unique S3 bucket name for avatars"
  type        = string
}

variable "enable_alarm_notifications" {
  description = "If true, create SNS topic + email subscription for alarms"
  type        = bool
  default     = false
}

variable "alarm_email" {
  description = "Email address for SNS subscription (required if notifications enabled)"
  type        = string
  default     = ""
}
