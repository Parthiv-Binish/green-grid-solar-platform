# Customer Portal

## 1. Purpose

Give customers a secure, useful place to manage their relationship with Green Grid after submitting an enquiry.

## 2. Dashboard

Show:
- Active enquiries.
- Upcoming appointments.
- Latest quotation status.
- Current project stage.
- Outstanding actions.
- Recent notifications.
- Open support tickets.

Do not show fabricated energy monitoring data. If no live monitoring integration exists, show project and service information only.

## 3. Account and profile

- Verified email / phone.
- Name and preferred contact method.
- Addresses and properties.
- Notification preferences.
- Consent records.
- Account deletion / privacy request path.

## 4. Enquiries and bookings

Customer can see status, submitted details, appointment date, assigned visit window and next action. Customer may request a reschedule or cancellation subject to business rules.

## 5. Quotations

- List quotation versions.
- View / download PDF.
- Compare revisions.
- Request clarification / revision.
- Accept or decline a specific version.
- Record acceptance timestamp and identity.

## 6. Projects

Show project milestones, customer-visible updates, planned appointment dates and completed evidence approved for customer sharing.

## 7. Documents

Examples:
- Accepted quotation.
- Agreement.
- Invoice / receipt.
- Product list and serials.
- Commissioning report.
- Warranty documents.
- Handover guide.
- Service reports.

Use private storage and short-lived signed URLs. Never use public buckets for personal documents.

## 8. Payments

Show recorded payments, status, receipt and balance based on the approved ledger. Make clear whether a payment is merely reported or reconciled.

## 9. Support

Create and track tickets, add messages and attachments, see appointment details and review resolution.

## 10. Security

Every customer query must be scoped to the authenticated customer on the server / database. UI hiding is not authorization. Test cross-account access explicitly.
