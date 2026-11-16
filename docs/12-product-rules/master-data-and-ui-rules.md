# Master Data and UI Implementation Rules

**Status:** Mandatory product-wide requirement | **Applies to:** Public website, customer portal, staff workspace, admin pages, APIs, database and all deployment environments.

## 1. Non-negotiable data policy

Green Grid is a live business system, not a demo. Do not create or ship mock data, hardcoded business data, sample records, fabricated metrics, placeholder catalogue entries or static fallback payloads. A fresh environment must be honest about being unconfigured.

Migrations create schema, indexes, constraints, functions and security policies—not fictional business records. Do not seed customers, leads, products, brands, suppliers, prices, tariffs, bookings, staff schedules, projects, payments, testimonials, reviews or activity feeds.

The only exception is isolated automated testing: tests may generate synthetic records in a dedicated test database or rollback transaction. Test fixtures must never be imported by production runtime or deployment seed scripts.

## 2. Master data ownership

All changeable business master data is entered and maintained by authorised administrators through dedicated pages. No code change or redeployment should be needed to add a new service type, product, brand, supplier, service area, quote term, tax configuration or checklist template.

Each admin page should provide, as appropriate:
- List with search, filters, sorting and pagination.
- Create and edit forms with server-side validation.
- Detail view showing status, effective dates, dependencies and audit history.
- Activate/deactivate or archive actions with confirmation and impact warning.
- Permission checks on both UI and API.
- Empty, loading, error, no-results and no-permission states.

## 3. Admin modules to provide

| Admin area | Records maintained | Used by |
|---|---|---|
| Organisation | Legal/display details, branches, timezone, currency, operational settings | All modules |
| CRM configuration | Lead sources, priorities, loss reasons, task types | Enquiries and CRM |
| Customer/property | Configurable customer/property types and contact preferences | CRM, booking, projects |
| Services & coverage | Service types, durations, buffers, PIN-code/region coverage, booking policies | Booking and dispatch |
| Catalogue | Categories, brands, products, technical specs, documents, warranties, effective-dated prices | Design, BOM, quotations, inventory |
| Suppliers | Supplier records, contacts, supplier catalogue and lead times | Procurement |
| Inventory | Warehouses, storage locations, reorder thresholds, tracking rules | Procurement and projects |
| Commercial | Tax configurations, quote terms, discount policy, payment milestone templates, approval limits | Quotations and accounts |
| Delivery templates | Project stages, task templates, installation and commissioning checklists | Project operations |
| Support | Ticket categories, warranty types, service visit reasons and SLA policies | Support |
| Communications | Approved email/SMS/WhatsApp templates, sender settings and notification preferences | Notifications |
| Calculator configuration | Tariff schedules, assumptions, loss factors, source records and model versions | Public calculator and estimates |

Not every item should be freely editable. Internal statuses, permission identifiers and security rules remain controlled system definitions. Document each field as system-controlled or admin-managed.

## 4. Runtime and workflow behaviour

1. Operational forms load selectable values from authorised APIs backed by the database.
2. The API validates that selected master records exist, are active, are in scope for the organisation and are valid for the transaction date.
3. If no valid value exists, the form explains what is missing and links to the relevant admin page only for users with permission.
4. A missing configuration blocks only the affected action; it must not be bypassed with a default or fabricated value.
5. Existing transactions retain their original snapshots when master data changes later.
6. Deactivated records remain visible in historical detail but are unavailable for new transactions.
7. If a request fails, show a retryable error. Never silently substitute a hardcoded list, local JSON file or stale sample response.

### Examples

- No active products: product picker shows an empty state and points authorised admins to Catalogue.
- No service coverage for a PIN code: booking cannot be confirmed; staff can review coverage or handle an explicitly authorised exception.
- No staff availability: show no slots; never invent a slot.
- No active price/tax/terms: quotation cannot be issued until configured and approved.
- No tariff source: calculator requires a clearly identified manual assumption or reports that a reliable estimate cannot be calculated.
- No checklist template: the relevant installation/commissioning step cannot be marked complete.

## 5. Real-work design standard

The UI must support actual daily operations, not just look impressive in a screenshot.

- Use operational tables for queues and records that staff compare, sort, filter, assign and process.
- Each queue shows status, owner, age/created date, due date, priority and next action when relevant.
- Detail pages show real history, related entities, documents, current blockers and available actions.
- Keep actions contextual and permission-aware. Do not display controls that cannot work.
- Make transitions explicit: what happens now, who owns the next step, what remains pending and what condition unlocks the next action.
- Use real metric definitions, date ranges and drill-through; show genuine empty states when no records exist.
- Avoid decorative KPI cards, fake charts, fake activity, generic gradient-heavy layouts, excessive rounded cards, unnecessary animation and placeholder content.
- Prioritise fast scanning, keyboard access, clear validation and safe recovery from errors.

## 6. Security and audit

- Admin pages require explicit permissions, for example catalogue management, service configuration, commercial configuration, inventory management, templates management and calculator configuration.
- Hiding a button is not authorization. Enforce permission and organisation scope on the server and through RLS/RPC policies.
- Audit who changed a record, when, what changed and why for material changes.
- Protect secrets and integration credentials; never store them in master-data tables exposed to browser clients.
- Use effective dating and approval workflows for financially or technically sensitive configuration.

## 7. Definition of done

A feature is not complete until:
- It works with an empty database and shows a useful empty state.
- It reads all admin-managed data from the live database/API.
- It has no hardcoded fallback business data.
- Admin create/edit/deactivate flows work with permissions and audit history.
- Invalid, missing, inactive and cross-organisation references are rejected server-side.
- Historical records remain accurate after master-data edits.
- Loading, success, error, empty and no-access states are implemented.
- Tests prove the above using isolated generated test data, not production seed data.
