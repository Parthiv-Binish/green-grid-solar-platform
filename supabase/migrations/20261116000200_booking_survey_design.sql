-- Booking, site survey and solar system design.
create table public.service_types (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  service_key text not null,
  name text not null,
  duration_minutes integer not null check(duration_minutes between 10 and 1440),
  buffer_minutes integer not null default 0 check(buffer_minutes between 0 and 480),
  is_active boolean not null default true,
  unique(organisation_id,service_key)
);
create table public.service_areas (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  name text not null,
  pin_code text not null,
  region_code text,
  is_active boolean not null default true,
  unique(organisation_id,pin_code)
);
create table public.staff_availability (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  user_id uuid not null references auth.users(id),
  weekday smallint not null check(weekday between 0 and 6),
  start_time time not null,
  end_time time not null,
  effective_from date not null,
  effective_to date,
  check(end_time>start_time)
);
create table public.staff_time_off (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  user_id uuid not null references auth.users(id),
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  reason text,
  check(ends_at>starts_at)
);
create table public.bookings (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  booking_number text not null,
  customer_id uuid not null references public.customers(id),
  property_id uuid not null references public.properties(id),
  lead_id uuid references public.leads(id),
  service_type_id uuid not null references public.service_types(id),
  status text not null default 'requested' check(status in ('draft','requested','pending_confirmation','confirmed','assigned','reschedule_requested','rescheduled','in_progress','completed','cancelled_by_customer','cancelled_by_business','no_show')),
  requested_start_at timestamptz,
  requested_end_at timestamptz,
  confirmed_start_at timestamptz,
  confirmed_end_at timestamptz,
  customer_notes text,
  cancellation_reason text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(organisation_id,booking_number),
  check(requested_end_at is null or requested_start_at is null or requested_end_at>requested_start_at),
  check(confirmed_end_at is null or confirmed_start_at is null or confirmed_end_at>confirmed_start_at)
);
create index on public.bookings(organisation_id,status,created_at desc);
create index on public.bookings(customer_id,created_at desc);
create table public.booking_assignments (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings(id) on delete cascade,
  user_id uuid not null references auth.users(id),
  assignment_role text not null default 'surveyor',
  assigned_by uuid references auth.users(id),
  assigned_at timestamptz not null default now(),
  unassigned_at timestamptz
);
create table public.booking_status_history (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings(id) on delete cascade,
  from_status text,
  to_status text not null,
  reason text,
  actor_id uuid references auth.users(id),
  changed_at timestamptz not null default now()
);
create table public.site_surveys (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  booking_id uuid not null references public.bookings(id),
  property_id uuid not null references public.properties(id),
  survey_number text not null,
  revision integer not null default 1 check(revision>0),
  status text not null default 'draft' check(status in ('draft','in_progress','submitted','under_review','approved_for_design','needs_information','rejected','superseded')),
  submitted_at timestamptz,
  reviewed_by uuid references auth.users(id),
  approved_at timestamptz,
  created_at timestamptz not null default now(),
  unique(organisation_id,survey_number,revision)
);
create table public.survey_sections (
  id uuid primary key default gen_random_uuid(),
  survey_id uuid not null references public.site_surveys(id) on delete cascade,
  section_key text not null,
  completion_status text not null default 'incomplete' check(completion_status in ('incomplete','complete','not_applicable')),
  unique(survey_id,section_key)
);
create table public.survey_answers (
  id uuid primary key default gen_random_uuid(),
  survey_section_id uuid not null references public.survey_sections(id) on delete cascade,
  question_key text not null,
  answer_jsonb jsonb,
  notes text,
  unique(survey_section_id,question_key)
);
create table public.survey_media (
  id uuid primary key default gen_random_uuid(),
  survey_id uuid not null references public.site_surveys(id) on delete cascade,
  storage_path text not null,
  media_type text not null,
  caption text,
  captured_at timestamptz,
  uploaded_by uuid references auth.users(id),
  created_at timestamptz not null default now()
);
create table public.survey_reviews (
  id uuid primary key default gen_random_uuid(),
  survey_id uuid not null references public.site_surveys(id) on delete cascade,
  reviewer_id uuid not null references auth.users(id),
  decision text not null check(decision in ('approved_for_design','needs_information','rejected')),
  comments text,
  reviewed_at timestamptz not null default now()
);
create table public.solar_designs (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  property_id uuid not null references public.properties(id),
  survey_id uuid not null references public.site_surveys(id),
  design_number text not null,
  system_type text not null check(system_type in ('on_grid','off_grid','hybrid')),
  revision integer not null default 1 check(revision>0),
  capacity_kw numeric(10,3) check(capacity_kw>0),
  status text not null default 'draft' check(status in ('draft','ready_for_review','under_review','approved','validation_failed','changes_requested','superseded')),
  assumptions jsonb not null default '{}'::jsonb,
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now(),
  unique(organisation_id,design_number,revision)
);
create table public.solar_design_components (
  id uuid primary key default gen_random_uuid(),
  design_id uuid not null references public.solar_designs(id) on delete cascade,
  product_id uuid,
  description_snapshot text not null,
  quantity numeric(14,3) not null check(quantity>0),
  unit text not null,
  component_role text not null,
  specification_snapshot jsonb not null default '{}'::jsonb
);
create table public.design_validations (
  id uuid primary key default gen_random_uuid(),
  design_id uuid not null references public.solar_designs(id) on delete cascade,
  validation_version text not null,
  result text not null check(result in ('passed','failed','warning')),
  errors jsonb not null default '[]'::jsonb,
  warnings jsonb not null default '[]'::jsonb,
  validated_at timestamptz not null default now()
);
create table public.design_approvals (
  id uuid primary key default gen_random_uuid(),
  design_id uuid not null references public.solar_designs(id) on delete cascade,
  reviewer_id uuid not null references auth.users(id),
  decision text not null check(decision in ('approved','changes_requested','rejected')),
  comments text,
  approved_at timestamptz not null default now()
);

create or replace function public.set_updated_at()
returns trigger language plpgsql set search_path = '' as $$
begin new.updated_at := now(); return new; end; $$;
create trigger trg_bookings_updated_at before update on public.bookings
for each row execute function public.set_updated_at();

do $$
declare t text;
begin
 foreach t in array array['service_types','service_areas','staff_availability','staff_time_off','bookings','booking_assignments','booking_status_history','site_surveys','survey_sections','survey_answers','survey_media','survey_reviews','solar_designs','solar_design_components','design_validations','design_approvals'] loop
  execute format('alter table public.%I enable row level security',t);
 end loop;
end $$;

create policy "staff manage service types" on public.service_types for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage service areas" on public.service_areas for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage staff availability" on public.staff_availability for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage time off" on public.staff_time_off for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage bookings" on public.bookings for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "customer reads own bookings" on public.bookings for select to authenticated using(private.is_customer_user(customer_id));
create policy "staff manage booking assignments" on public.booking_assignments for all to authenticated using(exists(select 1 from public.bookings b where b.id=booking_id and private.is_org_member(b.organisation_id))) with check(exists(select 1 from public.bookings b where b.id=booking_id and private.is_org_member(b.organisation_id)));
create policy "staff read booking history" on public.booking_status_history for select to authenticated using(exists(select 1 from public.bookings b where b.id=booking_id and private.is_org_member(b.organisation_id)));
create policy "staff manage surveys" on public.site_surveys for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "customer reads own surveys" on public.site_surveys for select to authenticated using(exists(select 1 from public.properties p where p.id=property_id and private.is_customer_user(p.customer_id)));
create policy "staff manage survey sections" on public.survey_sections for all to authenticated using(exists(select 1 from public.site_surveys s where s.id=survey_id and private.is_org_member(s.organisation_id))) with check(exists(select 1 from public.site_surveys s where s.id=survey_id and private.is_org_member(s.organisation_id)));
create policy "staff manage survey answers" on public.survey_answers for all to authenticated using(exists(select 1 from public.survey_sections ss join public.site_surveys s on s.id=ss.survey_id where ss.id=survey_section_id and private.is_org_member(s.organisation_id))) with check(exists(select 1 from public.survey_sections ss join public.site_surveys s on s.id=ss.survey_id where ss.id=survey_section_id and private.is_org_member(s.organisation_id)));
create policy "staff manage survey media" on public.survey_media for all to authenticated using(exists(select 1 from public.site_surveys s where s.id=survey_id and private.is_org_member(s.organisation_id))) with check(exists(select 1 from public.site_surveys s where s.id=survey_id and private.is_org_member(s.organisation_id)));
create policy "staff manage survey reviews" on public.survey_reviews for all to authenticated using(exists(select 1 from public.site_surveys s where s.id=survey_id and private.is_org_member(s.organisation_id))) with check(exists(select 1 from public.site_surveys s where s.id=survey_id and private.is_org_member(s.organisation_id)));
create policy "staff manage designs" on public.solar_designs for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "customer reads own designs" on public.solar_designs for select to authenticated using(exists(select 1 from public.properties p where p.id=property_id and private.is_customer_user(p.customer_id)));
create policy "staff manage design components" on public.solar_design_components for all to authenticated using(exists(select 1 from public.solar_designs d where d.id=design_id and private.is_org_member(d.organisation_id))) with check(exists(select 1 from public.solar_designs d where d.id=design_id and private.is_org_member(d.organisation_id)));
create policy "staff manage design validations" on public.design_validations for all to authenticated using(exists(select 1 from public.solar_designs d where d.id=design_id and private.is_org_member(d.organisation_id))) with check(exists(select 1 from public.solar_designs d where d.id=design_id and private.is_org_member(d.organisation_id)));
create policy "staff manage design approvals" on public.design_approvals for all to authenticated using(exists(select 1 from public.solar_designs d where d.id=design_id and private.is_org_member(d.organisation_id))) with check(exists(select 1 from public.solar_designs d where d.id=design_id and private.is_org_member(d.organisation_id)));
