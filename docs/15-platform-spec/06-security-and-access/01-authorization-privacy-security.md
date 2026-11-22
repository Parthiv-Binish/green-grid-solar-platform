# Authorization, Privacy and Security

## Authorization model
Use group-based grants plus scope-aware ABAC and limited relationship checks. Users can belong to multiple groups. Group grants combine; explicit deny overrides allow. Scope is a separate decision.

## Scopes
own = created/owned by user; assigned = assigned to user; team = user's team; branch = authorised branch; related = explicit relationship; all = all records in company scope, subject to field restrictions.

## Arun example
Arun belongs to Technician and Staff. Technician grants case.read/case.update on assigned cases and work_order.read on assigned jobs. Staff grants case.read at all scope and basic project visibility. Arun can read all cases but update only assigned cases. Staff visibility does not grant access to bank details or restricted finance fields.

## Evaluation
Authenticate → load active memberships → aggregate grants → evaluate scope/relationship → apply explicit deny → field-level checks → audit sensitive action. Enforce database query filters on list, detail, search, export, aggregates, document downloads, WebSockets and bulk endpoints. Do not filter only in the frontend.

## Schema
users; groups; group_memberships; permissions; group_permission_rules(effect allow/deny, scope, conditions); user_permission_rules; resource_assignments; delegations; temporary_elevations; audit_logs. Temporary access requires approver, reason, scope and expiry. Increment authorization version and invalidate cache after policy changes.

## Security controls
MFA for privileged users; Argon2id password hashing; short-lived access tokens; rotating/revocable refresh tokens; OTP rate limiting; TLS; secrets management; private DB/Redis; upload validation and malware scanning; signed expiring file links; dependency/container updates; rate limits; structured logs; secure mobile token storage.

## Privacy
Clear notices; separate service/project communications from marketing; record consent/opt-out and notice version; minimise sensitive collection; retention/deletion rules; restrict Aadhaar/bank documents; encrypt sensitive data; maintain processor records; support applicable data-principal requests. Confirm phased DPDP Act/Rules commencement with counsel before production.

## CERT-In readiness
Assess applicability of CERT-In directions, maintain required logs and time synchronisation, designate point of contact, document incident reporting and preserve evidence. Confirm current official requirements with reviewer.

## Audit
Login failures; membership/permission changes; elevation; quotation approval; invoice/payment edits; project status; sensitive document access; export; account disablement; consent changes.

## Tests
Multiple groups, deny precedence, assignment scope, branch scope, expired delegation, removed membership, stale token, cross-customer access, search/export leakage, WebSocket leakage and signed-link reuse.
