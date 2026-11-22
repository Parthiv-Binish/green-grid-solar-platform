# Device Monitoring and IoT Integration

## Objective
Read-only monitoring for supported inverters, dataloggers, meters and batteries. Show value, source, quality and last-updated timestamp. Remote control is excluded initially.

## Strategy
Use a connector per manufacturer/model family. Start with manufacturer cloud APIs for existing installations. Add local Modbus TCP/RTU or secure gateway ingestion where supported. Prefer SunSpec models when device support is confirmed. Never expose Modbus directly to the public internet.

## Manufacturer discovery
Potential brands in the supplied brief include Solis, Sungrow, Huawei, Growatt, Luminous, Waaree, Havells and Delta. This is not confirmation GreenGrid installs them. Obtain exact make/model, datalogger, firmware, account ownership, API terms, rate limits, polling, granularity and commercial access before committing to each connector.

## Connector contract
Authentication; plant/device discovery; telemetry fetch or webhook; rate limiting; retry/backoff; provider error mapping; normalisation; health status; credential rotation. Encrypt credentials and never log secrets.

## Canonical telemetry
Metric code, value, unit, device/plant ID, measured_at, received_at, source, quality, provider event ID and raw-payload reference. Metrics may include AC power kW, PV DC power kW, daily/lifetime energy kWh, voltage V, frequency Hz, battery SOC %, charge/discharge kW, grid import/export kWh, temperature °C and fault code.

## Ingestion and storage
Cloud polling/webhooks and gateway MQTT-over-TLS/HTTPS feed validation/normalisation. Validate identity, timestamps, units, bounds and duplicates. PostgreSQL is system of record. Use native partitioning initially or TimescaleDB where supported. ClickHouse is not justified initially. Proposed retention: raw 1–5-minute points 90 days; 15-minute aggregates 12 months; daily aggregates 5 years. Confirm business/legal/storage requirements.

## Alerts
Offline; underperformance; grid fault; battery fault; abnormal temperature; datalogger disconnected; meter mismatch. Rules must be model-aware. Underperformance needs capacity, location, season, weather/irradiance if available, orientation/shading and operating state.

## Alert quality
Debounce consecutive readings; deduplicate by device/event; apply hysteresis; suppress maintenance windows; track first/last seen and resolved time. Alert is not automatically a case—policy determines action.

## Real-time
Use WebSockets for authorised updates. Redis Pub/Sub is transient; use Redis Streams or transactional outbox for durable processing. On reconnect clients refresh from database.

## Acceptance
Stale telemetry is visibly stale; duplicate webhook does not duplicate points/cases; provider outage does not block CRM; alert can be acknowledged/resolved; users only see authorised plants/devices.
