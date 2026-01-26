/*
S3 bucket where GuardDuty will export all findings.
This becomes your:
- Audit evidence store
- SIEM ingestion source
- Incident history archive

In real orgs this bucket is treated like a security log vault.
*/
resource "aws_s3_bucket" "guardduty_findings" {
  bucket = "guardduty-findings-${data.aws_caller_identity.current.account_id}"

  # In production this should usually be false,
  # so findings are never accidentally deleted.
  # Kept true here only for lab cleanup convenience.
  force_destroy = true

  tags = {
    Name      = "guardduty-findings"
    Purpose   = "Central storage for GuardDuty findings"
    ManagedBy = "Terraform"
    Security  = "High"
  }
}

/*
Block ALL public access to the findings bucket.
GuardDuty findings contain sensitive security data and
must never be publicly accessible.
*/
resource "aws_s3_bucket_public_access_block" "guardduty_findings" {
  bucket = aws_s3_bucket.guardduty_findings.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/*
KMS key used to encrypt GuardDuty findings before
they are written to S3.

This satisfies:
- ISO 27001 encryption controls
- SOC2 encryption requirements
- GDPR data protection expectations
*/
resource "aws_kms_key" "guardduty_findings" {
  description             = "KMS key for encrypting GuardDuty findings"
  deletion_window_in_days = 7

  # In production:
  # enable_key_rotation = true

  tags = {
    Name      = "guardduty-findings-kms"
    Purpose   = "Encrypt GuardDuty findings"
    ManagedBy = "Terraform"
  }
}

/*
This connects GuardDuty to the S3 bucket.

After this:
- Every GuardDuty finding is written to S3
- Encrypted using your KMS key
- Can be consumed by:
  - SIEM
  - Compliance audits
  - Forensics workflows
  - Long-term retention policies
*/
resource "aws_guardduty_publishing_destination" "s3_findings" {
  detector_id     = aws_guardduty_detector.main.id
  destination_arn = aws_s3_bucket.guardduty_findings.arn
  kms_key_arn     = aws_kms_key.guardduty_findings.arn
}
