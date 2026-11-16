# Green Grid Solar Solutions — Product & Platform Documentation

> Central documentation repository for the discovery, design, specification and future implementation of the Green Grid Solar Solutions digital platform.

**Status:** Discovery / planning  
**Documentation version:** 0.1.0  
**Last updated:** 2026-11-16

## Purpose

This repository defines the business requirements, customer journeys, user experience, product catalogue, booking workflows, customer portal, internal operations, data model, integrations, security requirements and phased delivery plan for Green Grid Solar Solutions.

It is a planning repository, not application source code. Implementation should begin only after the business-critical facts and open decisions are validated.

## Product vision

Build a trustworthy, mobile-first solar commerce and operations platform that helps customers understand solar, evaluate a suitable system, request a site assessment, receive and approve a quotation, follow installation progress, access documents and warranties, and request after-sales support.

The platform should also give Green Grid staff a connected operational workspace for lead management, surveys, quotations, bookings, projects, inventory, payments and service requests.

## Documentation map

| Area | Document |
|---|---|
| Project governance | [Project charter](docs/01-strategy/project-charter.md) |
| Business discovery | [Business analysis](docs/01-strategy/business-analysis.md) |
| Audiences | [Personas and roles](docs/02-requirements/personas-and-roles.md) |
| Functional scope | [Product requirements](docs/02-requirements/product-requirements.md) |
| Journeys | [Customer journeys](docs/02-requirements/customer-journeys.md) |
| Website | [Information architecture](docs/03-experience/information-architecture.md) |
| Visual design | [Design system](docs/03-experience/design-system.md) |
| Catalogue | [Product catalogue requirements](docs/04-commerce/product-catalogue.md) |
| Solar calculator | [Calculator requirements](docs/04-commerce/solar-calculator.md) |
| Booking | [Booking and site survey](docs/05-operations/booking-and-survey.md) |
| Sales | [Quotation and payments](docs/05-operations/quotations-and-payments.md) |
| Delivery | [Installation project management](docs/05-operations/installation-management.md) |
| Support | [Customer support and warranty](docs/05-operations/support-and-warranty.md) |
| Customer portal | [Customer portal](docs/06-platform/customer-portal.md) |
| Admin | [Admin and staff operations](docs/06-platform/admin-and-operations.md) |
| Engineering | [Architecture](docs/07-technical/architecture.md) |
| Data | [Database model](docs/07-technical/database-model.md) |
| Security | [Security and privacy](docs/07-technical/security-and-privacy.md) |
| External systems | [Integrations](docs/07-technical/integrations.md) |
| Delivery | [Roadmap](docs/08-delivery/roadmap.md) |
| Validation | [Open questions and assumptions](docs/09-governance/open-questions.md) |
| Decisions | [Decision log](docs/09-governance/decision-log.md) |
| Research | [Research register](docs/09-governance/research-register.md) |

## Important source and confidence rules

This documentation distinguishes:
- **Observed:** visible in the supplied brochure or previously reviewed public-facing website material.
- **Proposed:** a product or process recommendation.
- **Unverified:** a business, legal, product or technical fact that must be confirmed by Green Grid.
- **External requirement:** a requirement that must be checked against current official regulations and scheme documentation before launch.

Do not publish unverified prices, product models, certifications, vendor status, warranties, customer testimonials, installation statistics or subsidy promises.

## Known initial observations

The supplied brochure advertises 3 kW at ₹1,21,990 after subsidy and 5 kW at ₹2,23,900 after subsidy. Earlier website review reported a 3 kW calculator estimate of ₹1,80,000–₹2,16,000. These are conflicting observed claims and must be reconciled with dated, itemised quotations before publication.

The brochure displays Adani Solar, Waaree Solar, Amaron, Luminous, Microtek and V-Guard brand names. This is not proof of current stock, authorised dealership, manufacturer partnership or specific product availability.

The brochure displays two phone numbers, while the previously reviewed website displayed different numbers. Confirm the official business contact details.

The brochure identifies a business location around 6th Mile, Erattupetta, near Nayara Pump, Aruvithura, Kerala 686579. Confirm the exact address and map pin with the business.

## Working principles

1. Customer trust and factual accuracy take priority over marketing claims.
2. A solar system is designed for a property and load profile; do not treat all systems as interchangeable packages.
3. A booking request is not a confirmed appointment until availability and staff assignment are validated.
4. A quotation is not an invoice; a subsidy estimate is not a discount received by the company.
5. Customer data must be isolated by account and protected with server-side authorization.
6. Every customer-facing status should have a defined internal owner and workflow.
7. Release features incrementally and test operational workflows before launch.

## How to contribute

- Record unresolved business facts in `docs/09-governance/open-questions.md`.
- Record consequential decisions in `docs/09-governance/decision-log.md`.
- Keep each feature's requirements, validation rules, edge cases and acceptance criteria in its own document.
- Update the research register when an external rule or claim is checked.
- Use dated, attributable evidence for prices, product specifications, warranties and regulatory statements.
