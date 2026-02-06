# iam_user.tf

# A standard admin-level user for the simulation
resource "aws_iam_user" "admin_user" {
  name = "ayush-admin"
  path = "/system/" # Organizing users under a path i

  tags = {
    JobRole = "SecurityEngineer"
    Project = "SoulCanvas"
  }
}

# A read-only auditor user for the GRC simulation
resource "aws_iam_user" "auditor_user" {
  name = "compliance-auditor"
  path = "/audit/"

  tags = {
    JobRole = "ComplianceAuditor"
    Project = "GRC-Simulation"
  }
}
