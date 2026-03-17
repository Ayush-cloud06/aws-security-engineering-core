# Platform Control Matrix

## Objective

Provide a consolidated view of control requirements, ownership, implementation status, and evidence sources.

| Control ID | Control Statement | Frameworks | Owner | Implementation Status | Evidence |
|---|---|---|---|---|---|
| CTRL-AC-01 | Enforce least privilege access for all production workloads | ISO 27001, NIST CSF, CIS | IAM Lead | Implemented | `audit-evidence/access_controls.md` |
| CTRL-CR-01 | Encrypt sensitive data at rest with managed keys | ISO 27001, GDPR, CIS | Data Protection Lead | Implemented | `audit-evidence/encryption_controls.md` |
| CTRL-CR-02 | Enforce encryption in transit for internal and external interfaces | ISO 27001, GDPR | Platform Security | Implemented | TLS standards + config evidence |
| CTRL-LG-01 | Centralize and protect security logs | ISO 27001, NIST CSF, CIS | Detection Lead | Implemented | `audit-evidence/logging_controls.md` |
| CTRL-MN-01 | Monitor and alert on suspicious activity | ISO 27001, NIST CSF | Detection Lead | Implemented | `audit-evidence/monitoring_controls.md` |
| CTRL-RM-01 | Maintain risk register and treatment workflow | ISO 27001, NIST CSF | Governance Lead | Implemented | `risk-management/risk_register.md` |
| CTRL-TP-01 | Assess supplier security and compliance posture | ISO 27001, GDPR | Governance Lead | Partially Implemented | Vendor assurance records |

## Maintenance

- Update when controls change, ownership shifts, or framework obligations are revised.
- Validate links to evidence during internal audits.
