# End-to-End Workflow Specification

**Status:** Proposed operational design | **Version:** 0.2.0

This document defines where each process starts, which screen and button the user interacts with, what the button does, the resulting status, who owns the next step, and what happens when work is pending or fails.

## 1. Global workflow rules

- The server validates every action. A button click is only a request, not proof that the action succeeded.
- Every important status transition records actor, timestamp, reason and related record.
- Pending records always have an owner, reason, next action and due date.
- Customer-facing status labels may be simpler, but map to controlled internal states.
- Notifications run asynchronously after the database transaction commits. Notification failure never rolls back a valid booking, quote or payment.
- Preserve history. Use cancel, archive, supersede or revise instead of deleting important business records.
- Mutation buttons prevent double-submit, preserve form data after recoverable errors and display field-level validation.

## 2. Roles

Visitor; Customer; Sales; Surveyor; Technical Reviewer; Project Lead / Installer; Accounts; Support; Manager; Administrator.

Permissions are evaluated per action, not merely by hiding buttons. A person holding multiple roles must still satisfy the permission required for the particular action.

## 3. Master lifecycle

Public visitor → Enquiry → Lead qualification → Customer / Property → Booking → Site survey → Technical design → Quotation → Customer acceptance → Agreement / Payment → Project → Procurement → Installation → Testing / Commissioning → Handover → Support / Warranty.

Not every enquiry becomes a project. Leads may be lost, duplicate, spam or placed on hold. A booking request is not confirmed until a valid slot and staff resource are assigned. A quote is not a project until an exact approved version is accepted.

## 4. Website enquiry

**From:** Public website / contact form / product page / calculator  
**To:** Staff CRM → New Leads

1. Visitor selects Request a Site Assessment, Get a Quote or Contact Us.
2. Form collects name, phone, contact preference, customer type, service interest, property location and optional notes.
3. Visitor reviews required privacy notice / consent and clicks Submit Enquiry.
4. Server validates required fields, phone format, consent, spam controls and duplicate candidates.
5. Server creates lead, contact details, initial activity and reference number in one transaction.
6. Confirmation page displays reference and next step.
7. Lead appears in New Leads queue; a confirmation notification is queued.

**Submit Enquiry button:** validate, submit, revalidate server-side, anti-spam check, create lead + activity + outbox event, return reference.

**Invalid data:** retain values, highlight fields and do not create a record.  
**Duplicate suspected:** preserve the enquiry and route for review; do not silently discard it.  
**Server error:** show retry message; do not show a success reference or clear the form.

## 5. Lead management

Internal statuses: New → Assigned → Contacted → Qualifying → Qualified → Survey Requested → Quotation in Progress → Converted. Alternative statuses: On Hold, Lost, Spam, Duplicate.

| Button | What it does | Required result |
|---|---|---|
| Open | Opens lead detail | Read permission |
| Assign | Assigns owner / team | Active eligible staff; assignment history |
| Claim Lead | Assigns to current staff | Only if unassigned or takeover allowed |
| Log Call | Adds call activity | Outcome and timestamp; history preserved |
| Send Message | Queues approved communication | Consent and channel validation |
| Mark Contacted | Changes status to Contacted | At least one contact activity |
| Qualify | Opens qualification fields | Captures need, customer type, location, serviceability and timeline |
| Mark Qualified | Changes status to Qualified | Required qualification fields complete |
| Create Booking | Opens booking form prefilled from lead | Property and service validated |
| Create Quote | Creates quote draft | Scope and technical input / explicit pending design |
| Put On Hold | Changes status to On Hold | Mandatory reason, owner and follow-up date |
| Mark Lost | Closes lead as Lost | Mandatory lost reason |
| Convert | Links lead to customer / project | Conversion rule satisfied; avoid duplicate customer |

After Assign, the lead is not automatically Contacted. After Mark Contacted, staff must create a next action. On Hold requires a follow-up date. Overdue follow-ups appear in My Tasks and management queues. Lost leads remain searchable and auditable.

## 6. Customer and property

**Create Customer:** validate identity/contact; check possible duplicates; create customer and contacts; link converted lead; write audit event; open customer profile. Similar names alone must not trigger automatic merging.

**Add Property:** collect property name, type, structured address, PIN code, optional coordinates, ownership / authorisation and access notes. One customer may have many properties. Each property may have multiple enquiries, surveys and projects over time.

**Set Primary Property:** changes default selection only; does not remove other properties. Address changes affecting active work must be audited.

## 7. Solar calculator

**From:** Calculator page  
**To:** Indicative result session → optional lead

1. Select residential / commercial.
2. Enter location, bill or kWh usage, tariff if known and objective (bill reduction, backup or both).
3. Optionally add roof, shading, load and backup information.
4. Click Calculate Estimate.
5. Server validates units and ranges; runs a versioned model; stores inputs, outputs and assumptions.
6. Result displays indicative ranges and caveats.
7. Request Assessment pre-fills a lead and sends it through the normal enquiry flow.

Calculate Estimate does not create a quotation or guarantee savings. Missing tariff / location data must be disclosed as an assumption. Request Assessment creates a lead only after contact and consent validation.

## 8. Booking and appointment

Statuses: Draft → Requested → Pending Confirmation → Confirmed → Assigned → In Progress → Completed. Other states: Reschedule Requested, Rescheduled, Cancelled by Customer, Cancelled by Business, No-show.

**Customer Request Appointment:** select service, property, preferred date/time, access notes and optional files; submit. Server checks service area and captures preferred slot. Booking is Requested / Pending Confirmation, never automatically Confirmed.

**Staff buttons:**
- Check Availability: checks working hours, holidays, service area, duration, buffers, skills, travel and existing assignments; no status change.
- Confirm Slot: rechecks conflicts transactionally, assigns eligible staff / team, stores committed time and changes status to Confirmed.
- Assign Staff: creates assignment history; staff must be active and qualified.
- Propose New Time: records alternative and reason; waits for customer response.
- Accept New Time: revalidates slot, then sets Rescheduled / Confirmed.
- Cancel Booking: requires reason, releases slot and notifies parties.
- Mark No-show: available only after appointment window; requires staff reason.
- Start Visit: assigned staff only; changes status to In Progress.
- Complete Visit: requires outcome and checklist; changes status to Completed and may create survey follow-up.

If no slot is available, booking remains Pending Confirmation / Awaiting Slot. Staff must propose alternatives or contact customer. Reminder jobs are invalidated when a booking is cancelled or rescheduled. Reminder failure does not cancel the appointment.

## 9. Site survey

**From:** Confirmed booking  
**To:** Submitted survey → Technical review

Surveyor opens My Visits → Start Survey → completes property, roof, shading, electrical, load, access and safety sections → adds measurements, notes and private photos → Save Draft or Submit Survey.

Statuses: Draft → In Progress → Submitted → Under Review → Approved for Design. Alternatives: Needs Information, Rejected, Superseded.

- Save Draft: saves partial work; no review task.
- Submit Survey: validates mandatory checklist; freezes submitted revision; creates review task.
- Request More Information: reviewer comment required; returns to Needs Information and assigns follow-up.
- Resubmit: creates a new revision and returns to review.
- Approve Survey for Design: authorised technical reviewer only; records reviewer and time. This means survey information is sufficient for design, not that the system design is approved.

A submitted survey is not silently edited. Amendments create a revision or explicitly reopen with audit.

## 10. Technical design and BOM

**From:** Approved survey  
**To:** Approved design revision → Quote-ready BOM

Technical user creates design, selects on-grid / off-grid / hybrid, capacity, panels, inverter, battery if needed, mounting and electrical BOS. Records assumptions, compatibility and exclusions.

- Run Validation: checks required components, quantities, compatibility and missing specifications. Read-only; does not approve.
- Submit for Review: requires blocking validation errors resolved; changes status to Under Review.
- Approve Design: authorised reviewer only; creates immutable approval snapshot.
- Return for Changes: requires reason; sends design to Changes Requested.

Statuses: Draft → Ready for Review → Under Review → Approved; or Validation Failed, Changes Requested, Superseded. Changes after approval create a new revision. Changes after customer acceptance require change order and customer approval.

## 11. Quotation

**From:** Approved design / qualified commercial scope  
**To:** Exact customer-accepted quote version → Project

Statuses: Draft → Pending Technical Approval → Pending Commercial Approval → Approved to Send → Sent → Viewed → Accepted. Alternatives: Revision Requested, Declined, Expired, Cancelled, Superseded.

| Button | Action / validation |
|---|---|
| Create Quotation | Select customer, property, approved design and scope |
| Save Draft | Saves editable draft; no customer notification |
| Add Item | Adds product or authorised custom line with description, quantity, unit, price |
| Calculate Total | Server calculates subtotal, discounts, tax and grand total; client total is not trusted |
| Submit for Approval | Validates items, totals, terms, validity, design and attachments; creates approval tasks |
| Approve | Records authorised approver and immutable approval event |
| Return for Changes | Requires reason; returns to draft / changes requested |
| Send to Customer | Only approved version; creates immutable PDF snapshot and secure portal / email delivery |
| Accept Quote | Customer accepts exact version, total and terms; records identity and timestamp |
| Request Revision | Requires reason; creates a new draft version; old version retained |
| Decline | Records decision; sales may follow up |
| Expire | Scheduled process marks expired after validity date if not accepted |

After acceptance: create project from accepted version; snapshot BOM and commercial terms; create payment milestones; notify operations. Draft or unapproved quotes cannot create projects. Issued quote content is immutable.

## 12. Agreement and payments

Agreement statuses: Draft → Sent → Signed; alternatives Declined / Void. Generate from accepted quote version and store signed document / evidence.

Payment statuses: Pending → Reported → Under Verification → Received; alternatives Failed, Reversed, Refunded.

- Customer Report Payment: amount, method, date, reference and optional proof; status becomes Reported, not Received.
- Accounts Verify Payment: checks cash / bank / gateway evidence and allocation; successful verification creates reconciliation event and sets Received.
- Reject Payment Claim: requires reason; customer can submit corrected claim.
- Record Cash Received: accounts permission; amount, date, receipt and verification evidence required.
- Issue Receipt: only for reconciled funds.
- Refund: separate transaction linked to original payment; requires approval and reason. Never delete original payment.

Partial payments remain partial. Milestone is paid only when reconciled allocations cover amount due. Payment screenshot alone is not settlement proof.

## 13. Procurement and inventory

**From:** Approved project BOM  
**To:** Goods received and allocated to project

1. Procurement checks stock.
2. Create Purchase Request for shortage.
3. Manager approves based on threshold.
4. Create and send Purchase Order.
5. Receive goods against PO.
6. Inspect quantity, condition and serial numbers.
7. Accept Goods or Record Discrepancy.
8. Accepted quantity creates inventory movement.
9. Allocate to Project validates available stock and records allocation.

Create PO requires buyer permission and approved request. Receive Goods records actual quantity. Accept Goods adds only inspected quantity. Record Discrepancy requires reason and evidence. Return to Supplier creates outbound movement. Stock is derived from movement ledger, not manually edited.

## 14. Project and installation

Stages: Awaiting Documents → Design Finalisation → Procurement → Materials Ready → Installation Scheduled → Installation In Progress → Testing → Commissioning Review → Handover Pending → Completed. Exceptions: On Hold, Blocked, Cancelled, Rework Required.

- Create Project: only from accepted quote; snapshots quote and BOM.
- Assign Project Lead: active eligible staff.
- Create Task: owner, due date, dependency and checklist.
- Mark Stage Ready: validates previous stage and required documents.
- Schedule Installation: requires materials, site access, assigned team and slot.
- Start Installation: assigned team only; records start.
- Upload Evidence: private file linked to project/task.
- Report Issue: severity, owner and target date required; creates blocker.
- Complete Installation: checklist and evidence required; moves to Testing, not Completed.
- Submit Commissioning: records test values and documents.
- Approve Commissioning: authorised technical reviewer; failure returns to Rework Required.
- Request Handover: requires commissioning approval, serials, warranty docs and customer guide.
- Complete Handover: customer acknowledgement and required documents; project can then be Completed.
- Put On Hold: reason, owner and next review date required.
- Resume: revalidates prerequisites and records event.

Installation completion alone does not complete a project. Testing, commissioning and handover are required.

## 15. Support and warranty

Ticket statuses: Open → Triaged → Assigned → In Progress → Waiting for Customer / Waiting for Supplier → Resolved → Closed. Alternatives: Reopened, Cancelled.

- Create Ticket: category, description, linked system / project and optional files; generates reference.
- Triage: priority, safety flag and category.
- Assign: support owner / team.
- Request Information: customer-visible message; status Waiting for Customer.
- Schedule Visit: creates service booking linked to ticket.
- Add Internal Note: staff-only visibility.
- Resolve: resolution code, work summary and evidence required.
- Close: after resolution and configured acknowledgement / response period.
- Reopen: requires reason; previous resolution remains in history.

Safety reports (shock, fire, smoke, burning smell, exposed wiring, water ingress) must be flagged and escalated under an approved safety procedure. Do not instruct customers to open electrical equipment.

Warranty claim statuses: Submitted → Under Review → Information Requested → Approved / Rejected → Repair Scheduled → Completed. Decisions require reviewer, reason and model-specific warranty evidence.

## 16. Pending queues

Every pending record displays reason, owner, entered-pending date, last activity, next action, due date and related customer / project.

Queues: New / Unassigned Leads; Leads Awaiting Customer; Overdue Follow-ups; Bookings Awaiting Confirmation; Surveys Awaiting Submission / Review; Designs Awaiting Approval; Quotes Awaiting Approval; Payments Awaiting Reconciliation; Purchase Orders Awaiting Receipt; Blocked Projects; Tickets Awaiting Assignment / Customer / Supplier; Warranty Claims Awaiting Decision.

Dashboard counts derive from records and define inclusion of cancelled / archived items. Pending without an owner or next action is an invalid operational state.

## 17. Notifications and errors

Event notifications: enquiry receipt; lead assignment; booking request / confirmation / change / cancellation; survey submission / review; quote sent / viewed / accepted / declined / expired; payment reported / verified / rejected; project milestone; installation; handover; ticket and warranty updates.

Queue notifications after transaction commit. Retry transient provider errors with backoff. Permanent failures enter staff review queue. Do not repeat the underlying business action when retrying a message.

All mutation buttons: disable during submit; use idempotency keys where relevant; return success only after server confirmation; preserve values after recoverable error; refresh from authoritative response; log sensitive changes. Destructive actions require confirmation and reason.

## 18. Acceptance test baseline

For every button test: permitted user; forbidden user; missing required field; invalid value; duplicate click; concurrent update; network failure; server failure; stale status; successful transition; audit entry; notification queued; notification failure; customer-visible status. Verify that failed actions leave the record in its prior valid state.
