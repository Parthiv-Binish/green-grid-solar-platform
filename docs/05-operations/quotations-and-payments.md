# Quotations and Payments

## 1. Quotation lifecycle

Draft → Technical review → Commercial approval → Sent → Viewed → Revision requested / Accepted / Declined / Expired.

Each revision receives a version number. Acceptance must bind to the exact quotation version, price, terms and validity date.

## 2. Quotation content

- Company identity and verified contact details.
- Customer and property details.
- Quotation number, issue date and validity.
- System type and proposed capacity.
- Panel make, model, wattage and quantity.
- Inverter make, model and capacity.
- Battery details if included.
- Mounting structure and electrical BOS.
- Installation and commissioning scope.
- Transport, civil and additional charges.
- Taxes and tax basis.
- Optional items and exclusions.
- Project timeline assumptions.
- Payment milestones.
- Warranty details and source.
- Subsidy estimate, separately identified and conditional.
- Terms, cancellation and validity.
- Technical approval and authorised issuer.

## 3. Pricing rules

- No public package price without a dated BOM and approved price list.
- Clearly label indicative prices.
- Never hide required installation or electrical costs.
- Separate company discount from government subsidy.
- Record discount approval and reason.
- Preserve old quotation versions.
- Do not edit an accepted quotation silently.

## 4. Payments

Payment record fields:
- Customer / project.
- Amount and currency.
- Method: UPI / bank transfer / cash / gateway / other.
- Payment date.
- Transaction / receipt reference.
- Payment stage.
- Recorded by.
- Verification status.
- Receipt document.
- Refund / reversal linkage if applicable.

Statuses:
- Pending.
- Reported by customer.
- Under verification.
- Received / reconciled.
- Failed.
- Reversed.
- Refunded.

Only verified gateway callbacks or authorised accounts reconciliation can mark funds as received. A screenshot alone is not proof of settlement.

## 5. Subsidy accounting

Do not record government subsidy as a customer payment to Green Grid. Track subsidy application / approval / disbursement as a separate informational workflow only if the company provides that service and has a lawful basis to store the details.

## 6. PDF generation

PDF should be versioned and immutable after issue. Include document identifier and generated timestamp. Provide a secure customer download path.
