# Amazon CloudWatch – Monitoring & Observability

This module defines the CloudWatch-based monitoring layer used for detection,
alerting, and operational visibility across AWS workloads.

CloudWatch acts as the **telemetry backbone** that feeds alarms, dashboards,
and downstream security automation.

This implementation focuses on **signal-first monitoring**, not UI-driven noise.

---

## Scope & Design Philosophy

CloudWatch is used here to:

- Monitor critical infrastructure metrics
- Detect abnormal behavior early
- Generate actionable alarms
- Provide visual operational context
- Support future SOC / SIEM integrations

The design intentionally avoids:
- Over-alerting
- Metric sprawl
- UI-only dashboards with no operational value

---

## Implemented Components

### Metric Alarms
Detect threshold breaches and abnormal patterns on AWS service metrics.

Examples:
- EC2 / ALB / RDS health metrics
- Error rates (5XX, latency)
- Resource exhaustion indicators

Alarms are designed to be:
- Deterministic
- Low-noise
- Actionable

---

### Composite Alarms
Logical aggregation of multiple alarms using **AND / OR** rules.

Used to:
- Represent service-level health
- Reduce alert fatigue
- Trigger incidents only when multiple signals degrade

