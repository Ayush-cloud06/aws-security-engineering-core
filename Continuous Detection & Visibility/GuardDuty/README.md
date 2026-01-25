## Amazon GuardDuty

This module represents the core threat detection service in AWS.

GuardDuty continuously analyzes AWS logs and network activity to identify suspicious behavior, compromised resources, and malicious patterns such as credential abuse, malware, and anomalous API usage.

The purpose of this folder is to:

* Enable GuardDuty in a minimal and explicit way
* Understand how threat detection is established at the infrastructure level
* Provide a foundation for event-driven automation and response workflows
* Integrate later with Security Hub, EventBridge, and remediation pipelines

Focus:

* Threat detection, not response
* Simple, readable Terraform
* No opinionated production configuration
* Built to plug into a larger security automation system

Think of this as the **starting point of the detection pipeline**.
