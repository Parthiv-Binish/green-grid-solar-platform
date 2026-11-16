# Design System and Product UI Rules

## 1. Design direction

**Direction:** Premium, modern, engineering-led sustainability with a credible enterprise operations interface.

The product must feel like software used daily by a real solar EPC / installation business—not a generic AI dashboard, landing-page template or visual concept. Prioritise task completion, operational clarity, accurate information and predictable behaviour over decoration.

Avoid generic AI patterns: oversized gradient panels inside admin screens, repeated rounded cards for every metric, excessive glassmorphism, decorative charts without decisions behind them, random icon tiles, unnecessary empty whitespace, fake activity feeds, fake metrics, stock-photo filler and animations that delay work.

## 2. Real operational UI principles

- Design each page around the user's job, the records they need and the next action they can take.
- Use clear page headers with title, context, primary action and relevant secondary actions.
- Use tables or structured lists when comparison, scanning, sorting, filtering, bulk selection or quick action matters. Do not turn every row into a card.
- Detail pages show summary, status, owner, key facts, related records, activity timeline and permitted actions.
- Keep navigation predictable and grouped by real work: CRM, Scheduling, Surveys, Design, Quotations, Projects, Procurement, Inventory, Accounts, Support, Catalogue and Administration.
- Use compact, consistent density for staff workspaces; use more spacious layouts for public/customer journeys.
- Show status, assignee, due date, age, priority and blockers where they drive action.
- Pending queues show owner, reason, next action and due date.
- Charts must use live data and answer an operational question. Include date range, units, filters and honest empty states.
- Metrics need clear definitions and drill-through to underlying records.

## 3. Master data and data presentation

- No mock, demo, sample or fabricated business data in any delivered environment.
- No hardcoded product lists, brands, suppliers, service areas, tax rates, tariffs, prices, payment terms, lead sources or other admin-managed values.
- Admin-managed values come from database-backed management pages and authorised APIs.
- Empty states explain what is missing and offer the correct authorised setup action. Never fill a blank table with examples or fabricated chart values.
- Loading, no-results, no-permission, stale-data and service-error states are distinct.
- Preserve historical snapshots for issued quotations, approved designs, completed work and financial transactions.

See [Master Data and UI Implementation Rules](../12-product-rules/master-data-and-ui-rules.md).

## 4. Proposed visual tokens

These are proposed tokens, not an approved existing brand standard. Confirm final brand colours and typography with Green Grid before public launch.

| Token | Hex | Use |
|---|---|---|
| Forest | `#102C24` | Primary brand, navigation, dark surfaces |
| Solar lime | `#D8F36A` | Primary CTA and restrained highlights |
| Warm white | `#F4F5EC` | Main light background |
| Sage | `#A6B9AC` | Secondary surfaces and muted accents |
| Energy amber | `#E5A34B` | Attention / energy accent |
| Charcoal | `#202824` | Main text |
| White | `#FFFFFF` | Content surfaces |
| Error | `#B93838` | Errors |
| Success | `#287A55` | Success states |

Use colour consistently and sparingly. Status must never be communicated by colour alone. Validate contrast for every pairing.

## 5. Typography and layout

- Headings: Manrope (proposed); body and UI: Inter (proposed).
- Use a clear type scale, readable line length and comfortable line height.
- Use consistent spacing, alignment grid, border treatment and radius system.
- Avoid all-caps body text, excessive condensed typography and oversized display text in operational screens.
- Use responsive layouts that preserve table usability, with intentional mobile alternatives.
- Forms use logical sections, clear labels, helper text and explicit required/optional indicators.

## 6. Core component behaviour

- Buttons use clear verb-led labels; distinguish primary, secondary, destructive and text actions.
- Tables use server-side pagination/filtering for large datasets; row actions enforce permissions.
- Forms show field-level errors, preserve values after recoverable failures, prevent duplicate submission and reflect actual save state.
- Status treatments show text labels, timestamps and transition history; never imply success before server confirmation.
- Dialogs are for focused confirmation or short tasks, not substitutes for full create/edit pages.
- Timelines show meaningful business events, actor and time—not fabricated activity.
- File uploads show restrictions, progress, retry and access scope.
- Notifications are actionable, deduplicated and linked to the relevant record.

## 7. Interaction and motion

- Subtle transitions for hover, focus and state changes only.
- Respect reduced-motion preferences.
- Never hide content behind animation or delay access.
- Actions show loading, success and failure feedback based on actual server responses.
- Preserve form values after recoverable errors.

## 8. Photography and assets

Prioritise actual Green Grid installations, team, products and service locations after obtaining permission. Until then, use properly licensed illustrative imagery and label it appropriately. Never present stock imagery as a Green Grid completed project. Product images and datasheets must come from verified catalogue records or approved asset sources.

## 9. Accessibility and responsive quality

Target WCAG 2.2 AA: keyboard access, visible focus, semantic headings and landmarks, accessible labels and errors, sufficient contrast, non-colour status cues, accessible dialogs/menus/tables, meaningful image alt text and captions/transcripts. Test narrow mobile, large mobile, tablet, laptop and wide desktop layouts using real content lengths.
