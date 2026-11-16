# Supabase migrations

These SQL migrations are prepared for Green Grid Solar Solutions and have **not** been applied to a hosted database.

## Order
1. `20261116000100_foundation_identity_crm.sql`
2. `20261116000200_booking_survey_design.sql`
3. `20261116000300_sales_projects_finance_support.sql`
4. `20261116000400_catalogue_inventory.sql`

Apply to a dedicated Green Grid development project first, after reviewing the target project, backup, migration history and SQL. Do not apply to another application’s Supabase project.

## Important security notes
- RLS is enabled on created public tables.
- Staff baseline policies currently scope many operations to active organisation membership; before production, refine these to the permission matrix and least-privilege roles.
- Public product reads are intentionally limited to active products and their specifications.
- Public enquiry / booking / payment-report writes should be exposed through validated server-side endpoints or narrowly scoped RPCs, not broad anonymous table inserts.
- Current Supabase projects may not expose new public-schema tables through the Data API automatically. Grant API roles only after reviewing the required access and RLS policies.
- Storage buckets and policies are not created by these migrations.
- This is an initial schema foundation, not a complete accounting, compliance or engineering sign-off.

See `tests/database/rls-test-plan.md` for preflight and acceptance tests.
