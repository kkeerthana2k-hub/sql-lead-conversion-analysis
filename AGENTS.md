# Crew Database — Base44 Setup

## Project Overview
An Oracle SQL database modeling a fitness/wellness business lead-to-membership lifecycle across 6 normalized tables (campaigns, sales reps, leads, trial appointments, clients, memberships) with 7 analytical queries using joins, set operators, subqueries, and aggregation.

## Architecture
- **PostgreSQL 16** (Alpine) — database service running the converted SQL schema + seed data
- **Node.js 22** (Express + pg) — web viewer on port 3000 that browses tables and runs analytical queries
- No external credentials needed — all infra runs locally in compose

## Setup
```
docker compose -f docker-compose.base44.yml up -d --build
```
- PostgreSQL auto-loads `db/init.sql` on first boot (converted from Oracle `crew_database.sql`)
- Node app installs deps on startup (`npm install --omit=dev`) then runs `node server.js`
- Web UI at `http://localhost:3000`

## Oracle → PostgreSQL Conversion
The original `crew_database.sql` uses Oracle-specific syntax. `db/init.sql` is the PostgreSQL-compatible version:
- `VARCHAR2(n)` → `VARCHAR(n)`
- `NUMBER(5)` → `INTEGER`
- `TO_DATE('1-Jan-25','DD-Mon-YYYY')` → `'2025-01-01'::DATE` (2-digit years assumed 2000s)
- `DROP TABLE x CASCADE constraints` → `DROP TABLE IF EXISTS x CASCADE`
- `Purge RecycleBin` → removed
- `MINUS` → `EXCEPT` (in analytical queries, served by the web app)

## Verification
- `curl http://localhost:3000/api/health` → `{"status":"ok"}`
- `curl http://localhost:3000/api/table/campaign` → campaign rows
- `curl http://localhost:3000/api/query/q1` → query result
