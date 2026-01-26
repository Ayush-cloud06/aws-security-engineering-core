# To enable AWS organizations
resource "aws_organizations_organization" "main" {
  aws_service_access_principals = ["guardduty.amazonaws.com"]
  feature_set                   = "ALL"
}

# GuardDuty admin account
resource "aws_guardduty_organization_admin_account" "main" {
  depends_on       = [aws_organizations_organization.main]
  admin_account_id = "123456789012" # security account
}

# Auto-enroll accounts into GuardDuty
resource "aws_guardduty_organization_configuration" "main" {
  detector_id                      = aws_guardduty_detector.main.id
  auto_enable_organization_members = "ALL"

  datasources {
    s3_logs {
      auto_enable = true
    }

    kubernetes {
      audit_logs {
        enable = true
      }
    }

    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          auto_enable = true
        }
      }
    }
  }
}

# Org-wide feature auto-enable
resource "aws_guardduty_organization_configuration_feature" "eks_runtime_monitoring" {
  detector_id = aws_guardduty_detector.main.id
  name        = "EKS_RUNTIME_MONITORING"
  auto_enable = "ALL"

  additional_configuration {
    name        = "EKS_ADDON_MANAGEMENT"
    auto_enable = "NEW"
  }
}

