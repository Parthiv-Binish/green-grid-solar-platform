# System Architecture and Technology Decisions

## Decision
Use a modular monolith on a VPS. Keep domain boundaries explicit so modules can be separated later only if scale/team ownership justifies it.

## Stack
- Internal web: React + TypeScript + Vite.
- Mobile: React Native with Expo; customer and technician experiences share code with distinct navigation.
- Backend: FastAPI.
- Database: PostgreSQL.
- Time-series: TimescaleDB only when supported and justified.
- Cache/queue: Redis.
- Background jobs: ARQ initially.
- Real-time: FastAPI WebSockets; Redis Pub/Sub for transient updates and Redis Streams or transactional outbox for durable events.
- Files: S3-compatible object storage.
- Proxy/TLS: Nginx and managed certificates.
- CI/CD: GitHub Actions.

## Modules
Identity/access; CRM; customers/sites; surveys/design; quotations/contracts; projects; utility tracking; procurement/inventory; installation; plants/devices; telemetry/alerts; cases/work orders; warranty/AMC; finance; documents; notifications; reporting.

Each module owns schemas, services, repositories, routes and tests. Avoid circular dependencies. Use explicit interfaces and domain events.

## Deployment
Nginx serves web assets and proxies API. FastAPI connects privately to PostgreSQL and Redis. Separate workers consume jobs. Object storage and backups must be independent of the VPS. PostgreSQL and Redis are never public.

## Data flow
Clients call versioned REST APIs. Backend authenticates, authorises, validates and commits. Events use an outbox or durable queue. Workers send notifications, poll approved manufacturer APIs and evaluate schedules. WebSockets publish authorised updates.

## Worker choice
ARQ is lightweight and async-friendly for FastAPI/Redis. Celery is more mature but operationally heavier. RQ is simple but less aligned with async workloads. Reassess if complex orchestration or throughput emerges.

## Initial sizing
Planning starting point: 4 vCPU / 8 GB RAM for a modest pilot, subject to load tests. Use separate object storage and offsite backups. Monitor CPU, memory, disk I/O, DB connections, queue depth and telemetry ingestion.

## Recovery
Set RPO/RTO with GreenGrid. Proposed initial targets: up to 15-minute RPO where WAL archiving is configured; 4–8-hour RTO for a single-VPS pilot. These are targets until restore tests prove them.

## Decisions
Modular monolith before microservices; PostgreSQL as system of record; React Native for shared TypeScript; groups + ABAC scopes + explicit deny; official messaging providers first; read-only monitoring initially.
