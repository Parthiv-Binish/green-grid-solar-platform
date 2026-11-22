# Discovery, Acceptance and Verification Register

## Client discovery
### Company and hierarchy
Employee count and departments? Who approves sales, quotations, procurement, installation and finance? Branches and teams? Which staff belong to multiple groups?

### Enquiry and sales
Enquiry sources and capture tools? Assignment rules and follow-up cadence? Qualification criteria? When is a prospect a customer? Multiple sites/projects? Quotation approval and revision rules?

### Solar operations
Residential/commercial/industrial mix? On-grid/off-grid/hybrid/water heater? Exact module, inverter, battery and datalogger makes/models? Survey/installation forms? Procurement and serial tracking?

### Government
Vendor registration status? Who handles E-Kiran and National Portal? Current forms, fees, documents and stages? How are meter and subsidy delays followed up?

### Service and finance
Monthly case volume and common faults? AMC/cleaning/warranty processes? Existing accounting software? GST invoice needs, payment methods and reconciliation?

### Technology
Existing CRM/spreadsheets/messaging/monitoring portals? Manufacturer account/API access? Expected telemetry refresh? Language needs? Hosting and recovery expectations?

## Acceptance tests
1. Create enquiry, assign owner, add follow-up and mark lost.
2. Convert Won enquiry once; retry without duplicates.
3. Link another project to an existing customer.
4. Create survey, photos and quotation revisions.
5. Accept quotation and create milestones.
6. Update utility stage with source, updater and evidence.
7. Assign installation work and capture serials.
8. Create manual case and apply SLA escalation.
9. Ingest duplicate device event without duplicate alert/case.
10. Deliver notification and process duplicate webhook safely.
11. Verify cross-customer and cross-branch denial.
12. Restore database and document backup in test environment.

## Verification register
| Topic | Required verification | Owner |
|---|---|---|
| KSERC final regulation | Gazette text and applicability by category/capacity/date | Regulatory reviewer |
| PM Surya Ghar | Latest MNRE guideline, eligibility, CFA and deadline | Scheme administrator |
| KSEB/E-Kiran | Current workflow, forms, fees, timelines and vendor requirements | GreenGrid/KSEB |
| Portal APIs | Written confirmation of public/partner API access | GreenGrid/authority |
| Meter availability | Current official position | GreenGrid/KSEB |
| Electrical Inspectorate | Capacity-specific safety/inspection obligations | Electrical engineer |
| ALMM/DCR/BIS | Commissioning-date and scheme-specific rules | Procurement |
| GST | HSN/SAC and composite supply treatment | Tax professional |
| DPDP | Commencement and operational obligations | Privacy counsel |
| CERT-In | Applicability, logs and incident reporting | Security reviewer |
| WhatsApp | Current Meta policy, pricing and templates | Messaging admin |
| SMS | Current TRAI/DLT requirements | SMS provider |
| Manufacturer APIs | Model/firmware access, limits and cost | Manufacturer |
| App stores | Current fees and policies | App administrator |

## Evidence standard
For each external rule record official source URL, title, publication/effective date, access date, clause/page, applicability, reviewer and next review date. Media reports may inform operational risks but are not official live inventory.

## Disclaimer
This package is a planning specification, not legal, tax, electrical engineering or manufacturer integration approval. Verify regulatory values, subsidy eligibility, equipment compliance, APIs, prices and deadlines against current primary sources before implementation or customer communication.
