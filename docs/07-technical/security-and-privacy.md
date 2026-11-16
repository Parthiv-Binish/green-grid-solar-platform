# Security, Privacy and Compliance Requirements

## 1. Security baseline

- Enforce authentication for customer and staff areas.
- Enforce authorization on server / database, not only in UI.
- Use Supabase RLS for customer data isolation.
- Restrict staff permissions by role.
- Protect secrets and service-role credentials.
- Validate file type, size and content where feasible.
- Use private object storage for customer documents.
- Use signed, short-lived download URLs.
- Rate-limit public forms and authentication endpoints.
- Add CAPTCHA / bot controls where proportionate.
- Use HTTPS.
- Apply secure headers and dependency updates.
- Log security-relevant events.
- Back up database and test recovery.

## 2. Privacy principles

- Explain why each data field is collected.
- Collect only what is required.
- Obtain appropriate consent for optional communications.
- Keep privacy notice version and consent record.
- Define retention for leads, customer accounts, bills and site photographs.
- Provide a process for access, correction, deletion and grievance requests.
- Avoid exposing customer names, phone numbers, property addresses or bills in public project galleries.
- Obtain explicit permission for customer testimonials and installation photos.

## 3. Indian compliance review

Before launch, obtain appropriate legal / compliance review for applicability and current obligations under:
- Digital Personal Data Protection Act, 2023 and rules / commencement provisions in force at launch.
- Information Technology Act and applicable rules.
- CERT-In directions where applicable to the service and entity.
- Consumer protection and e-commerce requirements where applicable.
- GST, invoicing and accounting requirements.
- Applicable electrical safety and installation standards.
- Current MNRE / PM Surya Ghar scheme requirements.
- KSEB / KSERC procedures and applicable regulations.

This document is a product security checklist, not legal advice. Applicability, commencement, exemptions and exact obligations must be checked with current official sources and qualified advisers.

## 4. Security test cases

- Customer A cannot read Customer B's records by changing an ID.
- Customer cannot access another customer's file URL.
- Sales user cannot change payment reconciliation.
- Technician cannot view company financial reports.
- Support user cannot edit approved quotation price.
- Unauthenticated visitor cannot call privileged database functions.
- Public form cannot set itself as an approved lead or confirmed booking.
- Payment webhook cannot be replayed to duplicate a payment.
- Audit log cannot be altered by ordinary staff.
- Removed staff access is revoked promptly.
