
# -----------------------------------------------------------------------------
# CloudWatch Metric Alarm
# Purpose:
#   Detect sustained high CPU utilization on EC2 instances.
#   This alarm represents a basic performance + availability signal.
# -----------------------------------------------------------------------------

resource "aws_cloudwatch_metric_alarm" "ec2_high_cpu" {
  alarm_name          = "ec2-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  threshold           = 80
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  period              = 120
  statistic           = "Average"
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name          = "alb-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 10
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  period              = 60
  statistic           = "Sum"
}
