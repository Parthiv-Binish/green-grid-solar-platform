# Project Charter and Scope

## Vision
Give GreenGrid one connected operating platform for sales, project execution, customer communication, equipment monitoring and after-sales service.

## Outcomes
- Reduce enquiry leakage and missed follow-ups.
- Convert accepted enquiries into customer/project records without re-keying.
- Show project milestones, owners and blockers.
- Track utility, meter and subsidy delays.
- Trace equipment from procurement through warranty and service.
- Improve customer self-service and service transparency.
- Turn actionable device alerts into managed work.

## Applications
1. Internal web workspace for owner, sales, engineering, project management, accounts, procurement and support.
2. Customer mobile experience for project status, generation, documents, payments and service.
3. Technician mobile experience for assigned work, offline checklists, photos and equipment records.

Customer and technician experiences may share one React Native codebase with role-specific navigation and permissions.

## MVP scope
Authentication; group access; enquiry CRM; customer conversion; customer/site/project records; surveys; quotation revisions; project milestones; manual KSEB/PM Surya Ghar tracking; document vault; installation work orders; basic service cases; notifications; basic invoices/payment records; customer and technician app foundations.

## Later scope
Inventory depth; procurement; AMC and warranty/RMA; manufacturer telemetry connectors; automated alerts; advanced analytics; local Modbus gateways; advanced yield prediction; multi-branch and multi-company support.

## Not assumed
No confirmed public E-Kiran or National Portal API. No automatic government submissions. No remote inverter control in the first monitoring release. No assumption that all installations qualify for PM Surya Ghar subsidy. No assumption about GreenGrid actual brands or workflows until discovery.

## Stakeholders
Owner/sponsor, sales, survey/engineering, project management, technicians, accounts, support, customers, KSEB/utility counterparts, manufacturers and platform operator.

## Success measures
Enquiry response time, enquiry-to-survey conversion, survey-to-quotation time, quotation win rate, project cycle time, overdue milestones, meter-pending ageing, open cases, SLA attainment, repeat faults, AMC renewal and app adoption. Set targets only after measuring baseline.

## Approval gates
Discovery sign-off → SRS sign-off → UX approval → MVP acceptance → pilot approval → production readiness.
