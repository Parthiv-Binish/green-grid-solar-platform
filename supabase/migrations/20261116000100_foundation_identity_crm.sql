-- Green Grid Solar Solutions
-- Foundation: organisations, identity, RBAC, customers, properties and CRM.
create extension if not exists pgcrypto;

create table if not exists public.organisations (
  id uuid primary key default gen_random_uuid(),
  legal_name text not null,
  display_name text not null,
  status text not null default 'active' check (status in ('active','suspended','archived')),
  default_currency char(3) not null default 'INR',
  timezone text not null default 'Asia/Kolkata',
  gstin text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  avatar_path text,
  locale text not null default 'en-IN',
  timezone text not null default 'Asia/Kolkata',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.organisation_memberships (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  user_id uuid not null references auth.users(id),
  membership_status text not null default 'active' check (membership_status in ('invited','active','suspended','left')),
  joined_at timestamptz,
  created_at timestamptz not null default now(),
  unique (organisation_id,user_id)
);

create table public.roles (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid references public.organisations(id),
  role_key text not null,
  display_name text not null,
  is_system boolean not null default false,
  unique nulls not distinct (organisation_id,role_key)
);

create table public.permissions (
  id uuid primary key default gen_random_uuid(),
  permission_key text not null unique,
  description text
);

create table public.role_permissions (
  role_id uuid not null references public.roles(id) on delete cascade,
  permission_id uuid not null references public.permissions(id) on delete cascade,
  primary key (role_id,permission_id)
);

create table public.user_roles (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  user_id uuid not null references auth.users(id),
  role_id uuid not null references public.roles(id),
  granted_by uuid references auth.users(id),
  granted_at timestamptz not null default now(),
  revoked_at timestamptz
);
create index on public.user_roles(organisation_id,user_id) where revoked_at is null;

create table public.staff_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  employee_code text,
  department text,
  employment_status text not null default 'active' check (employment_status in ('active','inactive','suspended')),
  phone_work text
);

create table public.staff_skills (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.staff_profiles(user_id) on delete cascade,
  skill_key text not null,
  verified_by uuid references auth.users(id),
  verified_at timestamptz,
  unique(user_id,skill_key)
);

create table public.customers (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  customer_number text not null,
  customer_type text not null check (customer_type in ('individual','business')),
  display_name text not null,
  status text not null default 'active' check (status in ('active','inactive','archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid references auth.users(id),
  unique(organisation_id,customer_number),
  unique(organisation_id,id)
);

create table public.customer_users (
  customer_id uuid not null references public.customers(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  relationship text not null default 'owner' check (relationship in ('owner','authorised_contact','billing_contact')),
  verified_at timestamptz,
  created_at timestamptz not null default now(),
  primary key(customer_id,user_id)
);

create table public.customer_contacts (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references public.customers(id) on delete cascade,
  contact_type text not null check (contact_type in ('phone','email')),
  value_normalized text not null,
  display_value text not null,
  is_primary boolean not null default false,
  is_verified boolean not null default false,
  verified_at timestamptz,
  created_at timestamptz not null default now()
);
create index on public.customer_contacts(customer_id);
create index on public.customer_contacts(contact_type,value_normalized);

create table public.customer_addresses (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references public.customers(id) on delete cascade,
  address_type text not null default 'correspondence',
  address_line_1 text not null,
  address_line_2 text,
  locality text,
  district text,
  state text,
  country text not null default 'India',
  pin_code text,
  latitude numeric(9,6),
  longitude numeric(9,6),
  is_primary boolean not null default false,
  created_at timestamptz not null default now()
);

create table public.properties (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  customer_id uuid not null,
  property_name text not null,
  property_type text not null default 'residential' check (property_type in ('residential','commercial','industrial','institutional','other')),
  ownership_status text,
  status text not null default 'active' check (status in ('active','inactive','archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  foreign key (organisation_id,customer_id) references public.customers(organisation_id,id)
);
create index on public.properties(customer_id);

create table public.property_addresses (
  id uuid primary key default gen_random_uuid(),
  property_id uuid not null references public.properties(id) on delete cascade,
  address_line_1 text not null,
  address_line_2 text,
  locality text,
  district text,
  state text,
  country text not null default 'India',
  pin_code text,
  latitude numeric(9,6),
  longitude numeric(9,6),
  access_notes text,
  created_at timestamptz not null default now()
);

create table public.customer_consents (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references public.customers(id) on delete cascade,
  purpose text not null,
  channel text not null check (channel in ('email','sms','whatsapp','phone','other')),
  consent_status text not null check (consent_status in ('granted','withdrawn','denied')),
  notice_version text not null,
  source text,
  captured_at timestamptz not null default now(),
  withdrawn_at timestamptz
);

create table public.lead_sources (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  source_key text not null,
  label text not null,
  is_active boolean not null default true,
  unique(organisation_id,source_key)
);

create table public.leads (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  lead_number text not null,
  customer_id uuid,
  property_id uuid references public.properties(id),
  source_id uuid references public.lead_sources(id),
  customer_type text check (customer_type in ('individual','business')),
  service_interest text,
  status text not null default 'new' check (status in ('new','assigned','contacted','qualifying','qualified','survey_requested','quotation_in_progress','converted','on_hold','lost','spam','duplicate')),
  priority text not null default 'normal' check (priority in ('low','normal','high','urgent')),
  assigned_to uuid references auth.users(id),
  next_action_at timestamptz,
  lost_reason text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid references auth.users(id),
  unique(organisation_id,lead_number),
  foreign key(organisation_id,customer_id) references public.customers(organisation_id,id)
);
create index on public.leads(organisation_id,status,created_at desc);
create index on public.leads(assigned_to,status,next_action_at);
create index on public.leads(organisation_id,created_at desc);

create table public.lead_contacts (
  id uuid primary key default gen_random_uuid(),
  lead_id uuid not null references public.leads(id) on delete cascade,
  name text not null,
  phone_normalized text,
  email_normalized text,
  preferred_channel text,
  created_at timestamptz not null default now()
);
create index on public.lead_contacts(phone_normalized);
create index on public.lead_contacts(email_normalized);

create table public.lead_activities (
  id uuid primary key default gen_random_uuid(),
  lead_id uuid not null references public.leads(id) on delete cascade,
  activity_type text not null,
  direction text check (direction in ('inbound','outbound','internal')),
  outcome text,
  summary text,
  visibility text not null default 'internal' check (visibility in ('internal','customer')),
  actor_id uuid references auth.users(id),
  occurred_at timestamptz not null default now()
);
create index on public.lead_activities(lead_id,occurred_at desc);

create table public.lead_assignments (
  id uuid primary key default gen_random_uuid(),
  lead_id uuid not null references public.leads(id) on delete cascade,
  assigned_to uuid not null references auth.users(id),
  assigned_by uuid references auth.users(id),
  assigned_at timestamptz not null default now(),
  unassigned_at timestamptz,
  reason text
);

create table public.follow_up_tasks (
  id uuid primary key default gen_random_uuid(),
  organisation_id uuid not null references public.organisations(id),
  lead_id uuid references public.leads(id),
  customer_id uuid references public.customers(id),
  owner_id uuid references auth.users(id),
  title text not null,
  task_type text not null default 'follow_up',
  status text not null default 'open' check (status in ('open','in_progress','completed','cancelled')),
  due_at timestamptz not null,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  check (lead_id is not null or customer_id is not null)
);
create index on public.follow_up_tasks(owner_id,status,due_at);

create table public.lead_status_history (
  id uuid primary key default gen_random_uuid(),
  lead_id uuid not null references public.leads(id) on delete cascade,
  from_status text,
  to_status text not null,
  reason text,
  changed_by uuid references auth.users(id),
  changed_at timestamptz not null default now()
);

create or replace function public.set_updated_at()
returns trigger language plpgsql set search_path = '' as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create trigger trg_customers_updated_at before update on public.customers
for each row execute function public.set_updated_at();
create trigger trg_properties_updated_at before update on public.properties
for each row execute function public.set_updated_at();
create trigger trg_leads_updated_at before update on public.leads
for each row execute function public.set_updated_at();

-- RLS helper functions live outside exposed public API.
create schema if not exists private;
revoke all on schema private from public, anon, authenticated;
create or replace function private.is_org_member(target_org uuid)
returns boolean language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.organisation_memberships m
    where m.organisation_id = target_org
      and m.user_id = (select auth.uid())
      and m.membership_status = 'active'
  );
$$;
create or replace function private.is_customer_user(target_customer uuid)
returns boolean language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.customer_users cu
    where cu.customer_id = target_customer
      and cu.user_id = (select auth.uid())
      and cu.verified_at is not null
  );
$$;
revoke all on function private.is_org_member(uuid) from public;
revoke all on function private.is_customer_user(uuid) from public;
grant usage on schema private to authenticated;
grant execute on function private.is_org_member(uuid) to authenticated;
grant execute on function private.is_customer_user(uuid) to authenticated;

do $$
declare t text;
begin
  foreach t in array array[
    'profiles','organisation_memberships','roles','permissions','role_permissions','user_roles','staff_profiles','staff_skills',
    'customers','customer_users','customer_contacts','customer_addresses','properties','property_addresses','customer_consents',
    'lead_sources','leads','lead_contacts','lead_activities','lead_assignments','follow_up_tasks','lead_status_history'
  ] loop
    execute format('alter table public.%I enable row level security',t);
  end loop;
end $$;

create policy "profile self read" on public.profiles for select to authenticated using (user_id=(select auth.uid()));
create policy "profile self update" on public.profiles for update to authenticated using (user_id=(select auth.uid())) with check (user_id=(select auth.uid()));
create policy "membership self read" on public.organisation_memberships for select to authenticated using (user_id=(select auth.uid()));
create policy "customer user reads linked customer" on public.customers for select to authenticated using (private.is_customer_user(id) or private.is_org_member(organisation_id));
create policy "customer user reads own contacts" on public.customer_contacts for select to authenticated using (private.is_customer_user(customer_id) or exists(select 1 from public.customers c where c.id=customer_id and private.is_org_member(c.organisation_id)));
create policy "customer user reads own addresses" on public.customer_addresses for select to authenticated using (private.is_customer_user(customer_id) or exists(select 1 from public.customers c where c.id=customer_id and private.is_org_member(c.organisation_id)));
create policy "customer user reads own properties" on public.properties for select to authenticated using (private.is_customer_user(customer_id) or private.is_org_member(organisation_id));
create policy "customer user reads own property address" on public.property_addresses for select to authenticated using (exists(select 1 from public.properties p where p.id=property_id and (private.is_customer_user(p.customer_id) or private.is_org_member(p.organisation_id))));
create policy "customer user reads own consents" on public.customer_consents for select to authenticated using (private.is_customer_user(customer_id) or exists(select 1 from public.customers c where c.id=customer_id and private.is_org_member(c.organisation_id)));

-- Staff-only CRM access. Customer self-service enquiry submission is via a validated server endpoint.
create policy "staff read leads" on public.leads for select to authenticated using (private.is_org_member(organisation_id));
create policy "staff manage leads" on public.leads for all to authenticated using (private.is_org_member(organisation_id)) with check (private.is_org_member(organisation_id));
create policy "staff read lead contacts" on public.lead_contacts for select to authenticated using (exists(select 1 from public.leads l where l.id=lead_id and private.is_org_member(l.organisation_id)));
create policy "staff manage lead contacts" on public.lead_contacts for all to authenticated using (exists(select 1 from public.leads l where l.id=lead_id and private.is_org_member(l.organisation_id))) with check (exists(select 1 from public.leads l where l.id=lead_id and private.is_org_member(l.organisation_id)));
create policy "staff read lead activities" on public.lead_activities for select to authenticated using (exists(select 1 from public.leads l where l.id=lead_id and private.is_org_member(l.organisation_id)));
create policy "staff insert lead activities" on public.lead_activities for insert to authenticated with check (exists(select 1 from public.leads l where l.id=lead_id and private.is_org_member(l.organisation_id)));
create policy "staff read lead assignments" on public.lead_assignments for select to authenticated using (exists(select 1 from public.leads l where l.id=lead_id and private.is_org_member(l.organisation_id)));
create policy "staff manage lead assignments" on public.lead_assignments for all to authenticated using (exists(select 1 from public.leads l where l.id=lead_id and private.is_org_member(l.organisation_id))) with check (exists(select 1 from public.leads l where l.id=lead_id and private.is_org_member(l.organisation_id)));
create policy "staff manage followups" on public.follow_up_tasks for all to authenticated using (private.is_org_member(organisation_id)) with check (private.is_org_member(organisation_id));
create policy "staff read lead status history" on public.lead_status_history for select to authenticated using (exists(select 1 from public.leads l where l.id=lead_id and private.is_org_member(l.organisation_id)));
