# Security Hub
# This module assumes AWS Config is already enabled in the account as it is a  prerequisite.
Manage the centralized deployment and orchestration of AWS Security Hub across the entire AWS Organization. It enables automated security findings, compliance tracking against global standards, and cross-region aggregation.
🏗️ Architecture Overview

The configuration is designed to be executed from the Management/Delegated Admin Account.

    Centralization: All findings from member accounts are aggregated into the Admin account via the Finding Aggregator.

    Governance: Uses Configuration Policies to enforce security standards (CIS, NIST, etc.) across the org.

    Automation: Includes custom automation rules to suppress or escalate findings based on severity.

---
