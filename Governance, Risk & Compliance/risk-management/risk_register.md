# Risk Register

| ID | Risk Description | Domain | Likelihood | Impact | Inherent Score | Existing Controls | Residual Score | Owner | Treatment | Target Date | Status |
|---|---|---|---:|---:|---:|---|---:|---|---|---|---|
| R-001 | Excessive IAM permissions may enable privilege escalation | IAM | 4 | 5 | 20 | IAM policy boundaries, role reviews, CloudTrail | 12 | IAM Lead | Mitigate | 2026-06-30 | In Progress |
| R-002 | Delayed patching of compute workloads could expose known vulnerabilities | Infrastructure | 3 | 4 | 12 | Vulnerability scanning, patch schedules | 8 | Infra Lead | Mitigate | 2026-05-31 | In Progress |
| R-003 | Incomplete data classification can lead to improper handling of sensitive data | Data Protection | 3 | 4 | 12 | Classification policy, Macie discovery | 9 | Data Governance Lead | Mitigate | 2026-07-15 | Open |
| R-004 | Insufficient alert tuning may cause missed detections | Detection | 3 | 5 | 15 | Security Hub, GuardDuty, SIEM alerting | 10 | Detection Engineering Lead | Mitigate | 2026-06-15 | In Progress |
| R-005 | Third-party integration risk due to limited supplier assurance evidence | GRC | 2 | 4 | 8 | Vendor review process | 6 | Governance Lead | Transfer / Mitigate | 2026-08-01 | Open |

## Notes

- Residual scores must be justified by control evidence.
- Closed risks should retain closure rationale and validation date.
