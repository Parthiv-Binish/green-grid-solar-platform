-- RLS hardening for global reference tables and organisation directory.
alter table public.organisations enable row level security;
create policy "members read own organisation" on public.organisations
for select to authenticated using(private.is_org_member(id));

drop policy if exists "staff manage categories" on public.product_categories;
drop policy if exists "staff manage brands" on public.brands;
create policy "public reads active categories" on public.product_categories
for select to anon,authenticated using(is_active=true);
create policy "public reads verified brands" on public.brands
for select to anon,authenticated using(verification_status='verified');

-- Reference and permission tables intentionally have no direct client write policies.
-- Manage roles, permissions, memberships and reference data through trusted admin operations.
