# Customer and Technician Mobile Applications

## Recommendation
React Native with Expo to share TypeScript models, validation and API utilities with web. Validate native capabilities, offline storage and background sync before finalising.

## Customer app screens
Home; My Solar Systems; plant details; generation history; energy flow where supported; estimated savings; project timeline; utility/subsidy status; documents; invoices/payment history; service request; ticket history; notifications; profile; consent/preferences; support/account deletion request.

Customers see only linked sites/projects. Show last data timestamp. Label estimates. Do not expose internal notes or staff-only documents. Customer record and app activation are separate.

## Technician app screens
My jobs; job detail; site/contact; navigation; checklist; equipment scan/serial capture; photographs; test readings; parts usage; fault diagnosis; visit notes; customer acknowledgement; completion submission; sync status.

## Offline mode
Persist assigned job data and drafts locally with appropriate protection. Queue changes with client-generated UUIDs/idempotency keys. Sync when online. Detect conflicts; never silently overwrite. Show unsynced records and last sync time. Restrict offline duration and purge local data on logout/revocation where feasible.

## Push
Use a suitable push provider such as Firebase Cloud Messaging. Store revocable device tokens, platform, app version and last_seen. Avoid sensitive personal information in push payloads.

## Authentication
Secure token storage; short-lived access token; rotating refresh token; revoke sessions on account disablement where appropriate. Rate-limit OTP and do not reveal whether a phone is registered.

## Accessibility
Readable contrast, scalable text, clear status labels, large touch targets, low-bandwidth behaviour, Malayalam/English localisation readiness and understandable errors.

## Acceptance
Customer cannot access another customer's project; technician cannot access unauthorised jobs; offline draft survives restart; duplicate sync does not duplicate work; photos upload resumably; expired sessions revoke access.
