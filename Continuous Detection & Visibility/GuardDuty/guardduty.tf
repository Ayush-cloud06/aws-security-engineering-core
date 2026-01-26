# Main resource that turns on GuardDuty in the current region 
# Note : Deleting this resource is equivalent to "disabling" 
#       GuardDuty for an AWS region, which removes all existing findings. 
#       You can set the enable attribute to false to instead "suspend" monitoring and 
#       feedback reporting while keeping existing data ~ Official docs ver 6.28.0

resource "aws_guardduty_detector" "main" {
  enable = true

  # To enable extra protection features

  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = false
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = true
        }
      }
    }
  }
}

# we can also import by using import block

# import {
# to = aws_guardduty_detector.MyDetector
# id = "00b00fd5aecc0ab60a708659477e9617"
# }
