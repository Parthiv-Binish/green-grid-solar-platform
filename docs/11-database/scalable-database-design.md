# Scalable Database Design

**Target:** PostgreSQL / Supabase | **Status:** Proposed design | **Version:** 0.2.0

This is a scalable logical and physical design proposal, not an executed migration. Build it module by module with versioned SQL migrations, tested constraints and RLS.

## 1. Architecture rules

- PostgreSQL is the source of truth. Supabase Auth owns credentials; never store passwords.
- UUID primary keys for durable business entities.
- snake_case names, UTC timestamptz timestamps.
- Use foreign keys, unique constraints, check constraints and transactions.
- Money uses bigint minor units (paise) plus currency code; never floating point.
- Quote, design, BOM and issued-document revisions are immutable snapshots.
- Status changes are recorded in history tables.
- Typed columns for core facts; JSONB only for extensible attributes, snapshots and provider payloads.
- Use soft archive only where workflow allows; retention and deletion policy is separate.
- Include organisation_id on business tables to support future branches, legal entities or franchises, even if one organisation launches first.
- Tenant / role scope is derived from authenticated membership, never trusted from browser input.

Common mutable table columns: id UUID PK, organisation_id UUID FK where relevant, created_at, updated_at, created_by, updated_by. Append-only ledger and event tables instead use occurred_at / actor_id and should not be casually updated.

## 2. Organisation, identity and permissions

| Table | Core columns | Purpose / constraints |
|---|---|---|
| organisations | id, legal_name, display_name, status, gstin, default_currency, timezone | Business / tenant |
| organisation_memberships | id, organisation_id, user_id, status, joined_at | Unique organisation + user |
| profiles | user_id PK → auth.users, full_name, avatar_path, locale, timezone | App profile; no password |
| roles | id, organisation_id nullable, role_key, display_name, is_system | Role catalogue |
| permissions | id, permission_key, description | Permission catalogue |
| role_permissions | role_id, permission_id | Unique role + permission |
| user_roles | id, organisation_id, user_id, role_id, granted_by, granted_at, revoked_at | Assignment history |
| staff_profiles | user_id PK, employee_code, department, employment_status, phone_work | Staff data |
| staff_skills | id, user_id, skill_key, verified_by, verified_at | Survey / installation eligibility |

## 3. Customers, contacts and properties

| Table | Core columns | Purpose |
|---|---|---|
| customers | id, organisation_id, customer_number, customer_type, display_name, status, primary_contact_id | Individual / business customer |
| customer_contacts | id, customer_id, contact_type, value_normalized, display_value, is_primary, is_verified, verified_at | Multiple phones / emails |
| customer_addresses | id, customer_id, address_type, address fields, pin_code, latitude, longitude, is_primary | Billing / correspondence |
| properties | id, organisation_id, customer_id, property_name, property_type, ownership_status, status | Customer may have many sites |
| property_addresses | id, property_id, address fields, pin_code, latitude, longitude, access_notes | Installation site |
| customer_consents | id, customer_id, purpose, channel, consent_status, notice_version, captured_at, source, withdrawn_at | Consent evidence |
| customer_relationships | id, customer_id, related_customer_id, relationship_type | Optional related entities |

Customer number unique per organisation. A customer has many contacts and properties. Do not auto-merge by similar name. Shared family phone numbers must be supported; contact uniqueness is a reviewed business rule.

## 4. Leads and CRM

| Table | Core columns | Purpose |
|---|---|---|
| lead_sources | id, organisation_id, source_key, label, is_active | Website, referral, campaign, phone, walk-in |
| leads | id, organisation_id, lead_number, customer_id nullable, property_id nullable, source_id, customer_type, service_interest, status, priority, assigned_to, next_action_at, lost_reason, calculator_session_id | Enquiry lifecycle |
| lead_contacts | id, lead_id, name, phone_normalized, email_normalized, preferred_channel | Contact before customer conversion |
| lead_activities | id, lead_id, activity_type, direction, outcome, summary, occurred_at, actor_id, visibility | Append-only contact history |
| lead_assignments | id, lead_id, assigned_to, assigned_by, assigned_at, unassigned_at, reason | Assignment history |
| follow_up_tasks | id, organisation_id, lead_id nullable, customer_id nullable, project_id nullable, owner_id, task_type, title, due_at, status, completed_at | Follow-up queue |
| lead_status_history | id, lead_id, from_status, to_status, reason, changed_by, changed_at | Transition audit |
| duplicate_candidates | id, lead_id, matched_customer_id, match_reason, review_status, reviewed_by | Human duplicate review |

Indexes: leads by organisation + status + created_at; assigned_to + status + next_action_at; follow_up owner + status + due_at; normalized phone / email lookup. Use partial indexes for active queues.

## 5. Calculator and estimates

| Table | Core columns | Purpose |
|---|---|---|
| calculator_sessions | id, organisation_id, lead_id nullable, property_id nullable, input_payload JSONB, result_payload JSONB, model_version, assumptions JSONB, created_at, consent_reference | Immutable calculation session |
| solar_resource_sources | id, source_name, source_version, geographic_resolution, source_url, reviewed_at | Solar data provenance |
| tariff_schedules | id, region_code, customer_category, valid_from, valid_to, tariff_data JSONB, source_reference | Versioned tariff assumptions |
| estimate_scenarios | id, calculator_session_id, scenario_key, capacity_kw, generation_kwh, cost_paise nullable, savings_low_paise nullable, savings_high_paise nullable, assumptions JSONB | Range / scenario outputs |

Every result references calculation version and assumptions. It is not a final engineering design or guaranteed saving.

## 6. Catalogue, suppliers and compatibility

| Table | Core columns | Purpose |
|---|---|---|
| product_categories | id, parent_id, category_key, name, sort_order, is_active | Hierarchical categories |
| brands | id, name, website_url, logo_path, verification_status | Brand master |
| products | id, organisation_id, brand_id, category_id, sku, model_number, name, description, product_type, status, published_at | Product master |
| product_specifications | id, product_id, spec_key, value_numeric, value_text, unit, source_document_id, verified_at | Typed specifications |
| product_documents | id, product_id, document_type, storage_path, revision, issued_at, verified_at | Datasheets / warranties |
| product_prices | id, product_id, currency_code, price_paise, price_type, valid_from, valid_to, approved_by | Dated restricted pricing |
| suppliers | id, organisation_id, supplier_code, name, contact_data JSONB, status | Supplier master |
| supplier_products | id, supplier_id, product_id, supplier_sku, lead_time_days, last_verified_at | Supplier catalogue |
| product_compatibility | id, product_id, compatible_product_id, compatibility_type, evidence_document_id, verified_by | Explicit compatibility evidence |

Use unique SKU per organisation when present. Do not use free-form JSONB as the only store for critical specifications. Filterable specs should be typed and indexed.

## 7. Booking and survey

| Table | Core columns | Purpose |
|---|---|---|
| service_types | id, organisation_id, service_key, name, duration_minutes, buffer_minutes, is_active | Configurable appointment types |
| service_areas | id, organisation_id, name, pin_code, region_code, is_active | Serviceable regions |
| staff_availability | id, user_id, weekday, start_time, end_time, effective_from, effective_to | Recurring schedule |
| staff_time_off | id, user_id, starts_at, ends_at, reason | Leave / unavailable |
| bookings | id, organisation_id, booking_number, customer_id, property_id, lead_id nullable, service_type_id, status, requested_start_at, requested_end_at, confirmed_start_at, confirmed_end_at, customer_notes, cancellation_reason | Appointment request |
| booking_assignments | id, booking_id, user_id, assignment_role, assigned_by, assigned_at, unassigned_at | Multi-staff assignment |
| booking_status_history | id, booking_id, from_status, to_status, reason, actor_id, changed_at | Status history |
| site_surveys | id, organisation_id, booking_id, property_id, survey_number, revision, status, submitted_at, reviewed_by, approved_at | Versioned survey |
| survey_sections | id, survey_id, section_key, completion_status | Checklist groups |
| survey_answers | id, survey_section_id, question_key, answer_jsonb, notes | Flexible answers |
| survey_media | id, survey_id, storage_path, media_type, caption, captured_at, uploaded_by | Private photos |
| survey_reviews | id, survey_id, reviewer_id, decision, comments, reviewed_at | Review history |

Prevent overlapping confirmed staff assignments using transaction locking and PostgreSQL range / exclusion constraints where practical. Availability considers hours, service area, skills, leave, duration and travel buffer.

## 8. Technical design and BOM

| Table | Core columns | Purpose |
|---|---|---|
| solar_designs | id, organisation_id, property_id, survey_id, design_number, system_type, revision, capacity_kw, status, assumptions JSONB, created_by | Design revision |
| solar_design_components | id, design_id, product_id nullable, description_snapshot, quantity, unit, component_role, specification_snapshot JSONB | BOM snapshot |
| design_validations | id, design_id, validation_version, result, errors JSONB, warnings JSONB, validated_at | Reproducible validation |
| design_approvals | id, design_id, reviewer_id, decision, comments, approved_at | Technical approval |
| design_change_requests | id, design_id, requested_by, reason, status, resolved_at | Controlled changes |

Approved designs are immutable. Changes create a new revision. BOM preserves product / specification snapshots even if catalogue data later changes.

## 9. Quotations and agreements

| Table | Core columns | Purpose |
|---|---|---|
| quotations | id, organisation_id, quote_number, customer_id, property_id, lead_id, project_id nullable, status, current_version_id, expires_at | Quote envelope |
| quotation_versions | id, quotation_id, version_number, currency_code, subtotal_paise, discount_paise, tax_paise, total_paise, terms_snapshot, design_id, created_by, approved_at, issued_at | Immutable version |
| quotation_items | id, quotation_version_id, product_id nullable, description_snapshot, sku_snapshot, quantity, unit, unit_price_paise, tax_rate, line_total_paise, item_type | Version line items |
| quotation_approvals | id, quotation_version_id, approver_id, approval_type, decision, comments, decided_at | Approval trail |
| quotation_acceptances | id, quotation_version_id, accepted_by, acceptance_method, accepted_at, ip_hash, evidence_path | Exact-version acceptance |
| quotation_events | id, quotation_id, version_id, event_type, actor_id, metadata JSONB, occurred_at | Sent / viewed / expiry history |
| agreements | id, organisation_id, project_id, quotation_version_id, agreement_number, status, document_path, sent_at, signed_at | Contract record |
| document_templates | id, organisation_id, template_key, version, content_path, active_from, active_to | Versioned templates |
| generated_documents | id, organisation_id, entity_type, entity_id, template_version, storage_path, checksum, generated_at, generated_by | Issued PDFs |

Issued quote prices, terms, tax, line descriptions and totals are snapshots. Never regenerate an old quote from current catalogue prices.

## 10. Project delivery

| Table | Core columns | Purpose |
|---|---|---|
| projects | id, organisation_id, project_number, customer_id, property_id, accepted_quote_version_id, project_manager_id, status, planned_start_at, planned_end_at, actual_start_at, completed_at | Delivery record |
| project_stage_definitions | id, organisation_id, stage_key, name, sequence, is_required | Configurable stage template |
| project_stages | id, project_id, stage_definition_id, status, started_at, completed_at, completed_by | Stage instances |
| project_tasks | id, project_id, stage_id, title, description, owner_id, status, due_at, completed_at, dependency_task_id | Execution tasks |
| project_assignments | id, project_id, user_id, assignment_role, assigned_at, unassigned_at | Team history |
| project_events | id, project_id, event_type, description, actor_id, metadata JSONB, occurred_at | Timeline |
| project_issues | id, project_id, task_id nullable, severity, description, owner_id, status, resolution, due_at | Blockers / rework |
| installation_checklists | id, project_id, checklist_type, revision, status, submitted_at, submitted_by | Installation checklist |
| commissioning_records | id, project_id, revision, test_data JSONB, result, reviewer_id, reviewed_at | Test evidence |
| handover_records | id, project_id, customer_acknowledged_at, acknowledged_by, checklist JSONB, document_set_id | Handover proof |

Project snapshots accepted quote and BOM. Required stages cannot be bypassed by frontend state manipulation.

## 11. Procurement and inventory

| Table | Core columns | Purpose |
|---|---|---|
| inventory_locations | id, organisation_id, location_code, name, address_id nullable | Warehouse / van / site |
| inventory_items | id, organisation_id, product_id, item_code, tracking_type, reorder_level | Stock-managed item |
| inventory_balances | id, inventory_item_id, location_id, quantity_on_hand, quantity_reserved, updated_at | Cached projection |
| inventory_movements | id, inventory_item_id, from_location_id, to_location_id, quantity, movement_type, reference_type, reference_id, actor_id, occurred_at | Append-only stock ledger |
| product_serials | id, product_id, serial_number, current_location_id, status, project_id nullable | Serial tracking |
| purchase_orders | id, organisation_id, po_number, supplier_id, status, currency_code, total_paise, ordered_at, expected_at | PO header |
| purchase_order_items | id, purchase_order_id, product_id, description_snapshot, quantity, unit_price_paise, received_quantity | PO lines |
| goods_receipts | id, purchase_order_id, receipt_number, received_by, received_at, status | Receipt header |
| goods_receipt_items | id, goods_receipt_id, purchase_order_item_id, quantity_received, quantity_accepted, discrepancy_notes | Inspected quantities |
| project_material_allocations | id, project_id, inventory_item_id, location_id, quantity_allocated, quantity_issued, status | Reservations / issues |

Stock changes only through movement records. Balance is a transactionally maintained projection. Prevent negative available stock under concurrent allocation.

## 12. Payments and finance

| Table | Core columns | Purpose |
|---|---|---|
| payment_records | id, organisation_id, payment_number, customer_id, project_id, currency_code, amount_paise, method, status, paid_at, external_reference, recorded_by | Payment claim / transaction |
| payment_allocations | id, payment_id, project_id, milestone_id nullable, allocated_paise | Allocation |
| payment_milestones | id, project_id, milestone_key, description, due_paise, due_at, status | Payment schedule |
| payment_verifications | id, payment_id, verifier_id, decision, evidence_reference, comments, verified_at | Reconciliation |
| payment_receipts | id, payment_id, receipt_number, document_path, issued_at, issued_by | Receipt for reconciled funds |
| refunds | id, original_payment_id, refund_number, amount_paise, reason, status, approved_by, processed_at | Linked refund |
| financial_ledger_entries | id, organisation_id, entry_type, reference_type, reference_id, debit_paise, credit_paise, currency_code, posted_at | Optional accounting ledger |

Client cannot update payment status. Provider callbacks require signature validation and idempotency. A customer-reported payment is not proof of settlement.

## 13. Installed products, warranty and support

| Table | Core columns | Purpose |
|---|---|---|
| installed_products | id, project_id, product_id, serial_number, installed_at, installed_location, warranty_id nullable | Equipment at customer site |
| warranty_terms | id, product_id, model_pattern, warranty_type, duration_months, terms_document_id, valid_from, valid_to | Source-backed model terms |
| warranties | id, installed_product_id, warranty_terms_id, start_date, end_date, registration_reference, status | Customer coverage |
| warranty_claims | id, organisation_id, claim_number, warranty_id, ticket_id, status, decision, decision_reason, submitted_at, decided_at | Claim lifecycle |
| support_tickets | id, organisation_id, ticket_number, customer_id, project_id nullable, installed_product_id nullable, category, priority, safety_flag, status, assigned_to, subject | Support case |
| ticket_messages | id, ticket_id, sender_id nullable, message, visibility, created_at | Customer / internal messages |
| ticket_assignments | id, ticket_id, assigned_to, assigned_by, assigned_at, unassigned_at | Assignment history |
| service_visits | id, ticket_id, booking_id nullable, assigned_team_id nullable, status, diagnosis, work_summary, completed_at | Field service |
| service_visit_parts | id, service_visit_id, product_id, quantity, serial_number nullable | Parts used |

Warranty coverage uses exact model / serial and source document, not brand name alone.

## 14. Notifications, integrations, files and audit

| Table | Core columns | Purpose |
|---|---|---|
| notification_templates | id, organisation_id, template_key, channel, version, subject_template, body_template, active | Versioned message templates |
| notification_jobs | id, organisation_id, event_key, recipient, channel, payload JSONB, status, attempts, next_attempt_at, idempotency_key | Async queue |
| notification_logs | id, notification_job_id, provider_message_id, provider_status, response_summary, attempted_at | Delivery attempts |
| integration_connections | id, organisation_id, provider_key, status, config_public JSONB, secret_reference | Provider config; secrets elsewhere |
| integration_events | id, organisation_id, provider_key, external_event_id, event_type, payload_redacted JSONB, received_at, processed_at, status | Webhook / sync events |
| file_metadata | id, organisation_id, storage_bucket, storage_path, original_name, mime_type, size_bytes, checksum, uploaded_by, entity_type, entity_id, visibility | Private file index |
| audit_logs | id, organisation_id, actor_id, action, entity_type, entity_id, before_data JSONB, after_data JSONB, request_id, occurred_at | Sensitive action log |
| outbox_events | id, organisation_id, aggregate_type, aggregate_id, event_type, payload JSONB, created_at, published_at | Transactional event outbox |

Never store raw SMTP passwords, API keys, access tokens or payment secrets in these tables. Store secret references only.

## 15. Relationship summary

- Organisation has memberships, staff, customers, leads, products and operational records.
- Customer has contacts, addresses, properties, leads, bookings, projects and tickets.
- Property has enquiries, bookings, surveys, designs and projects over time.
- Lead has activities, assignments and tasks; may link to customer and property.
- Booking has assignments and survey revisions.
- Survey has sections, answers, media and reviews.
- Design has BOM components, validations and approvals.
- Quotation has immutable versions; each version has items and approvals.
- Accepted quote version may create a project; preserve exact source version.
- Project has stages, tasks, issues, documents, milestones, payments, installed products and tickets.
- Product has specifications, documents, prices, supplier relationships and serials.
- Payment has allocations, verification events, receipts and possible refunds.
- Ticket has messages, assignments and service visits.

## 16. Indexing and scale

Start with measured indexes:
- Index foreign keys used for joins and filters.
- Queue index: organisation_id + status + created_at descending.
- Assigned work: assigned_to + status + due_at.
- Customer portal lists: customer_id + created_at descending.
- Project timeline: project_id + occurred_at descending.
- Unique business numbers per organisation.
- Unique provider event IDs and idempotency keys.
- Partial indexes for active / non-terminal records.
- GIN only for JSONB fields actually queried.
- Add full-text / trigram search when measured need justifies it.

For high-volume append-only audit, notification and integration tables, consider time partitioning once volume justifies it. Do not partition every table prematurely.

## 17. Supabase RLS and security

- Enable RLS on every exposed business table.
- Customer access derives from auth identity → customer-user mapping → owned customer / property / project.
- Staff access requires active organisation membership and explicit permission.
- Never trust a user-editable role or is_admin column in profiles.
- SECURITY DEFINER functions must use a safe search_path, validate caller and restrict execute grants.
- Service-role keys never enter browser bundles.
- Private storage policies mirror record ownership.
- Test cross-customer reads / writes, file access and role escalation.
- Audit role changes, approvals, payment verification, quote issue / acceptance, refunds, inventory movement and project completion.

## 18. Transaction boundaries and invariants

Implement server-side transactions for:
1. Create lead + initial activity + outbox event.
2. Confirm booking + prevent overlap + status history + outbox.
3. Submit survey + revision + review task.
4. Approve design + immutable approval snapshot.
5. Issue quote + totals + PDF job + outbox.
6. Accept quote + acceptance evidence + project + payment milestones.
7. Reconcile payment + allocations + receipt eligibility + outbox.
8. Receive goods + inventory movement + balance projection.
9. Allocate stock + prevent negative available quantity.
10. Complete commissioning / handover only after prerequisites.

Use idempotency keys for retried client requests and webhooks. Duplicate webhook delivery must not create a second payment or stock movement.

## 19. Retention and deletion

Define retention by data category and legal basis. Customer deletion requests require controlled identification, review of statutory / contractual retention, deletion or anonymisation where permitted, session revocation and audit. Redact personal data from analytics and integration payloads. Keep private files under approved retention rules.

## 20. Recommended implementation order

1. Organisations, profiles, memberships, roles and permissions.
2. Customers, contacts, addresses and properties.
3. Leads, activities, assignments and follow-ups.
4. Service types, areas, bookings and availability.
5. Surveys and private media.
6. Product catalogue and suppliers.
7. Designs, BOM and technical approvals.
8. Quotations, immutable versions and acceptance.
9. Projects, stages, tasks and documents.
10. Payment milestones, payments and reconciliation.
11. Inventory movements and procurement.
12. Support, warranty and service visits.
13. Notifications, outbox, integrations and audit hardening.

Do not create all tables before validating the workflows. Implement module-by-module migrations, RLS policies, constraints and tests.
