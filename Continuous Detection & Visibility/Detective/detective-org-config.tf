/* Manages the Detective Organization Configuration in the current AWS Region. 
The AWS account utilizing this resource must have been assigned as a delegated 
Organization administrator account */


/* This is an advanced Terraform resource. Terraform will automatically assume 
management of the Detective Organization Configuration without import and 
perform no actions on removal from the Terraform configuration. ~ official docs */

resource "aws_detective_organization_configuration" "orgconfigdetective" {
  auto_enable = true
  graph_arn   = aws_detective_graph.orgDetective.graph_arn
}
