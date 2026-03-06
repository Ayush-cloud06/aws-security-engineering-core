resource "aws_organizations_policy" "region_restriction" {
  name = "allowed-regions"
  type = "SERVICE_CONTROL_POLICY"
  content = jsonencode({

    Version = "2012-10-17"
    Statement = [{
      Effect   = "Deny"
      Action   = "*"
      Resource = "*"

      Condition = {
        StringNotEquals = {
          "aws:RequestedRegion" = ["ap-south-1"]
        }
      }
    }]
  })
}
