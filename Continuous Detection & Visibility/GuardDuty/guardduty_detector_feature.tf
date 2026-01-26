resource "aws_guardduty_detector_feature" "s3_protection" {

  # Deleting this resource does not disable the detector feature,
  # the resource in simply removed from state instead.

  detector_id = aws_guardduty_detector.main.id
  name        = "S3_DATA_EVENTS"
  status      = "ENABLED"

}

resource "aws_guardduty_detector_feature" "eks_protection" {
  detector_id = aws_guardduty_detector.main.id
  name        = "EKS_RUNTIME_MONITORING"
  status      = "ENABLED"

  /* To enable GuardDuty Extended Threat Detection for EKS,
   you need at least one of these features enabled: 
   EKS Protection or Runtime Monitoring. For maximum detection coverage, 
   enabling both is recommended to enhance detection capabilities. */

  additional_configuration {
    name   = "EKS_ADDON_MANAGEMENT"
    status = "ENABLED"
  }
}

/*
name - (Required) The name of the detector feature. Valid values: S3_DATA_EVENTS, EKS_AUDIT_LOGS, 
EBS_MALWARE_PROTECTION, RDS_LOGIN_EVENTS, EKS_RUNTIME_MONITORING, LAMBDA_NETWORK_LOGS, RUNTIME_MONITORING. 
Only one of two features EKS_RUNTIME_MONITORING or RUNTIME_MONITORING can be added, adding both features will cause an error
*/
