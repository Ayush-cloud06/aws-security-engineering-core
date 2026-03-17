# ISO 27001 Control Mapping (Reference)

## Purpose

Reference how platform controls align to ISO/IEC 27001 Annex A themes.

| ISO 27001 Control Theme | Platform Control Area | Evidence Source |
|---|---|---|
| Access Control | IAM baseline, MFA, role separation | IAM configs, access reviews, CloudTrail |
| Cryptography | KMS key management, TLS standards | KMS policies, encryption config snapshots |
| Logging and Monitoring | Centralized logging, detection and alerting | CloudTrail, CloudWatch, Security Hub exports |
| Vulnerability Management | Scanning and remediation lifecycle | Inspector findings, patch records |
| Incident Management | Incident handling and escalation process | Runbooks, incident records, postmortems |
| Supplier Security | Third-party risk assessment | Vendor assessment records |
