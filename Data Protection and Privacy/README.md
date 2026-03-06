# Data Protection & Privacy

## Overview

The **Data Protection & Privacy** domain focuses on protecting sensitive information stored and processed within the platform. While the Infrastructure Security domain protects networks and systems, this layer ensures that **the data itself remains confidential, properly managed, and compliant with privacy requirements**.

## Core Controls

This domain implements controls for:

* **Encryption** – Protecting data at rest and in transit using centrally managed cryptographic keys.
* **Secrets Management** – Secure storage and rotation of credentials and application secrets.
* **Data Classification** – Categorizing information based on sensitivity (e.g., public, internal, confidential).
* **Data Lifecycle Governance** – Defining retention, archival, and secure deletion policies.

## Sensitive Data Discovery

Sensitive data discovery is performed by **AWS Macie**, which is deployed within the **Continuous Detection & Visibility** domain.
This domain references Macie findings to support data governance and privacy monitoring.

## Purpose

Together, these controls ensure that sensitive information is:

* encrypted
* properly classified
* securely stored
* retained only as long as necessary

This supports regulatory requirements such as GDPR and general information security stan
