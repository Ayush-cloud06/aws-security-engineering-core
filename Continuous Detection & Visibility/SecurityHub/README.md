# Security Hub

> This module assumes AWS Config is already enabled in the account, as it is a prerequisite for Security Hub compliance and control evaluation.

This module manages the centralized deployment and orchestration of **AWS Security Hub** across the entire AWS Organization.  
It enables automated security findings ingestion, compliance tracking against industry standards, and cross-region aggregation of security signals.

---

## 🏗️ Architecture Overview

This configuration is designed to be executed from the **Management / Delegated Admin Account**.

- **Centralization**  
  All findings from member accounts and regions are aggregated into the Security Hub Admin account using the Finding Aggregator.

- **Governance**  
  Security Hub Configuration Policies are used to enforce security standards (CIS, AWS Foundations, and future frameworks such as NIST/ISO) across the organization.

- **Automation**  
  Custom automation rules normalize, enrich, suppress, or escalate findings based on severity, resource criticality, and governance requirements.

