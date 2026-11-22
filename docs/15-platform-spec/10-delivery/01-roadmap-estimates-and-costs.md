# Delivery Roadmap, Effort and Cost Assumptions

## Phases
| Phase | Scope | Indicative duration |
|---|---|---|
| 0 Discovery | Interviews, samples, workflow sign-off, data inventory | 1–2 weeks |
| 1 Core MVP | Auth/groups, CRM, conversion, customer/projects, surveys, quotations, utility tracking, documents, work orders, cases, notifications | 6–9 weeks |
| 2 Operations/mobile | Customer/technician apps, offline workflow, inventory, procurement, warranty, AMC, finance/reporting depth | 4–6 weeks |
| 3 Monitoring | First manufacturer connector, telemetry, dashboard, alert-to-case | 4–8 weeks |
| 4 Hardening | Migration, security, restore tests, training, pilot and release | 2–3 weeks |

Overall solo/small-team estimate: 17–28 weeks, with overlap possible. API access, migration, client response and regulatory review can extend this.

## Infrastructure planning estimate
| Item | Indicative monthly INR |
|---|---:|
| VPS 4 vCPU / 8 GB | 800–1,800 |
| Domain allocation | 100–150 |
| Object storage | 100–400 |
| Offsite backup | 100–300 |
| Monitoring/email allowance | 0–600 |
| Indicative subtotal | 1,100–3,250 |

Planning assumptions only, not supplier quotes. Validate provider pricing, GST, storage/egress and regional availability.

## External costs
WhatsApp depends on current Meta rate card, message category and recipient market; BSP may add fees. SMS/DLT depends on provider and traffic. Push platform charges depend on selected services. Google Play and Apple developer fees must be checked against current official terms. Manufacturer API onboarding may be free, paid or contract-restricted—VERIFY.

## Assumptions
One primary developer with occasional design/testing assistance; one project at a time; timely client decisions; no extensive legacy migration. Excludes gateway hardware, manufacturer fees, professional legal/tax advice and ongoing support staffing.

## Cost controls
Modular monolith; one mobile codebase; PostgreSQL/Redis; free TLS; object storage; avoid microservices/ClickHouse initially; configurable telemetry frequency; official APIs only where approved.

## Release gates
Discovery sign-off; SRS/UX sign-off; MVP acceptance; pilot acceptance; production readiness; post-launch review.
