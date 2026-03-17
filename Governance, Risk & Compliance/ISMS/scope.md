# ISMS Scope

## Scope Statement

The ISMS covers cloud-hosted workloads, platform services, CI/CD pipelines, identities, and data stores deployed within AWS accounts that are part of this security engineering platform.

## In-Scope Assets

- AWS Organizations management and member accounts
- IAM roles, users, federated identities, and permission boundaries
- Network perimeter and internal segmentation controls
- Compute, container, and serverless workloads
- Data services and storage systems
- Central logging, monitoring, and detection systems
- Security automation and incident response workflows

## Out of Scope

- End-user endpoint management
- Corporate IT SaaS controls not integrated with this platform
- Physical security controls for third-party data centers (covered under AWS responsibility)

## Scope Boundaries

- Legal entities: engineering-owned cloud environments
- Geographical scope: all AWS regions explicitly enabled by platform policy
- Lifecycle scope: build, deploy, operate, monitor, and decommission phases

## Scope Review

- Review frequency: at least annually and after major architecture change
- Owner: Security Governance Lead
- Approver: CISO or designated security executive
