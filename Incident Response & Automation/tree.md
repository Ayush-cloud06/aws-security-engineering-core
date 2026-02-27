```
Incident Response & Automation/
│
├── eventbridge/                 # Event routing and filtering logic
│   ├── Providers.tf
│   ├── event_bus.tf             # Custom security event bus and DLQ setup
│   └── routing_rules.tf         # Rules routing to Lambda, SSM, or Step Functions
│
├── lambda/                      # Stateless automated remediation
│   ├── main.tf                  # Lambda infrastructure and IAM execution roles
│   ├── package/                 # Pre-compiled zip archives for deployment
│   └── src/                     # Python source code
│       ├── remediation_dispatcher.py # Central router for triggering specific fixes
│       └── actions/
│           ├── root_key_fix.py
│           ├── s3_public_fix.py
│           └── sg_ssh_fix.py
│
├── notification/                # Alerting and ChatOps integration
│   ├── main.tf                  # Central SOC SNS topics and access policies
│   └── chatbot_slack.tf         # AWS Chatbot configuration for HITL Slack approvals
│
├── ssm-automation/              # OS-level containment and forensic preservation
│   ├── main.tf                  # SSM Documents and execution role deployments
│   └── runbooks/                # Systems Manager automation logic
│       ├── advanced_containment.yaml # Workflow: Snapshot, isolate, and strip IAM profile
│       └── quarantine_ec2.yaml       # Workflow: Isolate via Security Group modification
│
├── step-functions/              # Stateful incident orchestration
│   ├── main.tf                  # State machine infrastructure and permissions
│   └── playbooks/               # Amazon States Language (ASL) definitions
│       └── malware_containment.asl.json # HITL workflow for handling critical malware alerts
│
├── simulations/                 # Scripts to safely trigger detection rules for testing
├── runbooks/                    # Human-readable Standard Operating Procedures (SOPs)
├── tree.md                      # Directory structure reference
└── README.md                    # Domain documentation
```