output "ec2_public_ip" {
  value       = aws_instance.app.public_ip
  description = "Public IP of the EC2 instance"
}

output "avatars_bucket_name" {
  value       = aws_s3_bucket.avatars.bucket
  description = "S3 bucket name for avatars"
}

output "cloudwatch_dashboard_name" {
  value       = aws_cloudwatch_dashboard.main.dashboard_name
  description = "CloudWatch dashboard name"
}

output "cpu_alarm_name" {
  value       = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
  description = "CloudWatch CPU alarm name"
}
