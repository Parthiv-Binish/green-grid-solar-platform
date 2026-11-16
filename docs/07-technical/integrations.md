# Integrations

## 1. Government and utility information

- PM Surya Ghar national portal: https://pmsuryaghar.gov.in/
- MNRE: https://mnre.gov.in/
- KSEB rooftop solar portal: https://ekiran.kseb.in/
- KSERC: https://www.erckerala.org/ (verify current official domain and regulations before publishing)

Initially, provide verified information and outbound links. Do not claim an API integration or submit applications automatically unless a supported, authorised interface exists.

## 2. Maps and service areas

Possible use:
- Display verified office location.
- Capture property location.
- Validate serviceable PIN codes.
- Help staff plan survey routes.

Provider, cost, API terms and location-data handling must be reviewed.

## 3. Email

Use a transactional email provider with domain authentication (SPF, DKIM, DMARC). Templates should cover enquiry receipt, booking, quotation, project milestones, receipts, warranty and support.

## 4. WhatsApp and SMS

Use official provider / WhatsApp Business Platform integration where appropriate. Obtain channel consent, store message status, handle opt-out and avoid sending sensitive documents directly in messages.

## 5. Payments

Select gateway only after business confirms online collection policy. Verify webhook signatures server-side, implement idempotency, reconcile settlements and support offline payment records.

## 6. PDF documents

Generate quotations, invoices / receipts, agreements and service reports server-side. Documents must be versioned, access-controlled and reproducible.

## 7. Solar inverter monitoring

Potentially integrate manufacturer APIs or supported monitoring gateways. Verify:
- Supported brands and models.
- API availability and commercial terms.
- Customer authorisation.
- Data ownership and retention.
- Refresh frequency and service reliability.
- Meaning of generation, import, export and battery metrics.

Do not promise real-time monitoring until a specific integration is tested.

## 8. Analytics

Use privacy-conscious analytics. Avoid sending phone numbers, addresses, electricity bills, authentication details or other personal data to analytics platforms.
