# Notifications and External Integrations

## Provider architecture
Create adapters for official WhatsApp Business Platform, SMTP email, compliant SMS and push. Each adapter owns credentials, templates, send operation, delivery webhook parsing, retry classification and health.

## Channel strategy
Official WhatsApp is primary when consent and template/window rules permit. Email and push provide alternatives. SMS is for high-priority mobile-network fallback. Do not depend on unofficial WhatsApp Web automation for production delivery.

## Consent
Store recipient, channel, purpose, consent status, timestamp, source, notice/template version and opt-out timestamp. Separate transactional project/service updates from promotional messages. Verify legal and platform rules before sending.

## WhatsApp
Confirm Meta Business verification, phone-number ownership, approved templates, current pricing, quality/rate limits, webhook configuration and customer-service window/template rules. Re-check current Meta policy at implementation.

## OpenWA
OpenWA/WhatsApp Web automation is unofficial and may break due to session changes or platform enforcement. It is not reliable redundancy. Any experiment must be isolated from critical notifications and explicitly risk-accepted.

## SMS
Use a provider supporting applicable TRAI TCCCPR/DLT requirements. Confirm Principal Entity, header, template and consent requirements before production.

## Delivery states
pending, queued, processing, submitted, sent, delivered, read, failed, retry_scheduled, cancelled. Provider acceptance is not proof of delivery.

## Reliability
Idempotency per logical message; exponential backoff; bounded retries; dead-letter queue; error classification; webhook signature verification; duplicate webhook protection; delivery logs; audited manual resend; quiet hours and rate limits.

## Events
Enquiry received; survey scheduled; quotation ready; project accepted; installation scheduled/completed; meter pending; commissioning; subsidy update; device offline; case created/assigned/resolved; AMC renewal.

## External systems
Government portals: manual status mirroring unless authorised API confirmed. Manufacturer clouds: connector-specific approval. Payments: record references and reconcile; gateway optional and separately scoped. Accounting integration/export requires client confirmation.
