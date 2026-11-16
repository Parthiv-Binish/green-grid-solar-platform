# Green Grid Solar Solutions — Product & Platform Documentation

> Central documentation repository for the discovery, design, specification and future implementation of the Green Grid Solar Solutions digital platform.

**Status:** Discovery / planning  
**Documentation version:** 0.2.0  
**Last updated:** 2026-11-16

## Purpose

This repository defines business requirements, customer journeys, user experience, catalogue, workflows, scalable data design, customer portal, staff operations, integrations, security and phased delivery.

## Product vision

Build a trustworthy, mobile-first solar platform that helps customers understand solar options, request a site assessment, receive and approve a quotation, follow installation progress, access documents and warranties, and request after-sales support. Staff receive a connected workspace for leads, surveys, quotations, bookings, projects, inventory, payments and service.

## Documentation map

| Area | Document |
|---|---|
| Project charter | [Project charter](docs/01-strategy/project-charter.md) |
| Business analysis | [Business analysis](docs/01-strategy/business-analysis.md) |
| Requirements | [Product requirements](docs/02-requirements/product-requirements.md) |
| Personas | [Personas and roles](docs/02-requirements/personas-and-roles.md) |
| Customer journeys | [Customer journeys](docs/02-requirements/customer-journeys.md) |
| Information architecture | [Website sitemap](docs/03-experience/information-architecture.md) |
| Design system | [Design system](docs/03-experience/design-system.md) |
| Catalogue | [Product catalogue](docs/04-commerce/product-catalogue.md) |
| Calculator | [Solar calculator](docs/04-commerce/solar-calculator.md) |
| Booking | [Booking and survey](docs/05-operations/booking-and-survey.md) |
| Quotations and payments | [Quotations and payments](docs/05-operations/quotations-and-payments.md) |
| Installation | [Installation management](docs/05-operations/installation-management.md) |
| Support | [Support and warranty](docs/05-operations/support-and-warranty.md) |
| Customer portal | [Customer portal](docs/06-platform/customer-portal.md) |
| Staff workspace | [Admin and operations](docs/06-platform/admin-and-operations.md) |
| Architecture | [Technical architecture](docs/07-technical/architecture.md) |
| Initial data model | [Database model overview](docs/07-technical/database-model.md) |
| Security | [Security and privacy](docs/07-technical/security-and-privacy.md) |
| Integrations | [Integrations](docs/07-technical/integrations.md) |
| Roadmap | [Delivery roadmap](docs/08-delivery/roadmap.md) |
| **Detailed workflows** | [End-to-end workflow specification](docs/10-workflows/end-to-end-workflow.md) |
| **Scalable database design** | [Scalable database design](docs/11-database/scalable-database-design.md) |
| Open questions | [Open questions](docs/09-governance/open-questions.md) |
| Decisions | [Decision log](docs/09-governance/decision-log.md) |
| Research | [Research register](docs/09-governance/research-register.md) |

## Important source and confidence rules

Distinguish observed information, proposed design, unverified business facts and external requirements. Do not publish unverified prices, product models, certifications, vendor status, warranties, testimonials, installation statistics or subsidy promises.

Known brochure and website price differences, contact-number differences, brand references and business address details must be verified with Green Grid before publication. Brand logos in a brochure do not prove current stock or authorised dealership.

## Working principles

1. Customer trust and factual accuracy take priority over marketing claims.
2. System suitability depends on property and load profile.
3. A booking request is not confirmed until a valid slot and staff resource are assigned.
4. A quotation is not an invoice; subsidy is not a company discount.
5. Customer data must be isolated with server-side authorization and RLS.
6. Every pending status has an owner, reason and next action.
7. Build incrementally with versioned migrations, acceptance tests and auditability.

## Contributing

Record unresolved facts in docs/09-governance/open-questions.md, decisions in docs/09-governance/decision-log.md and source verification in docs/09-governance/research-register.md. Keep requirements testable and avoid credentials or customer personal data in the repository.
