## Amazon GuardDuty

This folder implements a **complete GuardDuty security detection platform** using Terraform.

It is not just about “enabling GuardDuty”.
It models how GuardDuty is deployed, governed, tuned, and integrated in real enterprise environments.

The stack covers:

* Core threat detection (GuardDuty detector)
* Feature enablement (EKS, S3, malware, Kubernetes audit logs)
* Organization-wide governance and auto-enrollment
* Centralized findings publishing (encrypted S3 + KMS)
* Malware protection for S3 uploads
* Custom intelligence feeds

  * IPSet → trusted sources (allowlist)
  * ThreatIntelSet → malicious IOCs (blocklist)
* SOC tuning using filters (suppression rules)
* Centralized account architecture (security account + members)

This is the **detection layer** of a cloud SOC.

---

What this folder represents:

```
AWS telemetry
   ↓
GuardDuty detection
   ↓
Intelligence enrichment (IPSet / ThreatIntelSet)
   ↓
Noise tuning (filters)
   ↓
Malware scanning
   ↓
Encrypted evidence storage
   ↓
Ready for SIEM, automation, and audits
```

---

Goals of this module:

* Model real-world GuardDuty deployment patterns
* Separate detection, intelligence, governance, and compliance concerns
* Show how GuardDuty fits into a centralized security architecture
* Provide a reusable baseline for:

  * SOC pipelines
  * Compliance evidence collection
  * Event-driven automation (SecurityHub, EventBridge, Lambda)

---

Design principles:

* Infrastructure-first security
* Explicit and readable Terraform
* No “click-ops” assumptions
* Modular responsibility (one concern per file)
* Built for extension into:

  * SecurityHub
  * SIEM ingestion
  * SOAR automation
  * Compliance pipelines

---

Folder structure meaning:

| File                          | Responsibility                               |
| ----------------------------- | -------------------------------------------- |
| guardduty.tf                  | Core detector                                |
| guardduty_detector_feature.tf | Feature enablement                           |
| guardduty_filter.tf           | SOC tuning / suppression                     |
| IPset.tf                      | Trusted IP intelligence                      |
| threatintelset.tf             | Malicious IOC intelligence                   |
| malware_protection.tf         | Active malware defense                       |
| publishing.tf                 | Evidence export + encryption                 |
| invite_member.tf              | Manual member onboarding (legacy / fallback) |
| organization.tf               | Enterprise governance + auto enrollment      |
| Providers.tf                  | Provider configuration                       |

---

Scope:

* Detection, intelligence, governance, and evidence
* Response automation intentionally excluded
* Designed to plug into:

  * SecurityHub
  * EventBridge
  * Incident Response workflows

This folder represents the **detection backbone** of a cloud security architecture.
