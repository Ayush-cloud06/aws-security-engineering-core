# Governance, Risk & Compliance

This domain defines the governance layer of the security architecture.

Unlike domains that deploy technical controls, this domain maps regulatory and internal requirements to implemented controls across the platform.

## Objectives

- Establish and maintain an Information Security Management System (ISMS)
- Operate a repeatable risk management lifecycle
- Maintain control mappings across key frameworks
- Track applicability and implementation status of controls
- Provide audit-ready evidence references

## In Scope Frameworks

- ISO/IEC 27001
- NIST Cybersecurity Framework (CSF)
- CIS AWS Foundations Benchmark
- GDPR

## Structure

- `ISMS/`: scope, policy baseline, roles, and asset governance
- `risk-management/`: risk methodology, register, and treatment plans
- `control-mapping/`: framework-specific control mapping references
- `soa/`: Statement of Applicability
- `audit-evidence/`: evidence catalog by control domain
- `audit-manager/`: baseline Terraform for AWS Audit Manager artifacts
- `shared-responsibility/`: AWS shared responsibility model reference
- `control-matrix/`: consolidated platform control matrix

## Operating Model

1. Define policy and scope in `ISMS/`
2. Assess and record risk in `risk-management/`
3. Map controls in `control-mapping/` and `control-matrix/`
4. Confirm applicability in `soa/statement_of_applicability.md`
5. Collect references in `audit-evidence/`
6. Use `audit-manager/` to automate evidence workflows where possible
