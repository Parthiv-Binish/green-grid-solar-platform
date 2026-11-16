-- Sales, project delivery, payments, support, notifications and audit.
create table public.quotations (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 quote_number text not null,
 customer_id uuid not null references public.customers(id),
 property_id uuid not null references public.properties(id),
 lead_id uuid references public.leads(id),
 status text not null default 'draft' check(status in ('draft','pending_technical_approval','pending_commercial_approval','approved_to_send','sent','viewed','accepted','revision_requested','declined','expired','cancelled','superseded')),
 current_version_id uuid,
 expires_at timestamptz,
 created_at timestamptz not null default now(),
 unique(organisation_id,quote_number)
);
create table public.quotation_versions (
 id uuid primary key default gen_random_uuid(),
 quotation_id uuid not null references public.quotations(id),
 version_number integer not null check(version_number>0),
 currency_code char(3) not null default 'INR',
 subtotal_paise bigint not null default 0 check(subtotal_paise>=0),
 discount_paise bigint not null default 0 check(discount_paise>=0),
 tax_paise bigint not null default 0 check(tax_paise>=0),
 total_paise bigint not null default 0 check(total_paise>=0),
 terms_snapshot jsonb not null default '{}'::jsonb,
 design_id uuid references public.solar_designs(id),
 created_by uuid references auth.users(id),
 approved_at timestamptz,
 issued_at timestamptz,
 created_at timestamptz not null default now(),
 unique(quotation_id,version_number)
);
alter table public.quotations add constraint quotations_current_version_fk foreign key(current_version_id) references public.quotation_versions(id);
create table public.quotation_items (
 id uuid primary key default gen_random_uuid(),
 quotation_version_id uuid not null references public.quotation_versions(id),
 product_id uuid,
 description_snapshot text not null,
 sku_snapshot text,
 quantity numeric(14,3) not null check(quantity>0),
 unit text not null,
 unit_price_paise bigint not null check(unit_price_paise>=0),
 tax_rate numeric(6,3) not null default 0 check(tax_rate between 0 and 100),
 line_total_paise bigint not null check(line_total_paise>=0),
 item_type text not null default 'product'
);
create table public.quotation_approvals (
 id uuid primary key default gen_random_uuid(),
 quotation_version_id uuid not null references public.quotation_versions(id),
 approver_id uuid not null references auth.users(id),
 approval_type text not null check(approval_type in ('technical','commercial','management')),
 decision text not null check(decision in ('approved','changes_requested','rejected')),
 comments text,
 decided_at timestamptz not null default now()
);
create table public.quotation_acceptances (
 id uuid primary key default gen_random_uuid(),
 quotation_version_id uuid not null unique references public.quotation_versions(id),
 accepted_by uuid references auth.users(id),
 acceptance_method text not null,
 accepted_at timestamptz not null default now(),
 evidence_path text
);
create table public.quotation_events (
 id uuid primary key default gen_random_uuid(),
 quotation_id uuid not null references public.quotations(id),
 version_id uuid references public.quotation_versions(id),
 event_type text not null,
 actor_id uuid references auth.users(id),
 metadata jsonb not null default '{}'::jsonb,
 occurred_at timestamptz not null default now()
);

create table public.projects (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 project_number text not null,
 customer_id uuid not null references public.customers(id),
 property_id uuid not null references public.properties(id),
 accepted_quote_version_id uuid not null unique references public.quotation_versions(id),
 project_manager_id uuid references auth.users(id),
 status text not null default 'awaiting_documents' check(status in ('awaiting_documents','design_finalisation','procurement','materials_ready','installation_scheduled','installation_in_progress','testing','commissioning_review','handover_pending','completed','on_hold','blocked','cancelled','rework_required')),
 planned_start_at timestamptz,
 planned_end_at timestamptz,
 actual_start_at timestamptz,
 completed_at timestamptz,
 created_at timestamptz not null default now(),
 unique(organisation_id,project_number)
);
create table public.project_stage_definitions (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 stage_key text not null,
 name text not null,
 sequence integer not null,
 is_required boolean not null default true,
 unique(organisation_id,stage_key)
);
create table public.project_stages (
 id uuid primary key default gen_random_uuid(),
 project_id uuid not null references public.projects(id) on delete cascade,
 stage_definition_id uuid not null references public.project_stage_definitions(id),
 status text not null default 'pending' check(status in ('pending','ready','in_progress','completed','blocked','skipped')),
 started_at timestamptz,
 completed_at timestamptz,
 completed_by uuid references auth.users(id),
 unique(project_id,stage_definition_id)
);
create table public.project_tasks (
 id uuid primary key default gen_random_uuid(),
 project_id uuid not null references public.projects(id) on delete cascade,
 stage_id uuid references public.project_stages(id),
 title text not null,
 description text,
 owner_id uuid references auth.users(id),
 status text not null default 'open' check(status in ('open','in_progress','blocked','completed','cancelled')),
 due_at timestamptz,
 completed_at timestamptz,
 dependency_task_id uuid references public.project_tasks(id)
);
create table public.project_events (
 id uuid primary key default gen_random_uuid(),
 project_id uuid not null references public.projects(id) on delete cascade,
 event_type text not null,
 description text,
 actor_id uuid references auth.users(id),
 metadata jsonb not null default '{}'::jsonb,
 occurred_at timestamptz not null default now()
);
create table public.project_issues (
 id uuid primary key default gen_random_uuid(),
 project_id uuid not null references public.projects(id) on delete cascade,
 task_id uuid references public.project_tasks(id),
 severity text not null check(severity in ('low','medium','high','critical')),
 description text not null,
 owner_id uuid references auth.users(id),
 status text not null default 'open' check(status in ('open','in_progress','resolved','closed')),
 resolution text,
 due_at timestamptz,
 created_at timestamptz not null default now()
);
create table public.commissioning_records (
 id uuid primary key default gen_random_uuid(),
 project_id uuid not null references public.projects(id) on delete cascade,
 revision integer not null default 1,
 test_data jsonb not null default '{}'::jsonb,
 result text not null check(result in ('passed','failed','conditional')),
 reviewer_id uuid references auth.users(id),
 reviewed_at timestamptz,
 unique(project_id,revision)
);
create table public.handover_records (
 id uuid primary key default gen_random_uuid(),
 project_id uuid not null unique references public.projects(id),
 customer_acknowledged_at timestamptz,
 acknowledged_by uuid references auth.users(id),
 checklist jsonb not null default '{}'::jsonb,
 document_set_id uuid
);

create table public.payment_milestones (
 id uuid primary key default gen_random_uuid(),
 project_id uuid not null references public.projects(id) on delete cascade,
 milestone_key text not null,
 description text,
 due_paise bigint not null check(due_paise>=0),
 due_at timestamptz,
 status text not null default 'pending' check(status in ('pending','partially_paid','paid','waived')),
 unique(project_id,milestone_key)
);
create table public.payment_records (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 payment_number text not null,
 customer_id uuid not null references public.customers(id),
 project_id uuid references public.projects(id),
 currency_code char(3) not null default 'INR',
 amount_paise bigint not null check(amount_paise>0),
 method text not null check(method in ('cash','upi','bank_transfer','card','gateway','cheque','other')),
 status text not null default 'reported' check(status in ('pending','reported','under_verification','received','failed','reversed','refunded')),
 paid_at timestamptz,
 external_reference text,
 recorded_by uuid references auth.users(id),
 created_at timestamptz not null default now(),
 unique(organisation_id,payment_number)
);
create table public.payment_allocations (
 id uuid primary key default gen_random_uuid(),
 payment_id uuid not null references public.payment_records(id),
 milestone_id uuid not null references public.payment_milestones(id),
 allocated_paise bigint not null check(allocated_paise>0),
 unique(payment_id,milestone_id)
);
create table public.payment_verifications (
 id uuid primary key default gen_random_uuid(),
 payment_id uuid not null references public.payment_records(id),
 verifier_id uuid not null references auth.users(id),
 decision text not null check(decision in ('verified','rejected','needs_review')),
 evidence_reference text,
 comments text,
 verified_at timestamptz not null default now()
);
create table public.payment_receipts (
 id uuid primary key default gen_random_uuid(),
 payment_id uuid not null unique references public.payment_records(id),
 receipt_number text not null unique,
 document_path text,
 issued_at timestamptz not null default now(),
 issued_by uuid references auth.users(id)
);
create table public.refunds (
 id uuid primary key default gen_random_uuid(),
 original_payment_id uuid not null references public.payment_records(id),
 refund_number text not null unique,
 amount_paise bigint not null check(amount_paise>0),
 reason text not null,
 status text not null default 'requested' check(status in ('requested','approved','processed','rejected')),
 approved_by uuid references auth.users(id),
 processed_at timestamptz
);

create table public.support_tickets (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 ticket_number text not null,
 customer_id uuid not null references public.customers(id),
 project_id uuid references public.projects(id),
 category text not null,
 priority text not null default 'normal' check(priority in ('low','normal','high','urgent')),
 safety_flag boolean not null default false,
 status text not null default 'open' check(status in ('open','triaged','assigned','in_progress','waiting_for_customer','waiting_for_supplier','resolved','closed','reopened','cancelled')),
 assigned_to uuid references auth.users(id),
 subject text not null,
 created_at timestamptz not null default now(),
 unique(organisation_id,ticket_number)
);
create table public.ticket_messages (
 id uuid primary key default gen_random_uuid(),
 ticket_id uuid not null references public.support_tickets(id) on delete cascade,
 sender_id uuid references auth.users(id),
 message text not null,
 visibility text not null default 'customer' check(visibility in ('customer','internal')),
 created_at timestamptz not null default now()
);
create table public.ticket_assignments (
 id uuid primary key default gen_random_uuid(),
 ticket_id uuid not null references public.support_tickets(id) on delete cascade,
 assigned_to uuid not null references auth.users(id),
 assigned_by uuid references auth.users(id),
 assigned_at timestamptz not null default now(),
 unassigned_at timestamptz
);
create table public.warranties (
 id uuid primary key default gen_random_uuid(),
 customer_id uuid not null references public.customers(id),
 project_id uuid references public.projects(id),
 product_model text not null,
 serial_number text,
 warranty_type text not null,
 start_date date not null,
 end_date date not null,
 terms_document_path text,
 registration_reference text,
 status text not null default 'active' check(status in ('active','expired','void','claimed')),
 check(end_date>=start_date)
);
create table public.warranty_claims (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 claim_number text not null,
 warranty_id uuid not null references public.warranties(id),
 ticket_id uuid references public.support_tickets(id),
 status text not null default 'submitted' check(status in ('submitted','under_review','information_requested','approved','rejected','repair_scheduled','completed')),
 decision_reason text,
 submitted_at timestamptz not null default now(),
 decided_at timestamptz,
 unique(organisation_id,claim_number)
);

create table public.notification_templates (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 template_key text not null,
 channel text not null check(channel in ('email','sms','whatsapp','in_app')),
 version integer not null default 1,
 subject_template text,
 body_template text not null,
 is_active boolean not null default true,
 unique(organisation_id,template_key,channel,version)
);
create table public.notification_jobs (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 event_key text not null,
 recipient text not null,
 channel text not null,
 payload jsonb not null default '{}'::jsonb,
 status text not null default 'queued' check(status in ('queued','processing','sent','failed','cancelled')),
 attempts integer not null default 0 check(attempts>=0),
 next_attempt_at timestamptz,
 idempotency_key text not null,
 created_at timestamptz not null default now(),
 unique(organisation_id,idempotency_key)
);
create table public.notification_logs (
 id uuid primary key default gen_random_uuid(),
 notification_job_id uuid not null references public.notification_jobs(id) on delete cascade,
 provider_message_id text,
 provider_status text,
 response_summary text,
 attempted_at timestamptz not null default now()
);
create table public.file_metadata (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 storage_bucket text not null,
 storage_path text not null,
 original_name text,
 mime_type text,
 size_bytes bigint check(size_bytes>=0),
 checksum text,
 uploaded_by uuid references auth.users(id),
 entity_type text,
 entity_id uuid,
 visibility text not null default 'private' check(visibility in ('private','customer','staff')),
 created_at timestamptz not null default now(),
 unique(storage_bucket,storage_path)
);
create table public.audit_logs (
 id bigint generated always as identity primary key,
 organisation_id uuid references public.organisations(id),
 actor_id uuid references auth.users(id),
 action text not null,
 entity_type text not null,
 entity_id uuid,
 before_data jsonb,
 after_data jsonb,
 request_id text,
 occurred_at timestamptz not null default now()
);
create index on public.audit_logs(organisation_id,occurred_at desc);
create index on public.notification_jobs(status,next_attempt_at);
create index on public.projects(organisation_id,status,created_at desc);
create index on public.support_tickets(organisation_id,status,created_at desc);
create index on public.payment_records(project_id,created_at desc);

do $$
declare t text;
begin
 foreach t in array array[
 'quotations','quotation_versions','quotation_items','quotation_approvals','quotation_acceptances','quotation_events',
 'projects','project_stage_definitions','project_stages','project_tasks','project_events','project_issues','commissioning_records','handover_records',
 'payment_milestones','payment_records','payment_allocations','payment_verifications','payment_receipts','refunds',
 'support_tickets','ticket_messages','ticket_assignments','warranties','warranty_claims',
 'notification_templates','notification_jobs','notification_logs','file_metadata','audit_logs'
 ] loop execute format('alter table public.%I enable row level security',t); end loop;
end $$;

-- Staff organisation access; customer reads are scoped through verified customer_users.
create policy "staff manage quotations" on public.quotations for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "customer reads own quotations" on public.quotations for select to authenticated using(private.is_customer_user(customer_id));
create policy "staff manage quote versions" on public.quotation_versions for all to authenticated using(exists(select 1 from public.quotations q where q.id=quotation_id and private.is_org_member(q.organisation_id))) with check(exists(select 1 from public.quotations q where q.id=quotation_id and private.is_org_member(q.organisation_id)));
create policy "staff manage quote items" on public.quotation_items for all to authenticated using(exists(select 1 from public.quotation_versions v join public.quotations q on q.id=v.quotation_id where v.id=quotation_version_id and private.is_org_member(q.organisation_id))) with check(exists(select 1 from public.quotation_versions v join public.quotations q on q.id=v.quotation_id where v.id=quotation_version_id and private.is_org_member(q.organisation_id)));
create policy "staff manage quote approvals" on public.quotation_approvals for all to authenticated using(exists(select 1 from public.quotation_versions v join public.quotations q on q.id=v.quotation_id where v.id=quotation_version_id and private.is_org_member(q.organisation_id))) with check(exists(select 1 from public.quotation_versions v join public.quotations q on q.id=v.quotation_id where v.id=quotation_version_id and private.is_org_member(q.organisation_id)));
create policy "staff read quote events" on public.quotation_events for select to authenticated using(exists(select 1 from public.quotations q where q.id=quotation_id and private.is_org_member(q.organisation_id)));
create policy "staff manage projects" on public.projects for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "customer reads own projects" on public.projects for select to authenticated using(private.is_customer_user(customer_id));
create policy "staff manage project stages" on public.project_stages for all to authenticated using(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id)));
create policy "staff manage project tasks" on public.project_tasks for all to authenticated using(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id)));
create policy "staff manage project events" on public.project_events for all to authenticated using(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id)));
create policy "staff manage project issues" on public.project_issues for all to authenticated using(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id)));
create policy "staff manage commissioning" on public.commissioning_records for all to authenticated using(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id)));
create policy "staff manage handover" on public.handover_records for all to authenticated using(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id)));
create policy "staff manage payment milestones" on public.payment_milestones for all to authenticated using(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id)));
create policy "staff manage payments" on public.payment_records for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "customer reads own payments" on public.payment_records for select to authenticated using(private.is_customer_user(customer_id));
create policy "staff manage payment allocations" on public.payment_allocations for all to authenticated using(exists(select 1 from public.payment_records pr where pr.id=payment_id and private.is_org_member(pr.organisation_id))) with check(exists(select 1 from public.payment_records pr where pr.id=payment_id and private.is_org_member(pr.organisation_id)));
create policy "staff manage payment verification" on public.payment_verifications for all to authenticated using(exists(select 1 from public.payment_records pr where pr.id=payment_id and private.is_org_member(pr.organisation_id))) with check(exists(select 1 from public.payment_records pr where pr.id=payment_id and private.is_org_member(pr.organisation_id)));
create policy "staff manage receipts" on public.payment_receipts for all to authenticated using(exists(select 1 from public.payment_records pr where pr.id=payment_id and private.is_org_member(pr.organisation_id))) with check(exists(select 1 from public.payment_records pr where pr.id=payment_id and private.is_org_member(pr.organisation_id)));
create policy "staff manage refunds" on public.refunds for all to authenticated using(exists(select 1 from public.payment_records pr where pr.id=original_payment_id and private.is_org_member(pr.organisation_id))) with check(exists(select 1 from public.payment_records pr where pr.id=original_payment_id and private.is_org_member(pr.organisation_id)));
create policy "staff manage tickets" on public.support_tickets for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "customer reads own tickets" on public.support_tickets for select to authenticated using(private.is_customer_user(customer_id));
create policy "staff manage ticket messages" on public.ticket_messages for all to authenticated using(exists(select 1 from public.support_tickets t where t.id=ticket_id and private.is_org_member(t.organisation_id))) with check(exists(select 1 from public.support_tickets t where t.id=ticket_id and private.is_org_member(t.organisation_id)));
create policy "staff manage ticket assignments" on public.ticket_assignments for all to authenticated using(exists(select 1 from public.support_tickets t where t.id=ticket_id and private.is_org_member(t.organisation_id))) with check(exists(select 1 from public.support_tickets t where t.id=ticket_id and private.is_org_member(t.organisation_id)));
create policy "staff manage warranties" on public.warranties for all to authenticated using(private.is_customer_user(customer_id) or exists(select 1 from public.customers c where c.id=customer_id and private.is_org_member(c.organisation_id))) with check(exists(select 1 from public.customers c where c.id=customer_id and private.is_org_member(c.organisation_id)));
create policy "customer reads own warranties" on public.warranties for select to authenticated using(private.is_customer_user(customer_id));
create policy "staff manage warranty claims" on public.warranty_claims for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage notification templates" on public.notification_templates for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage notification jobs" on public.notification_jobs for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff read notification logs" on public.notification_logs for select to authenticated using(exists(select 1 from public.notification_jobs n where n.id=notification_job_id and private.is_org_member(n.organisation_id)));
create policy "staff manage files" on public.file_metadata for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff read audit logs" on public.audit_logs for select to authenticated using(private.is_org_member(organisation_id));
-- Audit log writes are reserved for trusted server-side operations; no client insert/update/delete policy.
