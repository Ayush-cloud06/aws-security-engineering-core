## Continuous Detection & Visibility

This domain focuses on building the detection layer of a cloud security architecture.

It covers logging, monitoring, threat detection, investigation, and event correlation to ensure all activity in the environment is observable, traceable, and actionable.

This folder contains minimal Terraform modules for services such as:

* Threat detection (GuardDuty, Inspector)
* Centralized findings (Security Hub)
* Investigation workflows (Detective)
* Activity logging (CloudTrail, VPC Flow Logs, S3 events)
* Monitoring & alerting (CloudWatch, Alarms, Contributor Insights)
* Event routing (EventBridge)
* Log analytics (Athena, OpenSearch)
* Data security visibility (Macie)

Design principles:

* Detection-first security architecture
* Explicit and minimal configurations
* No opinionated production abstractions
* Built for visibility, correlation, and automation readiness

This layer acts as the **sensory system** of the cloud:
everything else (response, remediation, compliance, governance) depends on it.
