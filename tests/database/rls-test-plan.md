
## Migration-specific notes
- Migration 004 intentionally provides public read access to active categories, verified brands, active products and their specifications only.
- Global category / brand writes are not granted to authenticated clients; manage these through trusted administrative operations.
- Organisation, role, membership and permission management remains server-side. Do not add broad authenticated write grants.
