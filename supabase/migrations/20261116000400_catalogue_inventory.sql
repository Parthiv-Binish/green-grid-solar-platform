-- Catalogue, supplier and inventory module. Kept separate for independent rollout.
create table public.product_categories (
 id uuid primary key default gen_random_uuid(),
 parent_id uuid references public.product_categories(id),
 category_key text not null unique,
 name text not null,
 sort_order integer not null default 0,
 is_active boolean not null default true
);
create table public.brands (
 id uuid primary key default gen_random_uuid(),
 name text not null unique,
 website_url text,
 logo_path text,
 verification_status text not null default 'unverified' check(verification_status in ('unverified','verified','inactive'))
);
create table public.products (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 brand_id uuid references public.brands(id),
 category_id uuid references public.product_categories(id),
 sku text,
 model_number text,
 name text not null,
 description text,
 product_type text not null,
 status text not null default 'draft' check(status in ('draft','active','inactive','discontinued')),
 published_at timestamptz,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now(),
 unique(organisation_id,sku)
);
create index on public.products(organisation_id,status,category_id);
create table public.product_specifications (
 id uuid primary key default gen_random_uuid(),
 product_id uuid not null references public.products(id) on delete cascade,
 spec_key text not null,
 value_numeric numeric,
 value_text text,
 unit text,
 source_document_path text,
 verified_at timestamptz,
 unique(product_id,spec_key),
 check(value_numeric is not null or value_text is not null)
);
create table public.product_documents (
 id uuid primary key default gen_random_uuid(),
 product_id uuid not null references public.products(id) on delete cascade,
 document_type text not null,
 storage_path text not null,
 revision text,
 issued_at date,
 verified_at timestamptz
);
create table public.product_prices (
 id uuid primary key default gen_random_uuid(),
 product_id uuid not null references public.products(id),
 currency_code char(3) not null default 'INR',
 price_paise bigint not null check(price_paise>=0),
 price_type text not null default 'retail',
 valid_from timestamptz not null default now(),
 valid_to timestamptz,
 approved_by uuid references auth.users(id),
 check(valid_to is null or valid_to>valid_from)
);
create index on public.product_prices(product_id,valid_from desc);
create table public.suppliers (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 supplier_code text not null,
 name text not null,
 contact_data jsonb not null default '{}'::jsonb,
 status text not null default 'active' check(status in ('active','inactive','blocked')),
 unique(organisation_id,supplier_code)
);
create table public.supplier_products (
 id uuid primary key default gen_random_uuid(),
 supplier_id uuid not null references public.suppliers(id),
 product_id uuid not null references public.products(id),
 supplier_sku text,
 lead_time_days integer check(lead_time_days is null or lead_time_days>=0),
 last_verified_at timestamptz,
 unique(supplier_id,product_id)
);
create table public.product_compatibility (
 id uuid primary key default gen_random_uuid(),
 product_id uuid not null references public.products(id),
 compatible_product_id uuid not null references public.products(id),
 compatibility_type text not null,
 evidence_document_path text,
 verified_by uuid references auth.users(id),
 check(product_id<>compatible_product_id),
 unique(product_id,compatible_product_id,compatibility_type)
);
-- Add the product reference omitted from the earlier design/BOM migration until catalogue exists.
alter table public.solar_design_components
 add constraint solar_design_components_product_fk foreign key(product_id) references public.products(id);

create table public.inventory_locations (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 location_code text not null,
 name text not null,
 location_type text not null default 'warehouse' check(location_type in ('warehouse','vehicle','project_site','other')),
 is_active boolean not null default true,
 unique(organisation_id,location_code)
);
create table public.inventory_items (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 product_id uuid not null references public.products(id),
 item_code text not null,
 tracking_type text not null default 'quantity' check(tracking_type in ('quantity','serial')),
 reorder_level numeric(14,3) not null default 0 check(reorder_level>=0),
 unique(organisation_id,item_code),
 unique(organisation_id,product_id)
);
create table public.inventory_movements (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 inventory_item_id uuid not null references public.inventory_items(id),
 from_location_id uuid references public.inventory_locations(id),
 to_location_id uuid references public.inventory_locations(id),
 quantity numeric(14,3) not null check(quantity>0),
 movement_type text not null check(movement_type in ('opening','receipt','transfer','issue','return','adjustment','write_off')),
 reference_type text,
 reference_id uuid,
 actor_id uuid references auth.users(id),
 occurred_at timestamptz not null default now(),
 check(from_location_id is not null or to_location_id is not null)
);
create index on public.inventory_movements(inventory_item_id,occurred_at desc);
create table public.inventory_balances (
 id uuid primary key default gen_random_uuid(),
 inventory_item_id uuid not null references public.inventory_items(id),
 location_id uuid not null references public.inventory_locations(id),
 quantity_on_hand numeric(14,3) not null default 0 check(quantity_on_hand>=0),
 quantity_reserved numeric(14,3) not null default 0 check(quantity_reserved>=0),
 updated_at timestamptz not null default now(),
 unique(inventory_item_id,location_id),
 check(quantity_reserved<=quantity_on_hand)
);
create table public.product_serials (
 id uuid primary key default gen_random_uuid(),
 product_id uuid not null references public.products(id),
 serial_number text not null unique,
 current_location_id uuid references public.inventory_locations(id),
 status text not null default 'available' check(status in ('available','reserved','installed','returned','damaged','retired')),
 project_id uuid references public.projects(id),
 created_at timestamptz not null default now()
);
create table public.purchase_orders (
 id uuid primary key default gen_random_uuid(),
 organisation_id uuid not null references public.organisations(id),
 po_number text not null,
 supplier_id uuid not null references public.suppliers(id),
 status text not null default 'draft' check(status in ('draft','pending_approval','approved','sent','partially_received','received','cancelled')),
 currency_code char(3) not null default 'INR',
 total_paise bigint not null default 0 check(total_paise>=0),
 ordered_at timestamptz,
 expected_at timestamptz,
 created_at timestamptz not null default now(),
 unique(organisation_id,po_number)
);
create table public.purchase_order_items (
 id uuid primary key default gen_random_uuid(),
 purchase_order_id uuid not null references public.purchase_orders(id) on delete cascade,
 product_id uuid not null references public.products(id),
 description_snapshot text not null,
 quantity numeric(14,3) not null check(quantity>0),
 unit_price_paise bigint not null check(unit_price_paise>=0),
 received_quantity numeric(14,3) not null default 0 check(received_quantity>=0 and received_quantity<=quantity)
);
create table public.goods_receipts (
 id uuid primary key default gen_random_uuid(),
 purchase_order_id uuid not null references public.purchase_orders(id),
 receipt_number text not null unique,
 received_by uuid references auth.users(id),
 received_at timestamptz not null default now(),
 status text not null default 'inspection_pending' check(status in ('inspection_pending','accepted','discrepancy','rejected'))
);
create table public.goods_receipt_items (
 id uuid primary key default gen_random_uuid(),
 goods_receipt_id uuid not null references public.goods_receipts(id) on delete cascade,
 purchase_order_item_id uuid not null references public.purchase_order_items(id),
 quantity_received numeric(14,3) not null check(quantity_received>0),
 quantity_accepted numeric(14,3) not null default 0 check(quantity_accepted>=0 and quantity_accepted<=quantity_received),
 discrepancy_notes text
);
create table public.project_material_allocations (
 id uuid primary key default gen_random_uuid(),
 project_id uuid not null references public.projects(id),
 inventory_item_id uuid not null references public.inventory_items(id),
 location_id uuid not null references public.inventory_locations(id),
 quantity_allocated numeric(14,3) not null check(quantity_allocated>0),
 quantity_issued numeric(14,3) not null default 0 check(quantity_issued>=0 and quantity_issued<=quantity_allocated),
 status text not null default 'reserved' check(status in ('reserved','partially_issued','issued','released')),
 created_at timestamptz not null default now()
);

do $$
declare t text;
begin
 foreach t in array array['product_categories','brands','products','product_specifications','product_documents','product_prices','suppliers','supplier_products','product_compatibility','inventory_locations','inventory_items','inventory_movements','inventory_balances','product_serials','purchase_orders','purchase_order_items','goods_receipts','goods_receipt_items','project_material_allocations'] loop
  execute format('alter table public.%I enable row level security',t);
 end loop;
end $$;
create policy "staff manage categories" on public.product_categories for all to authenticated using(true) with check(true);
create policy "staff manage brands" on public.brands for all to authenticated using(true) with check(true);
create policy "staff manage products" on public.products for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "public reads active products" on public.products for select to anon,authenticated using(status='active');
create policy "staff manage product specs" on public.product_specifications for all to authenticated using(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id)));
create policy "public reads product specs" on public.product_specifications for select to anon,authenticated using(exists(select 1 from public.products p where p.id=product_id and p.status='active'));
create policy "staff manage product docs" on public.product_documents for all to authenticated using(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id)));
create policy "staff manage prices" on public.product_prices for all to authenticated using(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id)));
create policy "staff manage suppliers" on public.suppliers for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage supplier products" on public.supplier_products for all to authenticated using(exists(select 1 from public.suppliers s where s.id=supplier_id and private.is_org_member(s.organisation_id))) with check(exists(select 1 from public.suppliers s where s.id=supplier_id and private.is_org_member(s.organisation_id)));
create policy "staff manage compatibility" on public.product_compatibility for all to authenticated using(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id)));
create policy "staff manage inventory locations" on public.inventory_locations for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage inventory items" on public.inventory_items for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage inventory movements" on public.inventory_movements for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage inventory balances" on public.inventory_balances for all to authenticated using(exists(select 1 from public.inventory_items i where i.id=inventory_item_id and private.is_org_member(i.organisation_id))) with check(exists(select 1 from public.inventory_items i where i.id=inventory_item_id and private.is_org_member(i.organisation_id)));
create policy "staff manage serials" on public.product_serials for all to authenticated using(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.products p where p.id=product_id and private.is_org_member(p.organisation_id)));
create policy "staff manage purchase orders" on public.purchase_orders for all to authenticated using(private.is_org_member(organisation_id)) with check(private.is_org_member(organisation_id));
create policy "staff manage purchase order items" on public.purchase_order_items for all to authenticated using(exists(select 1 from public.purchase_orders po where po.id=purchase_order_id and private.is_org_member(po.organisation_id))) with check(exists(select 1 from public.purchase_orders po where po.id=purchase_order_id and private.is_org_member(po.organisation_id)));
create policy "staff manage goods receipts" on public.goods_receipts for all to authenticated using(exists(select 1 from public.purchase_orders po where po.id=purchase_order_id and private.is_org_member(po.organisation_id))) with check(exists(select 1 from public.purchase_orders po where po.id=purchase_order_id and private.is_org_member(po.organisation_id)));
create policy "staff manage goods receipt items" on public.goods_receipt_items for all to authenticated using(exists(select 1 from public.goods_receipts gr join public.purchase_orders po on po.id=gr.purchase_order_id where gr.id=goods_receipt_id and private.is_org_member(po.organisation_id))) with check(exists(select 1 from public.goods_receipts gr join public.purchase_orders po on po.id=gr.purchase_order_id where gr.id=goods_receipt_id and private.is_org_member(po.organisation_id)));
create policy "staff manage project allocations" on public.project_material_allocations for all to authenticated using(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id))) with check(exists(select 1 from public.projects p where p.id=project_id and private.is_org_member(p.organisation_id)));
