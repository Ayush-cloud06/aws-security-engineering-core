# AWS CloudTrail

CloudTrail provides a record of actions taken by a user, role, or an AWS service in your AWS account. It is essential for security, compliance, and operational auditing.

It is the foundation for:

* Incident response
* Compliance audits
* Forensics
* Detection engineering
* Zero-trust enforcement

Everything else reads from CloudTrail.

---

## What CloudTrail Gives You

* **Authoritative Event History**
  A complete, immutable timeline of who did what, when, and from where.

* **S3-backed Forensic Storage**
  Long-term log retention in hardened, encrypted S3 buckets.

* **CloudTrail Lake (Event Data Store)**
  SQL-queryable forensic database for threat hunting and investigations.

* **CloudWatch Integration**
  Real-time alerting and automation triggers.

* **Organization-wide Coverage**
  One trail, all accounts, all regions, centrally governed.

---

## Core Capabilities

* **Event History**

  * 90 days of searchable management events in the AWS console
  * Immediate visibility into API activity

* **Trails**

  * Deliver logs to:

    * S3 for cold, compliant storage
    * CloudWatch Logs for real-time detection

* **CloudTrail Insights**

  * Detect anomalous API behavior automatically
  * Flags compromised credentials and abnormal automation patterns

* **Data Events**

  * Object-level S3 access
  * Lambda invocation activity
  * DynamoDB data manipulation
    High-signal telemetry for breach detection.

* **CloudTrail Lake**

  * SQL-style querying
  * Cross-account, cross-region forensics
  * Incident reconstruction in minutes, not hours

---

## Architecture in This Repository

This CloudTrail module implements:

* Multi-region trails
* KMS encryption using customer-managed keys
* Log file integrity validation
* Hardened S3 forensic vault
* CloudTrail Lake for investigations
* Advanced event selectors for:

  * S3 objects
  * Lambda invocations
  * DynamoDB critical tables
* Termination protection on forensic stores
* Organization-ready delegated administration

1. **Central Trail**

   * One trail for all regions
   * Optionally one trail for the whole organization

2. **Forensic Storage**

   * Logs written to a hardened S3 bucket:

     * Versioning enabled
     * Public access blocked
     * Bucket policy restricted to CloudTrail
     * KMS encryption enforced

3. **Forensic Database**

   * CloudTrail Lake Event Data Store
   * Retention optimized for investigations
   * Queryable via SQL

4. **Real-Time Detection**

   * Optional CloudWatch Logs integration
   * Feeds GuardDuty, Detective, and automation

---

## Security Best Practices Implemented

* **Organization Trails**

  * Single source of truth across all accounts
  * Centralized governance

* **Customer-Managed KMS Keys**

  * Full control over encryption
  * Key rotation enabled
  * Compliance-ready

* **Log File Validation**

  * Detects log tampering
  * Cryptographic integrity guarantees

* **Forensic Bucket Hardening**

  * No public access
  * Versioned
  * Write-only for CloudTrail
  * Read restricted to security roles

* **Delegated Administrator Model**

  * CloudTrail control delegated to a dedicated security account
  * Management account stays clean and minimal

---
