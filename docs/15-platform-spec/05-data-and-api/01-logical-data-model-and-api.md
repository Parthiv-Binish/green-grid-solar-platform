# Logical Data Model and API Outline

## Entity groups
Identity: users, groups, group_memberships, permissions, group_permission_rules, user_permission_rules, resource_assignments, delegations, temporary_elevations, audit_logs.

CRM: enquiries, enquiry_activities, follow_ups, customers, customer_contacts, customer_sites, surveys, survey_photos, quotations, quotation_items, contracts.

Operations: solar_projects, project_milestones, utility_applications, utility_milestones, regulatory_rules, suppliers, purchase_orders, inventory_items, inventory_movements, installations, installation_checklists, work_orders, work_order_assignments.

Connected solar/service: plants, devices, device_connectors, telemetry_points, device_events, device_alerts, service_cases, case_activities, sla_policies, warranties, warranty_claims, amc_contracts.

Finance/communications: invoices, invoice_items, payments, documents, customer_consents, notification_templates, notifications, notification_attempts.

## Relationships
Customer has many sites/projects. Enquiry may convert to customer/project. Project has surveys, quotations, contracts, utility applications, installations and plants. Plant has devices. Devices produce telemetry and alerts. Alerts may create cases. Cases create work orders.

## Conventions
UUID keys; snake_case; UTC timestamps; precise currency representation; foreign keys; unique constraints for external IDs/idempotency; immutable audit and approved quotation history. Logical model is not migration-ready DDL; exact types, nullability, indexes and tenant model require detailed design.

## API base
/api/v1

Authentication: POST /auth/login; POST /auth/otp/request; POST /auth/otp/verify; POST /auth/refresh; POST /auth/logout; GET /auth/me.

Enquiries: GET/POST /enquiries; GET/PATCH /enquiries/{id}; POST /enquiries/{id}/activities; POST /enquiries/{id}/follow-ups; POST /enquiries/{id}/assign; POST /enquiries/{id}/convert; POST /enquiries/{id}/mark-lost.

Customers/projects: GET/POST /customers; GET /customers/{id}; GET /customers/{id}/projects; GET/POST /projects; GET/PATCH /projects/{id}; GET /projects/{id}/timeline.

Surveys/quotes: POST /surveys; POST /surveys/{id}/photos; POST /quotations; POST /quotations/{id}/revisions; POST /quotations/{id}/send; POST /quotations/{id}/accept.

Utility: POST /projects/{id}/utility-applications; POST /utility-applications/{id}/milestones; GET /government/pending-meter; GET /government/pending-subsidy.

Cases/work orders: GET/POST /cases; GET/PATCH /cases/{id}; POST /cases/{id}/assign; POST /cases/{id}/resolve; GET /work-orders/my-assignments; POST /work-orders/{id}/start; POST /work-orders/{id}/complete.

Monitoring: GET /plants; GET /plants/{id}/overview; GET /plants/{id}/generation; GET /devices/{id}/telemetry; POST /integrations/{provider}/webhook; POST /gateways/{id}/telemetry.

## API standards
Pagination, filters, stable error envelope, correlation IDs, rate limits, idempotency for conversion/payment/webhook operations and OpenAPI schemas. Derive customer access from authenticated identity, never trust arbitrary client-supplied customer IDs.
