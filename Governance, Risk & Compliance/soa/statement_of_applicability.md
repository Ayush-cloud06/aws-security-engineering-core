# Statement of Applicability (SoA)

## Purpose

Document whether relevant controls are applicable, implemented, and evidenced.

| Control Area | Applicable | Status | Justification | Evidence Reference |
|---|---|---|---|---|
| Access Control | Yes | Implemented | Required to enforce least privilege and segregation of duties | `audit-evidence/access_controls.md` |
| Cryptography | Yes | Implemented | Required for protection of sensitive data | `audit-evidence/encryption_controls.md` |
| Logging & Monitoring | Yes | Implemented | Required for detect/respond capability and auditability | `audit-evidence/logging_controls.md`, `audit-evidence/monitoring_controls.md` |
| Secure Development & Change Control | Yes | Partially Implemented | Additional evidence consolidation in progress | CI/CD audit artifacts |
| Supplier Security | Yes | Partially Implemented | Baseline process exists; evidence standardization ongoing | Vendor review records |
| Physical & Environmental Security | No (platform direct control) | Not Applicable | Managed by AWS under shared responsibility | `shared-responsibility/aws_artifact.md` |

## Review

- Maintained by: Security Governance Lead
- Approval: CISO or delegate
- Review cycle: at least annually or after material control changes
