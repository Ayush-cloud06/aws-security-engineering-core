resource "aws_organizations_policy" "tag_policy" {

  name = "mandatory-resource-tags"
  type = "TAG_POLICY"
  content = jsonencode({

    tags = {
      Environment = {
        tag_key      = "Environment"
        enforced_for = ["ec2:instance"]
      }

      Owner = {
        tag_key      = "Owner"
        enforced_for = ["ec2:instance"]
      }
    }
  })
}
