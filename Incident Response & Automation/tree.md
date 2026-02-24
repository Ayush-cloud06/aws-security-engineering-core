```
Incident Response & Automation/
│
├── eventbridge/                 # 🚦 The Traffic Cop
│   ├── Providers.tf
│   ├── event_bus.tf             # Custom bus, DLQ, logging
│   └── routing_rules.tf         # Rules routing to Lambda, SSM, or Step Functions
│
├── lambda/                      # 🎯 The Snipers (Stateless, fast API fixes)
│   ├── main.tf                  # Lambda infra & IAM roles
│   └── src/
│       ├── dispatcher.py        # Central router for simple fixes
│       └── actions/
│           ├── root_key_fix.py
│           ├── s3_public_fix.py
│           ├── sg_ssh_fix.py
│           └── iam_revoke_sessions.py # Nuke all active sessions for a compromised user
│
├── ssm_automation/              # 🏗️ The Heavy Artillery (OS & Instance level)
│   ├── main.tf                  # Deploys SSM Docs and execution roles
│   └── documents/               # YAML runbooks for the SSM agent
│       ├── isolate_ec2.yaml     # Swaps SG to a "deny-all" quarantine group
│       ├── take_ebs_snapshot.yaml # Forensic backup before shutting things down
│       └── patch_critical.yaml  # Force-patches an instance flagged by Inspector
│
├── step_functions/              # 🎼 The Orchestrator (Multi-step incident playbooks)
│   ├── main.tf                  # State machine infra
│   └── playbooks/
│       └── malware_containment.asl.json # The big one: Snapshot -> Isolate -> Slack alert -> Wait for human approval -> Terminate
│
└── notifications/               # 📢 The Megaphone (SOC visibility)
    ├── main.tf                  # SNS topics and policies
    └── chatbot_slack.tf         # AWS Chatbot integration so alerts drop right into a Slack channel
    ```