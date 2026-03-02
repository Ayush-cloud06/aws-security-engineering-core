# Network Foundation

## Overview

The Network Foundation module defines the secure baseline networking architecture for the platform. It establishes a dedicated VPC with deterministic subnet design, explicit routing controls, private AWS service access, and centralized network logging.

This module provides the core network isolation layer upon which all higher-level security controls depend.

The architecture follows enterprise security principles:

- Dedicated VPC (no default VPC usage)
- Tiered subnet isolation
- Explicit routing controls
- Private AWS service connectivity
- Centralized network telemetry
- Deterministic CIDR allocation

---

## Architecture

### VPC

A dedicated VPC is provisioned with DNS support enabled.
CIDR: 10.10.0.0/16


Design goals:

- Predictable addressing
- Future expansion capacity
- Environment isolation
- No reliance on default networking

---

### Subnet Layout

The VPC is segmented into security tiers across multiple availability zones.

| Tier | Purpose | CIDR |
|------|---------|------|
Public | Internet-facing load balancers | 10.10.1.0/24, 10.10.2.0/24 |
Application | Private compute workloads | 10.10.11.0/24, 10.10.12.0/24 |
Database | Isolated data tier | 10.10.21.0/24, 10.10.22.0/24 |
Security | Inspection and security services | 10.10.31.0/24, 10.10.32.0/24 |

Characteristics:

- Multi-AZ deployment
- Tier isolation
- No automatic public IP assignment
- Reserved space for future expansion

---

### Routing Strategy

Each tier uses a dedicated route table.

| Tier | Internet Access |
|------|----------------|
Public | Internet Gateway |
Application | None (future controlled egress) |
Database | None |
Security | None |

Key properties:

- No implicit internet access
- Explicit route definitions
- Tier-based routing isolation
- Designed for future firewall integration

---

### VPC Endpoints

Private connectivity to core AWS services is provided through VPC endpoints.

| Service | Endpoint Type | Purpose |
|--------|---------------|---------|
S3 | Gateway | Logs and Terraform state access |
STS | Interface | Role assumption and federation |
KMS | Interface | Encryption operations |
CloudWatch Logs | Interface | Logging and telemetry |

Benefits:

- No public internet dependency
- Reduced attack surface
- Private service communication
- Improved compliance posture

---

### Flow Logs

VPC Flow Logs are enabled for the entire VPC.

Properties:

- Traffic type: ALL
- Central CloudWatch log group
- Long-term retention
- IAM-controlled publishing

Purpose:

- Network visibility
- Incident investigation
- Anomaly detection
- Audit evidence

---

## Security Properties

The network foundation enforces the following security guarantees:

- Dedicated network boundary
- Tier-based isolation
- Controlled ingress points
- No unintended public exposure
- Private AWS API access
- Continuous network monitoring

---

## Integration

This module supports the following platform components:

### Infrastructure Security

- Microsegmentation (Security Groups & NACLs)
- Perimeter Defense
- Centralized Egress Control
- Zero Trust Access

### Continuous Detection

- GuardDuty
- Security Hub
- CloudWatch monitoring
- SIEM ingestion

### Incident Response

- Automated containment
- Quarantine security groups
- Network isolation workflows

---

## Files
```
network-foundation/
├── main.tf
├── vpc.tf
├── subnets.tf
├── route_tables.tf
├── vpc_endpoints.tf
└── vpc_flow_logs.tf
```


---

## Design Principles

### Deterministic Networking

All network ranges and tiers are explicitly defined to ensure predictable behavior and easier auditing.

### Isolation First

Network tiers are isolated by default. Connectivity must be explicitly allowed.

### Private Service Access

AWS service communication occurs through private endpoints rather than public internet paths.

### Observability

Network activity is continuously logged to support detection and investigation workflows.

---

## Future Extensions

This network baseline is designed to support:

- Network Firewall inspection
- Centralized egress filtering
- Threat detection pipelines
- IDS/IPS integration
- Cross-account networking