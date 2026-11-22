# GreenGrid Solar Platform — Documentation Package

Version 1.0-draft | Prepared 22 November 2026 | Client: GreenGrid Solar Solutions, Erattupetta, Kottayam, Kerala.

This package supplements the existing product and website documentation. It defines the proposed internal operations platform, customer app, technician app, group-based access, utility tracking, IoT monitoring and service workflows.

## Folder map
- 01-strategy: charter and business requirements
- 02-workflows: enquiry conversion, project, utility, installation and service
- 03-requirements: software requirements specification
- 04-architecture: system architecture and technology decisions
- 05-data-and-api: logical data model and API outline
- 06-security-and-access: authorization, privacy and security
- 07-iot-monitoring: device integrations, telemetry and alerts
- 08-integrations: notifications and external systems
- 09-mobile-apps: customer and technician applications
- 10-delivery: roadmap, effort and cost assumptions
- 11-governance: discovery questions, acceptance and verification

## Status vocabulary
Confirmed from supplied brief = explicitly supplied information. Proposed = recommended design. VERIFY = client, authority, manufacturer or professional confirmation required. Deferred = not part of initial release, not permanently excluded.

## Principles
1. Enquiry, customer, project, plant, device and case are separate entities.
2. One customer may have multiple sites and projects.
3. Government portals remain authoritative; mirror status unless an authorised API is confirmed.
4. Group grants combine, explicit deny overrides, and resource scope is enforced server-side.
5. Device alerts and service cases are distinct.
6. Every pending milestone has an owner, reason, evidence and next action.
7. Do not commit credentials or customer personal data to this repository.

This is a planning specification, not legal, tax, electrical engineering or API-access approval. Reverify regulatory and provider claims before implementation.
