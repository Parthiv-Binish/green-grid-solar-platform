# Green Grid Solar Solutions — Product & Platform Documentation

> Product, design, engineering and implementation repository for the Green Grid Solar Solutions digital platform.

**Status:** Active React JavaScript platform foundation; connected business workflows are being delivered incrementally  
**Documentation version:** 0.3.0  
**Last updated:** 2026-11-16

## Website development

The React + Vite JavaScript application is in the repository root. Run `npm install`, `npm run dev`, `npm test`, `npm run lint` and `npm run build`. Public routes include Home, Solutions, Products, Solar calculator, About and Contact. Product catalogue content remains empty until administrators publish verified product records. The contact form validates input but does not send or store enquiries until a trusted backend endpoint is configured.

The solar calculator is an educational estimate driven by visitor-entered assumptions. It is not an engineering design, quotation or savings promise. See [solar estimator](docs/14-implementation/solar-estimator.md), [React application architecture](docs/14-implementation/react-application-architecture.md) and [website foundation status](docs/14-implementation/website-foundation-status.md).

## Visual asset library

See [asset inventory](public/assets/ASSET-INVENTORY.md), [official logo and asset sources](public/assets/OFFICIAL-LOGO-ASSET-SOURCES.md), and [asset usage policy](public/assets/USAGE-POLICY.md). Generated solar scenes are illustrative brand imagery, not verified project evidence.

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
| **Master data and UI rules** | [Master data and UI implementation rules](docs/12-product-rules/master-data-and-ui-rules.md) |
| **Inclusive design research** | [Inclusive UX and visual design research](docs/13-design-research/inclusive-ux-and-visual-design-research.md) |
| Solar estimator | [Estimator model and limitations](docs/14-implementation/solar-estimator.md) |
| Open questions | [Open questions](docs/09-governance/open-questions.md) |
| Decisions | [Decision log](docs/09-governance/decision-log.md) |
| Research | [Research register](docs/09-governance/research-register.md) |

## Important source and confidence rules

Distinguish observed information, proposed design, unverified business facts and external requirements. Do not publish unverified prices, product models, certifications, vendor status, warranties, testimonials, installation statistics or subsidy promises. Missing admin-managed content must remain honestly empty rather than populated with invented records.

Known brochure and website price differences, contact-number differences, brand references and business address details must be verified with Green Grid before publication. Brand logos in a brochure do not prove current stock or authorised dealership.

## Working principles

1. Customer trust and factual accuracy take priority over marketing claims.
2. System suitability depends on property and load profile.
3. A booking request is not confirmed until a valid slot and staff resource are assigned.
4. A quotation is not an invoice; subsidy is not a company discount.
5. Customer data must be isolated with server-side authorization and RLS.
6. Every pending status has an owner, reason and next action.
7. Build incrementally with versioned migrations, acceptance tests and auditability.
8. Never expose privileged keys in browser code or commit credentials.

## Contributing

Record unresolved facts in docs/09-governance/open-questions.md, decisions in docs/09-governance/decision-log.md and source verification in docs/09-governance/research-register.md. Keep requirements testable and avoid credentials or customer personal data in the repository.


## GreenGrid enterprise platform specification

The consolidated business, product, architecture and implementation package is maintained separately under [docs/15-platform-spec/](docs/15-platform-spec/README.md). It includes the project charter, BRD, enquiry-to-customer workflow, project/utility/service workflows, SRS, architecture, logical data model/API outline, group authorization and security, IoT monitoring, notifications, mobile apps, roadmap/cost assumptions and discovery/acceptance register.
