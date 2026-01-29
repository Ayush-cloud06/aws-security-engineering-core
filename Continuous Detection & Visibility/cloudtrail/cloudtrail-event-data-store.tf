# KMS – ENCRYPTION KEY FOR CLOUDTRAIL LAKE
#This key encrypts all events stored in the Event Data Store. Required for compliance-grade setups.

resource "aws_kms_key" "cloudtrail_lake_key" {
  description         = "KMS key for cloudTrail Event Data Store (Lake)"
  enable_key_rotation = true
}

# CloudTrail event data store - CloudTrail Lake 

resource "aws_cloudtrail_event_data_store" "security_forensics_store" {
  name = "security-forensics-event-store"

  # EXTENDABLE_RETENTION_PRICING → cheap ingest, flexible retention
  # FIXED_RETENTION_PRICING     → predictable long-term storage pricing
  billing_mode = "EXTENDABLE_RETENTION_PRICING"

  multi_region_enabled           = true
  organization_enabled           = true
  retention_period               = 180
  termination_protection_enabled = true

  # Advance Event Selectors

  #  ----------- Log all s3 object-level activity -----------
  advanced_event_selector {

    name = "Log all s3 object access"

    # Only Data Events
    field_selector {
      field  = "eventCategory"
      equals = ["Data"]
    }

    # Only s3 object

    field_selector {
      field  = "resources.type"
      equals = ["AWS::S3::object"]
    }
  }


  # ------- Log all Lambda function invocations --------
  advanced_event_selector {
    name = "Log all Lambda invocations"

    field_selector {
      field  = "eventCategory"
      equals = ["Data"]
    }

    field_selector {
      field  = "resources.type"
      equals = ["AWS::Lambda::Function"]
    }
  }

  # ------- Log DynamoDB writes for a specific table -------
  advanced_event_selector {
    name = "Log DynamoDB PutItem on critical table"

    field_selector {
      field  = "eventCategory"
      equals = ["Data"]
    }

    field_selector {
      field  = "resources.type"
      equals = ["AWS::DynamoDB::Table"]
    }

    field_selector {
      field  = "eventName"
      equals = ["PutItem"]
    }

    field_selector {
      field = "resources.ARN"
      equals = [
        "arn:aws:dynamodb:ap-south-1:123456789123:table/critical-transactions"
      ]
    }
  }

  # TAGS – ALWAYS TAG SECURITY ASSETS
  tags = {
    Project     = "cloud-security-core"
    Component   = "cloudtrail-lake"
    Environment = "lab"
    Owner       = "security-team"
    Criticality = "high"
  }
}


