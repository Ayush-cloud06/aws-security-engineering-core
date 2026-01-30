/*
===============================================================================
CloudWatch Metric Streams – External Analytics & SIEM Integration (REFERENCE)

CloudWatch Metric Streams allow near-real-time export of AWS metrics to
external analytics platforms. This is used in mature SOC / compliance-driven
environments where metrics must be analyzed outside AWS.

This setup is intentionally COMMENTED OUT.

------------------------------------------------------------------------------
Why Metric Streams exist (beyond alarms & dashboards)
------------------------------------------------------------------------------
- Native CloudWatch Alarms = reactive, per-metric, AWS-only
- Metric Streams = continuous telemetry export for:
  • Correlation
  • Long-term analytics
  • Cross-cloud visibility
  • Compliance evidence pipelines

Think of this as:
  "Metrics as data", not just "metrics as alerts"

------------------------------------------------------------------------------
Common Destinations (via Kinesis Firehose or OpenSearch)
------------------------------------------------------------------------------
✔ SIEM Platforms
  - Splunk (via HEC / Firehose HTTP endpoint)
  - IBM QRadar
  - Elastic / OpenSearch
  - Datadog
  - Sumo Logic

✔ Cloud-native Security Platforms
  - Amazon OpenSearch (Security Analytics)
  - Amazon S3 (cold storage + Athena)
  - AWS Managed Grafana

✔ Microsoft Ecosystem
  - Microsoft Sentinel (via Azure Event Hub bridge)
    CloudWatch → Firehose → HTTP → Event Hub → Sentinel

✔ Custom Pipelines
  - S3 → Athena → Compliance Dashboards
  - S3 → Glue → Evidence automation
  - Firehose → Lambda → Custom SOC logic

------------------------------------------------------------------------------
Typical Security & Compliance Use Cases
------------------------------------------------------------------------------
- CSPM metric baselining (CPU, network, API usage anomalies)
- Detecting “compliance drift” as time-series signals
- Feeding SOC dashboards with raw metrics
- Retaining immutable operational evidence for audits
- Cross-account / cross-cloud security observability

------------------------------------------------------------------------------
Why this module is not enabled by default
------------------------------------------------------------------------------
- Metric Streams introduce:
  • IAM trust relationships
  • Firehose pipelines
  • External dependencies
- Not required for baseline detection (GuardDuty / Security Hub already cover)
- Enabled only when:
  • External SIEM is in place
  • SOC maturity increases
  • Compliance automation requires raw metrics

------------------------------------------------------------------------------
Security Considerations
------------------------------------------------------------------------------
- IAM roles scoped strictly to Firehose PutRecord
- No wildcard permissions
- Destination buckets must be encrypted and access-controlled
- Metric selection should be minimal (avoid cost & noise)

------------------------------------------------------------------------------
Status
------------------------------------------------------------------------------
✔ Design validated
✔ Terraform reference preserved
✖ Intentionally disabled
===============================================================================
*/




/* ~ From officail docs 

resource "aws_cloudwatch_metric_stream" "main" {
  name          = "my-metric-stream"
  role_arn      = aws_iam_role.metric_stream_to_firehose.arn
  firehose_arn  = aws_kinesis_firehose_delivery_stream.s3_stream.arn
  output_format = "json"

  include_filter {
    namespace    = "AWS/EC2"
    metric_names = ["CPUUtilization", "NetworkOut"]
  }

  include_filter {
    namespace    = "AWS/EBS"
    metric_names = []
  }
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-trustpolicy.html
data "aws_iam_policy_document" "streams_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "metric_stream_to_firehose" {
  name               = "metric_stream_to_firehose_role"
  assume_role_policy = data.aws_iam_policy_document.streams_assume_role.json
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-trustpolicy.html
data "aws_iam_policy_document" "metric_stream_to_firehose" {
  statement {
    effect = "Allow"

    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
    ]

    resources = [aws_kinesis_firehose_delivery_stream.s3_stream.arn]
  }
}
resource "aws_iam_role_policy" "metric_stream_to_firehose" {
  name   = "default"
  role   = aws_iam_role.metric_stream_to_firehose.id
  policy = data.aws_iam_policy_document.metric_stream_to_firehose.json
}

resource "aws_s3_bucket" "bucket" {
  bucket = "metric-stream-test-bucket"
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

data "aws_iam_policy_document" "firehose_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "firehose_to_s3" {
  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
}

data "aws_iam_policy_document" "firehose_to_s3" {
  statement {
    effect = "Allow"

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "firehose_to_s3" {
  name   = "default"
  role   = aws_iam_role.firehose_to_s3.id
  policy = data.aws_iam_policy_document.firehose_to_s3.json
}

resource "aws_kinesis_firehose_delivery_stream" "s3_stream" {
  name        = "metric-stream-test-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_to_s3.arn
    bucket_arn = aws_s3_bucket.bucket.arn
  }
} */
