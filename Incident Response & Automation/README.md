## Incident Response & Automation

This domain focuses on building the automated response and remediation layer of the cloud security architecture. 

It covers event routing, stateless fixes, deep OS-level containment, and orchestrated workflows to ensure threats are neutralized efficiently while maintaining strict compliance and auditability.

This folder contains minimal Terraform modules for services and workflows such as:

* Event routing and filtering (EventBridge)
* Stateless automated remediation (Lambda)
* Instance-level containment and forensic preservation (SSM Automation)
* Stateful incident playbooks and orchestration (Step Functions)
* Security alerting and ChatOps integration (SNS, AWS Chatbot)
* Simulated threat triggers for testing (`/simulations`)

Design principles:

* Audit-ready automation (GRC focused)
* Human-in-the-loop (HITL) enforcement for destructive actions
* Evidence preservation prior to containment
* Explicit, least-privilege execution roles
* Seamless integration with the detection layer

This layer acts as the **immune system** of the cloud: it translates visibility into measurable, documented, and governed security outcomes.