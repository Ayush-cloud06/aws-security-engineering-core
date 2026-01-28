# Provides a resource to manage an AWS Detective Graph. As an AWS account may own only one Detective graph per region,
# provisioning multiple Detective graphs requires a separate provider configuration for each graph.

resource "aws_detective_graph" "orgDetective" {
  tags = {
    Name = "orgDetective-graph"
  }
}
