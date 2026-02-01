# Provides a resource to manage an AWS Macie Classification Job.

resource "aws_macie2_classification_job" "s3_scan" {
  name = "weekly-scan"

  job_type = "SCHEDULED"

  schedule_frequency {
    weekly_schedule = "MONDAY"
  }

  s3_job_definition {
    bucket_definitions {
      account_id = "123456789012"
      buckets    = ["my-bucket"]
    }
  }
}
