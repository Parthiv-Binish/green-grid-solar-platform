# Database Model — Initial Logical Design

This is a conceptual model. Final SQL schema, constraints, indexes and RLS policies must be designed and reviewed before implementation.

## 1. Identity and access

- `profiles`: user profile linked to auth identity.
- `roles`: role definitions.
- `permissions`: permission definitions.
- `user_roles`: role assignments.
- `staff_profiles`: staff-specific information.

Do not store passwords in application tables.

## 2. Customer and property

- `customers`: customer business record.
- `customer_contacts`: verified contact methods.
- `properties`: customer-owned / managed property.
- `property_addresses`: structured address and PIN code.
- `customer_consents`: purpose, channel, text/version, timestamp and source.

## 3. Leads and CRM

- `leads`: enquiry and source.
- `lead_activities`: calls, messages and notes.
- `follow_up_tasks`: owner, due date and completion.
- `lead_assignments`: assignment history.

## 4. Catalogue and inventory

- `product_categories`.
- `brands`.
- `products`.
- `product_specifications`.
- `product_documents`.
- `product_prices` (restricted and dated).
- `suppliers`.
- `purchase_orders`.
- `purchase_order_items`.
- `inventory_locations`.
- `inventory_stock`.
- `inventory_movements`.
- `product_serials`.

## 5. Survey and system design

- `bookings`.
- `booking_assignments`.
- `site_surveys`.
- `site_survey_answers`.
- `site_survey_media`.
- `solar_systems`.
- `system_components`.
- `technical_approvals`.

## 6. Sales and project

- `quotations`.
- `quotation_versions`.
- `quotation_items`.
- `quotation_approvals`.
- `quotation_acceptances`.
- `agreements`.
- `projects`.
- `project_stages`.
- `project_tasks`.
- `project_assignments`.
- `project_documents`.
- `project_events`.
- `commissioning_records`.
- `handover_records`.

## 7. Finance

- `payment_records`.
- `payment_allocations`.
- `payment_receipts`.
- `refund_records`.
- `reconciliation_events`.

Use integer minor currency units (for example paise) or a carefully defined numeric decimal strategy. Never use floating point for money.

## 8. Support and warranty

- `registered_products`.
- `warranties`.
- `warranty_claims`.
- `support_tickets`.
- `ticket_messages`.
- `ticket_assignments`.
- `service_visits`.
- `service_visit_parts`.

## 9. Communication and audit

- `notification_templates`.
- `notification_jobs`.
- `notification_logs`.
- `audit_logs`.
- `file_metadata`.

## 10. Relationship principles

- A customer may have multiple properties.
- A property may have multiple enquiries and projects over time.
- A lead may convert to a customer and project; preserve the lead history.
- A quotation has multiple immutable versions.
- An accepted quotation version creates or links to a project.
- A project has multiple stages, tasks, components and documents.
- A project may have multiple payments and service tickets.
- A registered product belongs to a customer / project and has serial identity.

## 11. Data protection

Use RLS for customer-facing tables. Staff access must be role-scoped. Storage access must use private buckets and policies. Add indexes for foreign keys, status/date filters and common staff queues. Define retention and deletion behaviour for each personal-data category.
