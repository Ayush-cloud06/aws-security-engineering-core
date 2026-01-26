resource "aws_guardduty_filter" "myfilter" {
  name        = "myfilter"
  action      = "ARCHIVE"
  detector_id = aws_guardduty_detector.main.id
  rank        = 1

  finding_criteria {
    criterion {
      field  = "region"
      equals = ["ap-south-1"]
    }
    criterion {
      field      = "service.additionalInfo.threatListName"
      not_equals = ["some-threat", "another-threat"]
      # not_equals = ["AWSKnownMaliciousIPs","Abuse.ch","Botnet_C2"] etc..
    }
    criterion {
      field        = "updatedAT"
      greater_than = "2020-01-01T00:00:00Z"
      less_than    = "2020-02-01T00:00:00Z"
    }
    criterion {
      field     = "severity"
      less_than = "4"
    }
  }
}
