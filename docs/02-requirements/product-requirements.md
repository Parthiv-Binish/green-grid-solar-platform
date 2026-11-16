# Product Requirements

## 1. Requirement conventions

Priority:
- **P0:** required for a safe and usable first public release.
- **P1:** important for the first connected customer / staff release.
- **P2:** later enhancement.

Each feature must have acceptance tests before implementation is considered complete.

## 2. Public website

### WEB-001 — Responsive public pages (P0)
The site must work on mobile, tablet and desktop. Navigation, forms, tables and calculators must remain usable at narrow widths.

Acceptance:
- No horizontal overflow at common mobile widths.
- Keyboard-accessible navigation and forms.
- Clear loading, empty, error and success states.
- Contact actions work on mobile.

### WEB-002 — Company information (P0)
Display verified business name, address, phone, email, service areas, operating hours and legal details where applicable.

Acceptance:
- All contact details match the approved business record.
- Unverified registrations or partnerships are not displayed.

### WEB-003 — Solar solution education (P0)
Explain on-grid, off-grid and hybrid systems, including limitations and suitable use cases.

Acceptance:
- Explain outage behaviour of standard grid-tied systems.
- Explain battery role and backup limitations.
- Avoid implying every property is suitable.

### WEB-004 — Product catalogue (P0)
Provide category, brand, specification and enquiry views for verified products.

Acceptance:
- Product data has source / verification date.
- Unavailable products are hidden or clearly marked.
- No invented ratings, reviews, stock or specifications.

### WEB-005 — Enquiry capture (P0)
Capture name, phone, preferred contact method, location / PIN code, customer type, service interest and consent.

Acceptance:
- Server-side validation.
- Spam and abuse protection.
- Duplicate handling.
- Confirmation reference.
- Lead is created in staff workspace.

### WEB-006 — Solar estimator (P0)
Provide indicative estimates using transparent assumptions. See dedicated calculator specification.

Acceptance:
- Results labelled estimates.
- No guarantee of savings or payback.
- Inputs and assumptions visible.
- User can request a site assessment.

### WEB-007 — Subsidy guide (P0)
Explain current official eligibility and application pathway with official links and last-reviewed date.

Acceptance:
- No guarantee of eligibility or approval.
- Scheme details reviewed before publication.
- Company's vendor status shown only after verification.

### WEB-008 — Projects and testimonials (P1)
Publish only genuine projects and customer feedback with permission.

Acceptance:
- Customer consent documented.
- Project capacity, location and photos verified.
- No fabricated testimonials or performance claims.

## 3. Enquiry and sales

### CRM-001 — Lead inbox (P1)
Staff can view, assign, qualify, update and close leads.

### CRM-002 — Follow-up tasks (P1)
Staff can record next action, due date, notes and outcome.

### CRM-003 — Lead source tracking (P1)
Capture website, referral, campaign, phone, walk-in and other approved sources.

## 4. Booking and surveys

### BOOK-001 — Service request (P0)
Customer can request a consultation or site survey.

### BOOK-002 — Availability validation (P1)
Requested slot must be checked against service area, staff capacity, working hours and existing appointments.

### BOOK-003 — Staff assignment (P1)
Authorised staff can assign / reassign surveyor and appointment.

### BOOK-004 — Survey checklist (P1)
Capture property, roof, shading, electrical and access details plus photos and notes.

## 5. Customer portal

### PORTAL-001 — Secure authentication (P1)
Use verified email or mobile authentication based on the selected provider and business decision.

### PORTAL-002 — Customer dashboard (P1)
Show enquiries, bookings, quotations, projects, documents and open support tickets.

### PORTAL-003 — Record isolation (P0 security)
Enforce customer ownership in database policies and server-side logic.

### PORTAL-004 — Document access (P1)
Allow authorised customers to download their own documents through time-limited access.

## 6. Quotations and projects

### SALES-001 — Versioned quotations (P1)
Quotation revisions must be retained and acceptance must refer to a specific version.

### SALES-002 — PDF proposal (P1)
Generate a branded, itemised document with terms and validity.

### PROJECT-001 — Project stages (P1)
Track procurement, scheduling, installation, inspection, commissioning and handover.

### PROJECT-002 — Evidence and handover (P1)
Store dated photos, checklists, test records and customer handover acknowledgement.

## 7. Payments and support

### PAY-001 — Payment ledger (P1)
Record method, amount, date, reference, stage, receipt and reconciliation status.

### PAY-002 — No false payment state (P0)
A payment is not marked received until verified by authorised staff or trusted gateway confirmation.

### SUPPORT-001 — Ticket creation (P1)
Customers can create tickets with category, description, urgency and optional attachments.

### SUPPORT-002 — Ticket lifecycle (P1)
Open, assigned, in progress, waiting for customer, resolved, closed.

### SUPPORT-003 — Warranty record (P1)
Store product identity, serial number, purchase / installation date, warranty terms and evidence.

## 8. Administration

### ADMIN-001 — Role-based access (P0)
Different permissions for management, sales, survey, technical, installation, accounts and support.

### ADMIN-002 — Audit trail (P0)
Record sensitive changes, actor, timestamp, affected record and relevant before / after values.

### ADMIN-003 — Configuration (P1)
Manage service areas, booking rules, business hours, product visibility and notification templates.

## 9. Non-functional requirements

- Security: server-side authorization and least privilege.
- Privacy: collect only necessary information and define retention.
- Reliability: graceful handling of failed integrations.
- Performance: optimise images and avoid blocking third-party scripts.
- Accessibility: semantic structure, keyboard navigation and readable contrast.
- SEO: metadata, sitemap, canonical URLs and structured data where accurate.
- Maintainability: modular code, migrations, tests and documented configuration.
- Observability: error logs, audit events and operational monitoring.
- Backup / recovery: documented database and file recovery process.
