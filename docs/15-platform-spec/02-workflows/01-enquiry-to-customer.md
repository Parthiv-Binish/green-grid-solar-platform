# Workflow: Enquiry to Customer Conversion

## Stages
New → Contacted → Qualified → Survey scheduled → Survey completed → Quotation prepared → Quotation sent → Negotiation → Won / Lost / On hold.

Every transition is recorded in activity history.

## Enquiry fields
Enquiry ID; received timestamp; contact name; phone; WhatsApp number; email; site locality/address; customer category; requested system type; approximate electricity bill/consumption; expected capacity if known; source/campaign/referrer; assigned salesperson; notes; attachments; communication preferences.

Do not collect Aadhaar, bank details or sensitive documents at initial enquiry unless a documented need exists.

## Assignment and follow-up
New enquiries enter an unassigned queue or configured assignment rule. Assignment records actor and timestamp. Follow-ups include due date, owner, channel, outcome and next action. Overdue follow-ups appear on the responsible user's dashboard. Reassignment preserves history.

## Qualification and survey
Record use case, site availability, consumer category, approximate load/consumption, location, timeline and whether a survey is appropriate. Survey scheduling creates a linked survey record. Completion captures roof/site conditions, photographs, electrical supply details and technical notes. Do not promise subsidy or savings during qualification.

## Quotation
Quotation versions reference survey/design basis, components, taxes, exclusions, validity and warranty assumptions. Accepted versions are immutable; revisions create a new version.

## Won conversion
1. Lock enquiry and verify conversion eligibility.
2. Search for possible existing customer matches.
3. Create customer or link the confirmed existing customer.
4. Create project linked to customer and site.
5. Link accepted quotation, survey, documents and activity history.
6. Create default milestones and owner.
7. Record audit event and idempotency key.
8. Send customer invitation only after transaction commit.

A repeated conversion request returns the existing result and must not create duplicate projects.

## Lost and on hold
Lost requires a reason and optional notes. On hold requires a reason and review date. Reopening requires permission and is audited.

## Customer invitation
Customer record creation and app activation are separate. Invitation states: not invited, sent, activated, expired, revoked. A phone number alone does not create a login.

## Acceptance
Enquiry can be created/assigned; follow-ups are auditable; duplicate candidates are surfaced; Won conversion creates one customer/project transactionally; existing customers can receive additional projects; history remains linked; lost reasons are reportable.
