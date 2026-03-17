# Asset Management Policy

## Purpose

Ensure all information assets are identified, classified, owned, and protected throughout their lifecycle.

## Requirements

- All cloud assets must be discoverable through approved inventory sources (AWS Config, tagging, CMDB where applicable).
- Every production asset must have an accountable owner.
- Data-bearing assets must carry a classification label.
- Unsupported, unmanaged, or orphaned assets must be decommissioned.
- Asset lifecycle events (creation, change, retirement) must be auditable.

## Minimum Tagging Standard

- `Owner`
- `Environment`
- `DataClassification`
- `Application`
- `CostCenter`

## Asset Classes

- Information assets
- Software assets
- Infrastructure assets
- Cryptographic assets

## Review Cadence

Asset inventory and classification accuracy should be reviewed at least quarterly.
