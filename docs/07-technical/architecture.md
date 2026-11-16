# Technical Architecture

## 1. Proposed stack

- Frontend: React + Vite + TypeScript.
- Styling: SCSS Modules.
- Animation: Framer Motion, used selectively.
- Icons: Lucide.
- Backend platform: Supabase.
- Database: PostgreSQL.
- Authentication: Supabase Auth.
- File storage: Supabase Storage.
- Server-side logic: Supabase Edge Functions / trusted server services.
- Hosting: Vercel (subject to project setup and deployment review).
- Notifications: approved email / WhatsApp / SMS providers.
- PDF: server-side generation.
- Monitoring: application error tracking and structured logs.

This is a proposed architecture and should be revisited if integration, scale, cost or operational constraints change.

## 2. Application boundaries

### Public application
SEO-friendly pages, product catalogue, estimator, lead capture and booking request.

### Customer portal
Authenticated customer workflows and private documents.

### Staff application
Role-protected CRM and operations workspace.

These may be delivered from one React application with clear route and module boundaries initially, or separated later if operational needs justify it.

## 3. Backend principles

- Database is the source of truth.
- Never trust client-provided role, customer ID, price, payment status or approval state.
- Validate all inputs server-side.
- Use database constraints and transactions for critical state changes.
- Use idempotency for payment callbacks and notification jobs.
- Store secrets only in server-side secret management.
- Keep external provider calls behind server functions.
- Use migrations for schema changes.
- Maintain staging and production environments.

## 4. Suggested code structure

```text
src/
  app/
  components/
  features/
    auth/
    catalogue/
    calculator/
    enquiries/
    bookings/
    customers/
    quotations/
    projects/
    payments/
    support/
    admin/
  layouts/
  lib/
  hooks/
  styles/
  types/
  routes/

supabase/
  migrations/
  functions/
  seed/

docs/
```

## 5. Environments

- Local development.
- Staging / preview.
- Production.

Use separate Supabase projects or appropriately isolated environments. Never use production customer data in development without an approved, privacy-safe process.

## 6. Quality strategy

- Unit tests for calculation and business rules.
- Integration tests for database policies and workflows.
- End-to-end tests for enquiry, booking, quotation acceptance and support.
- Accessibility checks.
- Responsive visual testing.
- Security tests for cross-customer access and role escalation.
- Backup restore test before production launch.
