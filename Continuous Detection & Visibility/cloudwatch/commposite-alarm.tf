# An alarm (composite or metric) cannot be destroyed when there are other composite alarms depending on it.
#Core syntax
/* ----------------------------------------------
ALARM(alarm-name)
OK(alarm-name)
NOT ALARM(alarm-name)

Combine with:
AND
OR
parentheses ()

#   Trigger only when multiple independent failure signals are active.
#   This reduces alert fatigue and represents a true service degradation.
-------------------------------------------------*/

resource "aws_cloudwatch_composite_alarm" "service_degraded" {
  alarm_name        = "service-degraded-composite"
  alarm_description = "Triggers when CPU is high AND ALB is returning 5XX errors"

  alarm_rule = <<EOF
ALARM(${aws_cloudwatch_metric_alarm.ec2_high_cpu.alarm_name}) AND
ALARM(${aws_cloudwatch_metric_alarm.alb_5xx.alarm_name})
EOF

  alarm_actions = [
    aws_sns_topic.critical_alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.critical_alerts.arn
  ]
}
