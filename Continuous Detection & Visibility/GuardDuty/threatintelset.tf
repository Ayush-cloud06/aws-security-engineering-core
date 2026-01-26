resource "aws_guardduty_threatintelset" "malicious_iocs" {
  activate    = true
  detector_id = aws_guardduty_detector.main.id
  format      = "TXT"
  location    = "https://s3.amazonaws.com/${aws_s3_object.threatintel.bucket}/${aws_s3_object.threatintel.key}"
  name        = "ExternalThreatIntel"
}


resource "aws_s3_object" "threatintel" {
  bucket  = aws_s3_bucket.ipbucket.id
  key     = "threat-intel.txt"
  content = <<EOF
1.2.3.4
5.6.7.0/24
badactor.example
EOF
}
