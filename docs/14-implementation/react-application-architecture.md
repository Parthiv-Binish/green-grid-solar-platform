# React application architecture and delivery plan

**Decision:** React JavaScript + Vite, React Router, SCSS Modules/global tokens and Lucide React. This explicitly records the requested JavaScript choice and supersedes the earlier proposed TypeScript option for the initial website.

## Application boundaries
- Public marketing website: SEO-friendly pages, solar education, solutions and assessment enquiries.
- Customer portal: authenticated customer records and documents.
- Staff workspace: CRM, surveys, quotations, projects, inventory, payments and support.
- Administration: authorised master-data and configuration management.

These are route and feature boundaries within one React app initially. Split into separately deployed apps only when scale, access-control or release requirements justify it.

## Engineering standards
- Keep components small and domain-oriented; avoid monolithic page files.
- Put network access in feature API modules, not presentational components.
- Validate in the browser for usability and on the server for security.
- Never ship secrets or service-role credentials to the browser.
- Backend/database enforces authorization even when routes are protected in React.
- Use SCSS Modules for feature styles and shared SCSS tokens.
- Keep business master data database-driven; no fake products, prices, staff, testimonials or project records.
- Generated solar photographs may be used as illustrative brand imagery, never captioned as actual customer installations or completed Green Grid projects.

## Delivery phases
1. Public website foundation and design QA.
2. CMS/admin-managed public content and catalogue.
3. Enquiry capture, CRM and assessment scheduling.
4. Customer portal and document access.
5. Surveys, system design, quotation and approval.
6. Project execution, procurement, inventory and payment records.
7. Support, warranty, reporting, security hardening and production release.

## Quality gates
- Build and lint pass.
- Unit, integration and end-to-end tests for critical workflows.
- WCAG 2.2 AA review, keyboard navigation, zoom/reflow and reduced-motion checks.
- Mobile testing from 320 CSS px and low/mid-range Android.
- No mock operational records or hardcoded business master data.
- Secrets and authorization remain server-side.
