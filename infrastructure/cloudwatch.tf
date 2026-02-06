locals {
  dashboard_name = "${var.project_name}-dashboard"
  alarm_name     = "${var.project_name}-ec2-cpu-high"
}

resource "aws_sns_topic" "alarms" {
  count = var.enable_alarm_notifications ? 1 : 0
  name  = "${var.project_name}-alarms"
  tags  = local.tags
}

resource "aws_sns_topic_subscription" "email" {
  count     = var.enable_alarm_notifications ? 1 : 0
  topic_arn = aws_sns_topic.alarms[0].arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = local.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Triggers when EC2 CPU > 70% for 10 minutes"

  dimensions = {
    InstanceId = aws_instance.app.id
  }

  alarm_actions = var.enable_alarm_notifications ? [aws_sns_topic.alarms[0].arn] : []
  ok_actions    = var.enable_alarm_notifications ? [aws_sns_topic.alarms[0].arn] : []

  tags = local.tags
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = local.dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          title   = "EC2 CPU Utilization"
          period  = 300
          stat    = "Average"
          metrics = [["AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.app.id]]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title   = "EC2 Network In/Out"
          period  = 300
          stat    = "Average"
          metrics = [
            ["AWS/EC2", "NetworkIn", "InstanceId", aws_instance.app.id],
            [".", "NetworkOut", ".", "."]
          ]
        }
      }
    ]
  })
}
