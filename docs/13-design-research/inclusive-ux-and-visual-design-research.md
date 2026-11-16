# Inclusive UX and Visual Design Research — Green Grid Solar Solutions

**Status:** Research-backed design specification | **Version:** 1.0 | **Applies to:** Public website, customer portal, staff workspace and admin console

## 1. Executive direction

Green Grid must be understandable and usable by people with different ages, vision, hearing, dexterity, confidence with technology, literacy, devices and familiarity with solar energy. Do not design for an imagined average user or assume that older users all have the same needs. Make the default experience clear and calm, then provide accessible flexibility.

The product has two related but distinct experiences:

1. **Customer experience:** help a person understand solar, decide what they need, trust the business, request an assessment and follow their installation.
2. **Operations experience:** help staff process real work accurately, quickly and safely, with clear queues, records, ownership, approvals and audit trails.

The same design language should connect them, but the page density and interaction patterns should differ. Customer pages explain; staff pages organise and execute.

## 2. Research basis and interpretation

The recommendations below are grounded in:
- W3C WCAG 2.2: contrast, text resizing, reflow, non-text contrast, focus visibility, target size, keyboard access and understandable labels. https://www.w3.org/TR/WCAG22/
- W3C guidance for older users: navigation, page organisation, understandable language, consistent presentation and clear labels. https://www.w3.org/WAI/older-users/developing/
- Nielsen Norman Group research on older adults: difficulty with small targets, complex dropdowns and sliders, and the need to consider content, layout, navigation, forms, search and support. https://www.nngroup.com/reports/senior-citizens-on-the-web/
- GOV.UK Design System: evidence-led use of images, clear typography, components, forms and error patterns. https://design-system.service.gov.uk/
- GOV.UK image guidance: images should serve a user need; icons can be ambiguous; avoid text embedded in images; provide meaningful alternatives. https://design-system.service.gov.uk/styles/images/
- W3C Images Tutorial: informative, decorative and functional images require different text alternatives. https://www.w3.org/WAI/tutorials/images/
- Home Office User-Centred Design Manual: readable layout, scalable typography, left alignment, responsive structure and clear error identification. https://design.homeoffice.gov.uk/accessibility/page-structure/layout-typography
- Systematic review on accessible web design for older adults (2014–2023 literature): identifies varied barriers and interventions, reinforcing that older adults are not a homogeneous group. https://doi.org/10.1145/3763243

Interpretation: accessibility is not a separate “senior mode”. It is a quality baseline that benefits everyone, especially people using a small phone, in bright sunlight, with tired eyes, limited confidence or an unfamiliar technical topic.

## 3. Audience needs and design response

| Audience / situation | Likely need | Design response |
|---|---|---|
| First-time homeowner | Understand the service and next step | Plain-language explanations, visible process, direct contact option |
| Older homeowner | Read and tap confidently | Larger type, generous spacing, stable navigation, no tiny controls |
| Customer unfamiliar with solar | Understand system choices | Everyday examples, diagrams with text explanations, glossary for technical terms |
| Backup-focused household | Know what remains powered and for how long | Explain battery, essential loads and runtime assumptions; no vague “backup included” claims |
| Commercial decision-maker | Assess scope, assumptions and accountability | Structured technical/commercial details, downloadable proposal, clear contact |
| Existing customer | Find warranty, documents or support | Prominent support route, system/property selector, clear case reference |
| Staff member under time pressure | Process a queue without mistakes | Dense but legible tables, filters, visible status/owner/due date and safe actions |
| Staff using a phone on site | Complete work outdoors | Large touch controls, high contrast, short sections, save-draft, upload retry |

Do not infer a person's capability from age. Offer the same clear structure to all users and test with a diverse group.

## 4. Brand mark, logo and header placement

### 4.1 Logo asset governance
- Obtain the approved Green Grid logo files from the business owner. Do not redraw, approximate, recolour or invent a new logo from a screenshot.
- Request vector master (SVG/PDF/AI/EPS where available), transparent PNG variants, monochrome/reversed variants, brand colour values and usage rules.
- Keep the original master asset unchanged. Export web-optimised SVG/PNG variants from the approved source.
- Confirm whether the mark, wordmark and tagline are separate lockups and which variants are approved for light/dark backgrounds.
- Do not place the logo over busy photography or crop its clear space.

### 4.2 Placement
- Public desktop: logo at the far left of the primary header; primary navigation follows; one clear primary action on the right; account/login is secondary.
- Public mobile: compact logo at top left, menu control at top right, and a visible contact/request-assessment route without crowding the header.
- Customer portal: logo links to portal home; do not mix customer navigation with staff navigation.
- Staff workspace: use a compact brand mark in the fixed navigation rail/sidebar. Preserve more space for the active module and work content.
- Login pages: logo above the form, not as a large decorative hero.
- Footer: repeat the approved logo at restrained size with verified business contact details and policy links.
- Maintain consistent clear space and optical alignment. Do not stretch, rotate, add shadows, apply gradients or animate the logo.
- The logo itself must not carry essential instructions. Provide a text accessible name for a linked logo.

## 5. Photography, diagrams and image placement

### 5.1 Image purpose test
Use an image only if it helps a person understand the business, product, place, process or decision. Do not use imagery merely to fill blank space or make a page look “AI-designed”.

### 5.2 Image priority and source
1. Actual Green Grid installation photographs, only after business verification and permission.
2. Real team/service photographs, with consent.
3. Verified product photography and manufacturer datasheets linked to catalogue records.
4. Clearly identified explanatory diagrams or licensed illustrations.
5. Licensed stock imagery only where real imagery is unavailable and where it does not imply a Green Grid project or customer.

Never show stock solar panels as a completed Green Grid installation. Do not use fabricated customer portraits, fake project galleries, fake testimonials or AI-generated “proof” imagery.

### 5.3 Placement by page
- Homepage hero: one authentic, relevant installation/roof image or a restrained visual; headline, short explanation and primary CTA remain separate HTML text. Avoid text over busy imagery.
- Solution pages: image beside the explanation of the system type; follow with a written “what this means for your home/business” section.
- Product detail: consistent product image gallery near title; model/brand and key specifications as text beside or immediately below; show only verified catalogue content.
- Process page: simple numbered process diagram paired with written steps. Never rely on an image alone to explain the workflow.
- Project case study: actual site image, location only if approved, system details and verified project facts. Captions explain what is shown.
- Calculator: small explanatory diagrams only when they clarify inputs or results; do not let decorative imagery compete with the calculation.
- Booking/forms: no hero image; keep focus on the task.
- Staff/admin: use photographs only where they identify a real asset, document or site. Do not place decorative images in data tables or dashboards.

### 5.4 Image behaviour
- Use consistent aspect ratios within the same gallery/list context; preserve natural proportions and avoid arbitrary cropping of equipment.
- Use responsive image sizes, modern formats and lazy loading below the fold.
- Provide meaningful alt text for informative images; empty alt for decorative images; describe the action for functional image links.
- Do not bake headings, prices, phone numbers, labels or calls to action into image files.
- Put important image facts in adjacent text and captions.
- Provide zoom/full-size viewing for detailed product labels or technical drawings when useful.
- Respect image rights, consent, privacy and metadata; remove location/EXIF data from customer/site uploads where appropriate.

## 6. Icons and iconography

- Prefer a familiar, consistent icon family with consistent stroke weight, optical size and baseline.
- Icons must have one stable meaning across the product. Do not reuse one glyph for unrelated actions.
- Use visible text labels alongside icons for primary navigation, uncommon actions and high-consequence operations.
- Icon-only controls are acceptable only for universally recognisable, low-risk actions (for example close or search) and still require accessible names, tooltips where useful and a sufficiently large hit area.
- Never rely on colour or icon shape alone for status; pair with explicit text such as “Awaiting review”.
- Avoid emoji as interface icons, decorative icon tiles and obscure abstract glyphs.
- Use a consistent icon scale: small inline indicators, standard action icons and larger empty-state illustrations. Do not mix filled and outline styles randomly.
- Destructive actions must use an explicit text label and confirmation, not just a trash icon.

## 7. Text, language and content hierarchy

### 7.1 Reading order
Every page should answer in order:
1. Where am I?
2. What is this page for?
3. What can I do here?
4. What information do I need?
5. What happens after I act?

Use one clear H1, descriptive section headings, short paragraphs, bullets for steps and meaningful link text. Avoid walls of text, unexplained abbreviations, all-caps paragraphs, justified text and decorative display fonts for body copy.

### 7.2 Plain-language solar communication
Use the customer's language first, with technical term and explanation beside it:
- “System size” then “kilowatts (kW)”.
- “Electricity used” then “kilowatt-hours (kWh)”.
- “Battery backup” then “which appliances can run and estimated duration”.
- “On-grid” explain that it works with the electricity grid and does not provide backup during a grid outage unless the system is specifically designed for that.
- “Hybrid” explain how solar, battery and grid work together, with limitations.
- “Net metering” explain in plain language and clearly state that utility approval/rules apply.

Do not promise savings, payback, generation, subsidy eligibility, export credits or uninterrupted power without verified inputs and appropriate qualification. Explain estimates, assumptions and exclusions.

### 7.3 Typography
- Use a highly legible sans-serif family with clear distinction between similar characters.
- Body copy target: 16–18 CSS px on desktop and mobile; do not make essential text smaller to fit.
- Supporting labels should remain comfortably readable; avoid tiny muted metadata.
- Headings use a restrained scale and sentence case.
- Use relative units (rem/em), flexible line height and allow text resizing to 200% without loss of content or function.
- Left-align long-form content. Keep line length moderate; avoid full-width paragraphs on large displays.
- Ensure user text spacing overrides do not clip or overlap controls.

These are design targets; WCAG conformance must be evaluated against the actual rendered experience.

## 8. Colour, contrast and surfaces

- Use the existing proposed Forest / Solar Lime / Warm White palette only as a starting point; verify the approved brand palette before production.
- Body text and normal-size labels: at least 4.5:1 contrast against the background.
- Large text: at least 3:1.
- Meaningful component boundaries, focus indicators and graphical information: at least 3:1 against adjacent colours.
- Do not use pale grey text on white for essential content.
- Do not communicate error, success, warning or status through colour alone; add text and, where helpful, an icon.
- Use a restrained surface hierarchy: page background, content surface, subtle section surface, border/divider. Avoid stacking multiple nested cards.
- Shadows are for elevation only when necessary, not decoration.

## 9. Layout, boxes and cards

- Use a consistent grid and spacing scale. Align headings, controls, tables and content edges.
- Public pages: use a readable content width, generous but purposeful whitespace and clear section transitions.
- Staff pages: prioritise working area, compact navigation, clear page title, filters and record table.
- Use cards only when the item is a self-contained choice, summary or grouped content. Do not put every paragraph, metric or form field into a separate card.
- Cards should have a clear title, concise explanation, relevant image only when useful and one obvious action.
- Avoid excessive border radius, gradients, glass effects and unnecessary floating panels.
- Use dividers and whitespace to group related content before adding more boxes.
- Use tables for operational comparisons, product specifications, transaction history and queue processing.
- Do not make a whole card clickable if it contains multiple independent controls.

## 10. Navigation and page templates

### Public website
- Header navigation: Solutions, Products, How it works, Projects, About, Contact; Calculator and Request Assessment may receive stronger prominence based on user testing.
- Keep the primary CTA wording consistent: “Request a Site Assessment”.
- Add breadcrumbs on deep product, solution and project pages.
- Footer includes verified contact routes, service links, policies and social profiles only if maintained.
- Avoid multi-level hover-only menus. Mobile navigation must be keyboard/touch accessible.

### Customer portal
- Navigation organised around the customer's tasks: Overview, My Properties, Enquiries, Appointments, Quotes, Project, Documents, Payments, Warranty and Support.
- Use familiar labels (“My installation”, “My documents”), not internal project terminology.
- Show current progress as a simple step timeline with what is complete, what is happening and what is needed from the customer.
- Keep help/contact route visible.

### Staff workspace
- Use role-aware navigation and a consistent application shell.
- Main page begins with page title, context and primary action; then queue filters and actionable table/list.
- A staff home page should prioritise “My tasks”, overdue work, today's visits and pending approvals—not decorative KPIs.
- Record detail uses a predictable layout: identity/status header, key facts, actions, tabs/sections, related records and chronological activity.
- Use split panels only where they materially improve processing and remain usable at smaller widths.

## 11. Forms and decision flows

- Ask only for information required at that stage. Explain why sensitive documents or personal data are needed.
- Break long customer journeys into short steps with a visible progress indicator and the ability to go back.
- Ask one decision at a time where possible; group related fields under meaningful headings.
- Use explicit labels above fields; placeholders are examples, not labels.
- Mark required fields and explain optional fields.
- Prefer radio buttons for a small number of mutually exclusive choices; use select controls only for longer lists; avoid sliders for precise financial/technical values.
- Provide units beside numeric inputs and examples that clarify expected format.
- Validate on blur or submit appropriately; do not show premature red errors while the user is typing.
- On submit, show a concise error summary and inline field errors; preserve all entered values.
- Explain what happens after submit, who will contact the customer and expected next step. Do not invent response-time promises.
- Avoid irreversible actions in a single accidental tap. Confirm destructive or financially consequential actions.

## 12. Buttons, links and action hierarchy

- Use action labels that say what will happen: “Request a site visit”, “Save draft”, “Send quotation”, “Confirm appointment”.
- One dominant primary action per page/step. Secondary actions should be visually quieter.
- Destructive actions are separated from primary actions and require clear confirmation.
- Do not use “Click here”, vague “Submit” where a more descriptive label is possible, or multiple competing primary buttons.
- Make button hit areas generous. WCAG 2.2 AA minimum target size is 24 × 24 CSS px subject to exceptions; adopt a 44 × 44 CSS px design target for common touch controls where practical.
- Links must look like links and remain distinguishable without relying only on colour.

## 13. Tables, filters, status and dashboards

- Tables need descriptive column headers, stable sort behaviour, readable row height and visible row actions.
- On mobile, prioritise the most important fields and use a deliberate stacked layout or a clearly labelled horizontal table region; do not silently hide critical data.
- Filters must show active state and provide a clear reset.
- Status badges always include text and use consistent wording across modules.
- Queue rows should expose owner, due date, age and next action when relevant.
- Dashboard metrics must be live, defined and drillable. Empty data means an empty state, not zero-filled decorative charts or sample trends.
- Never fabricate an activity feed or “recent projects”.

## 14. Motion, feedback and error prevention

- Motion is subtle, brief and non-essential. Respect reduced-motion preferences.
- Do not animate content into view in a way that hides it or delays comprehension.
- Every action has a clear pending, success and failure state based on server confirmation.
- Prevent double submission, explain disabled actions and preserve data after recoverable errors.
- Use confirmation for destructive, financial and irreversible operations.
- Avoid auto-advancing carousels, auto-dismissed important alerts and time-limited forms unless required and explained.

## 15. Responsive and environmental use

- Mobile-first and responsive from 320 CSS px width; test portrait and landscape.
- Ensure reflow and zoom without losing functionality.
- Staff survey/installation pages should work outdoors: strong contrast, large controls, clear upload progress and resilient draft saving.
- Avoid hover-only functionality. Every action must work by keyboard and touch.
- Test on low-to-mid range Android devices and slower connections; prioritise image optimisation and lightweight page structure.
- Keep phone, email and WhatsApp contact routes accessible where the business supports them.

## 16. Research and validation plan

Do not sign off the design from developer preference or screenshot review alone.

### Participants
Recruit a small, diverse set of real participants, including:
- First-time residential solar prospects.
- Older adults with varied levels of smartphone confidence.
- People who prefer Malayalam and/or English.
- Existing customers if available.
- Staff from sales, survey, installation, accounts and support.

Do not assume every participant has the same needs. Obtain consent and do not collect unnecessary personal or health information.

### Tasks to test
1. Find out whether an on-grid system provides backup during a power cut.
2. Understand the difference between on-grid and hybrid.
3. Estimate a system using a monthly electricity bill.
4. Request a site assessment without creating an account.
5. Find the business contact details and service area.
6. Find an existing quote or installation status in the portal.
7. Raise a support request.
8. Staff: assign a lead, schedule a survey, record a survey result and identify the next pending action.
9. Admin: add a product/service area and verify it appears in the relevant operational form.

### Observe
- Can they identify where to start without coaching?
- Can they explain the next step in their own words?
- Do they understand the CTA before tapping?
- Do they misinterpret an icon, status, image or technical term?
- Do they notice errors and recover without losing data?
- Can they complete tasks with keyboard, touch and zoom?
- Where do they hesitate, backtrack or ask for help?

### Release gates
- Keyboard-only pass and screen-reader spot checks.
- WCAG 2.2 AA contrast, reflow, resize, focus, labels and target-size checks.
- 200% text resize and 400% zoom/reflow checks where applicable.
- Mobile testing at 320 CSS px and common Android screen sizes.
- No fake data, fake testimonials, unverified project images or hardcoded master data.
- Usability test findings documented with severity, evidence, owner and resolution.

## 17. Decisions still requiring business input

Do not invent these:
- Approved logo master files, brand palette and typography, including light/dark variants.
- Actual Green Grid project photographs and permissions.
- Real product photos, brand assets and manufacturer documents.
- Preferred language coverage and approved Malayalam translations.
- Confirmed public contact details, business hours and service areas.
- Approved customer-facing response-time promises and process descriptions.
- Which claims, case studies, testimonials and certifications are approved for publication.

## 18. Source register

1. W3C — Web Content Accessibility Guidelines (WCAG) 2.2: https://www.w3.org/TR/WCAG22/
2. W3C WAI — Developing Websites for Older People: https://www.w3.org/WAI/older-users/developing/
3. W3C WAI — Target Size Minimum (2.5.8): https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum
4. W3C WAI — Images Tutorial: https://www.w3.org/WAI/tutorials/images/
5. Nielsen Norman Group — UX Design for Seniors: https://www.nngroup.com/reports/senior-citizens-on-the-web/
6. GOV.UK Design System — Images: https://design-system.service.gov.uk/styles/images/
7. GOV.UK Design System — Error message: https://design-system.service.gov.uk/components/error-message/
8. GOV.UK Design System — Labels, legends and headings: https://design-system.service.gov.uk/get-started/labels-legends-headings/
9. Home Office User-Centred Design Manual — Layout and typography: https://design.homeoffice.gov.uk/accessibility/page-structure/layout-typography
10. Home Office User-Centred Design Manual — Understandable content and error identification: https://design.homeoffice.gov.uk/accessibility/standard/understandable
11. Accessible Web Design for Older Adults: Challenges and Solutions (systematic review): https://doi.org/10.1145/3763243
