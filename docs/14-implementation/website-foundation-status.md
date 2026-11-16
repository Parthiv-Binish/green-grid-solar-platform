# Website foundation — implementation status

**Updated:** 16 November 2026  
**Branch:** `main`

## Implemented
- React 18 + Vite JavaScript application.
- React Router public layout, responsive navigation and shared footer.
- Public pages: Home, Solutions, Products, About and Contact.
- Shared SCSS token/base/component styling.
- Lucide icon package, keyboard skip link and visible focus styles.
- Products page with a deliberate empty state; it does not invent catalogue items.
- Contact form validation and consent checkbox. The form explicitly does not send or store submissions until a backend is connected.
- Initial homepage rendering test.
- GitHub Actions workflow configured for lint, test and build.
- Asset inventory, asset policy, original SVG solar illustrations and official brand/media source register.

## Generated image status
- Original SVG illustrations are committed for residential rooftop solar, commercial rooftop solar, battery storage and a generic installation team.
- A photorealistic commercial rooftop solar image was generated as an additional candidate on 16 November 2026. It is fictional illustrative imagery, not an actual Green Grid installation. It has not yet been committed as a binary asset.
- Other photorealistic categories (residential, technicians, equipment close-ups, site survey and maintenance) remain to be generated and reviewed.
- No fake government, utility, certification or manufacturer logo files have been added.

## Verification status
- Package scripts are configured for lint, test and production build.
- Missing ESLint dependencies and JSX parser configuration were corrected.
- Homepage test now renders within a MemoryRouter.
- **Runtime verification is still pending:** no successful local `npm install`, `npm run lint`, `npm test` or `npm run build` result is recorded in this repository session.
- GitHub Actions status for the latest commits has not returned a completed run. Do not treat CI as passed.

## Next engineering work
1. Run install, lint, test and production build; fix all findings.
2. Generate, optimise, review and commit original photorealistic visual assets as separate files.
3. Connect Supabase public read APIs for admin-managed catalogue/content.
4. Implement secure enquiry submission via server-side function with validation, rate limiting, consent record and spam controls.
5. Implement CMS/admin, CRM, booking and staff/customer authentication as separate feature modules.
6. Add component, integration and end-to-end tests; accessibility and performance audits.
7. Configure preview and production deployments after environment and domain ownership are confirmed.

## Release restrictions
Do not publish claims of guaranteed savings, subsidies, empanelment, certifications, partnerships, stock, warranty terms or completed projects without documentary evidence and business approval.
