# Provides a resource to manage an Amazon Macie Findings Filter.

resource "aws_macie2_findings_filter" "high_severity_filter" {
  name        = "archive-high-severity-findings"
  description = "Automatically archive high severity Macie findings"
  position    = 1
  action      = "ARCHIVE"

  finding_criteria {
    criterion {
      field = "severity.description"
      eq    = ["High"]
    }
  }

  depends_on = [aws_macie2_account.macie]
}
