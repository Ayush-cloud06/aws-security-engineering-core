
Infrastructure-Security/
│
├── network-foundation/          #Core VPCs & Isolation
│   │
│   ├── main.tf
│   │   ├── Provider configuration
│   │   ├── Remote state isolation
│   │   └── Required provider version pinning
│   │
│   ├── vpc.tf
│   │   ├── Dedicated VPC (no default VPC usage)
│   │   ├── Strict CIDR allocation strategy
│   │   ├── DNS hostnames enabled
│   │   └── Explicit tagging for environment separation
│   │
│   ├── subnets.tf
│   │   ├── Public tier (ALB only)
│   │   ├── Private application tier
│   │   ├── Isolated database tier
│   │   ├── Reserved future security subnet
│   │   └── AZ distribution for HA
│   │
│   ├── route_tables.tf
│   │   ├── Explicit routing per tier
│   │   ├── No accidental internet exposure
│   │   └── Segmented route control
│   │
│   ├── vpc_endpoints.tf
│   │   ├── S3 endpoint
│   │   ├── STS endpoint
│   │   ├── KMS endpoint
│   │   ├── CloudWatch endpoint
│   │   └── Endpoint policies enforced
│   │
│   └── vpc_flow_logs.tf
│       ├── Enabled on all subnets
│       ├── Centralized log destination
│       └── Ready for anomaly detection pipeline
│
├── microsegmentation/           # Security Groups & NACLs
│   │
│   ├── main.tf
│   │
│   ├── quarantine_sg.tf
│   │   ├── Deny-all inbound
│   │   ├── Deny-all outbound
│   │   └── Used by IR Step Functions playbook
│   │
│   ├── baseline_sgs.tf
│   │   ├── App-tier SG (only from ALB)
│   │   ├── DB-tier SG (only from App SG)
│   │   ├── No 0.0.0.0/0 except controlled edge
│   │   └── Strict ingress referencing by SG ID
│   │
│   ├── network_acls.tf
│   │   ├── Stateless subnet enforcement
│   │   ├── Explicit deny rules
│   │   ├── Protection against misconfigured SGs
│   │   └── Logging support
│   │
│   └── east_west_control.tf
│       ├── Restrict lateral traffic
│       ├── No implicit intra-VPC trust
│       └── App ↔ DB single-path communication
│
├── perimeter-defense/           # Edge Security
│   │
│   ├── main.tf
│   │
│   ├── alb.tf
│   │   ├── TLS 1.2+ enforcement
│   │   ├── Redirect HTTP → HTTPS
│   │   ├── Restricted security group
│   │   └── Access logging enabled
│   │
│   ├── waf_regional.tf
│   │   ├── Managed rule groups
│   │   ├── SQL injection protection
│   │   ├── XSS mitigation
│   │   ├── Rate limiting
│   │   ├── IP reputation filtering
│   │   └── Custom application rules
│   │
│   ├── shield.tf
│   │   ├── Baseline DDoS protection
│   │   ├── Integration with ALB
│   │   └── Alert escalation to SOC
│   │
│   └── public_exposure_audit.tf
│       ├── Detect unintended public resources
│       └── Prevent accidental open listeners
│
├── centralized-egress/          # Outbound Traffic Control
│   │
│   ├── main.tf
│   │
│   ├── nat_gateway.tf
│   │   ├── Controlled outbound access
│   │   ├── Private subnet only
│   │   └── No public IP assignment
│   │
│   ├── network_firewall.tf
│   │   ├── Stateful inspection
│   │   ├── Domain allow-listing
│   │   ├── IDS/IPS signatures
│   │   ├── Egress filtering rules
│   │   └── Logging integration
│   │
│   └── egress_policy_strategy.md
│       ├── Default deny outbound model
│       ├── Explicit SaaS dependency mapping
│       └── Malware beaconing prevention logic
│
├── secure-access/               # Zero-Trust Access
│   │
│   ├── main.tf
│   │
│   ├── ssm_bastion.tf
│   │   ├── No inbound ports
│   │   ├── Access via Session Manager only
│   │   ├── IAM policy-restricted login
│   │   └── Logged session transcripts
│   │
│   ├── imdsv2_enforcement.tf
│   │   ├── Require IMDSv2
│   │   ├── Prevent credential theft attacks
│   │   └── Disable metadata v1
│   │
│   ├── break_glass_access.tf
│   │   ├── Emergency access pattern
│   │   ├── Temporary elevated privileges
│   │   └── Mandatory audit trail
│   │
│   └── ssh_elimination_strategy.md
│       ├── No permanent SSH keys
│       ├── No public bastions
│       └── Identity-aware infrastructure access
│
├── resilience-layer/            # Hardening & Defaults
│   │
│   ├── default_vpc_removal.tf
│   ├── mandatory_encryption.tf
│   ├── logging_enforcement.tf
│   ├── resource_tag_policies.tf
│   └── region_restriction.tf
│
├── attack-simulation/           #    dversary Testing
│   │
│   ├── lateral_movement_test.md
│   ├── public_exposure_test.md
│   └── egress_beaconing_simulation.md
│
├── README.md  ?