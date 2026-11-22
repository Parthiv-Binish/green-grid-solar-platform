# Software Requirements Specification

## Identity and access
- FR-001: Staff can authenticate securely.
- FR-002: A user can belong to multiple groups.
- FR-003: Group grants combine; explicit deny overrides grants.
- FR-004: Scopes include own, assigned, team, branch, related and all.
- FR-005: Temporary elevation/delegation requires approval, reason and expiry.
- FR-006: Sensitive actions are audited.

## CRM and customer
- FR-010: Create, edit, assign, search and filter enquiries.
- FR-011: Record calls, messages, notes and follow-ups.
- FR-012: Track lead stages and lost reasons.
- FR-013: Convert Won enquiry to customer/project with duplicate prevention.
- FR-014: Support multiple sites and projects per customer.

## Project and commercial
- FR-020: Record surveys and attachments.
- FR-021: Generate versioned quotations and record acceptance/rejection.
- FR-022: Track contract and payment milestones.
- FR-023: Track tasks, owners, due dates and dependencies.
- FR-024: Maintain project document vault.

## Utility and compliance
- FR-030: Store official application references and statuses.
- FR-031: Track utility milestones separately.
- FR-032: Record updater, timestamp, source and evidence.
- FR-033: Provide pending-meter and subsidy ageing queues.
- FR-034: Apply versioned regulatory rules only after approval.

## Field operations and service
- FR-040: Create installation/service work orders.
- FR-041: Assign one or more technicians.
- FR-042: Support checklists, photographs, readings and material usage.
- FR-043: Create manual and policy-driven cases.
- FR-044: Apply SLA, escalation and resolution history.
- FR-045: Manage warranty claims and AMC schedules.

## Monitoring
- FR-050: Register plants, devices and connectors.
- FR-051: Ingest, validate and normalise telemetry.
- FR-052: Display last measurement timestamp and data quality.
- FR-053: Evaluate alert rules with debounce/deduplication.
- FR-054: Create cases from qualifying alerts.

## Communication and mobile
- FR-060: Dispatch through approved providers.
- FR-061: Track consent, template, attempt and delivery status.
- FR-062: Customers see only their own authorised data.
- FR-063: Technicians see assigned/authorised jobs and submit evidence.
- FR-064: Technician app supports offline drafts and conflict-aware sync.

## Non-functional requirements
Security: server-side authorization on every protected API. Privacy: minimisation, purpose and retention controls. Reliability: idempotent retry-safe jobs. Auditability: actor/time for important changes. Accessibility: contrast, scalable text and keyboard navigation. Offline: drafts survive restart and sync safely. Backup: tested offsite restore. Observability: structured logs, metrics and error reporting.

## Validation
Validate required fields, ranges, dates, file types, transitions and relationships server-side. Errors must not expose secrets or stack traces. Every requirement maps to screen/API, data entity, permission and acceptance test before release.
