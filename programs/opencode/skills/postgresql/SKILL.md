---
name: postgresql
description: >
  Query and inspect PostgreSQL schemas, tables, types, and data in the local
  development database. Use this skill whenever the user asks about the database
  schema, wants to inspect a table or type, needs to run a query, or asks
  anything involving PostgreSQL, psql, or the dev database. Trigger on phrases
  like "what columns does X have", "check the schema", "look at the type",
  "query the db", "what does the X table look like", or any time understanding
  the data model would help answer the question.
---

# PostgreSQL Skill

## Connecting to the dev database

Always use this pattern — it avoids the interactive pager and is safe for
scripted use:

```bash
psql -U <dev-db-user> <dev-db> -P pager=off -c '<command>'
```

Replace `<dev-db-user>` and `<dev-db>` with the project's actual values. If
you don't know them yet, check:
- `.env` / `.env.local` / `config/` for `DATABASE_URL` or similar
- `docker-compose.yml` for service credentials
- Ask the user if still unclear

## Common inspection commands

### Describe a table (columns, types, constraints, indexes)
```bash
psql -U <user> <db> -P pager=off -c '\d <table_name>'
# For verbose output including storage, statistics, descriptions:
psql -U <user> <db> -P pager=off -c '\d+ <table_name>'
```

### Describe a composite type or domain
```bash
psql -U <user> <db> -P pager=off -c '\dTS+ <type_name>'
# \dT  — list/describe types
# \dTS — include system types
# \dTS+ — verbose (includes descriptions, storage)
```

### List all tables in a schema
```bash
psql -U <user> <db> -P pager=off -c '\dt <schema_name>.*'
# Default schema:
psql -U <user> <db> -P pager=off -c '\dt'
```

### List all schemas
```bash
psql -U <user> <db> -P pager=off -c '\dn'
```

### List enums
```bash
psql -U <user> <db> -P pager=off -c '\dT+'
```

### List functions / stored procedures
```bash
psql -U <user> <db> -P pager=off -c '\df <optional_pattern>'
```

### List views
```bash
psql -U <user> <db> -P pager=off -c '\dv'
```

### List indexes on a table
```bash
psql -U <user> <db> -P pager=off -c '\di <table_name>*'
```

### List foreign key constraints
```bash
psql -U <user> <db> -P pager=off -c "
  SELECT conname, conrelid::regclass AS table, confrelid::regclass AS references
  FROM pg_constraint
  WHERE contype = 'f'
  ORDER BY table;
"
```

## Running ad-hoc queries

Wrap multi-line SQL in `$'...'` to preserve newlines safely in bash:

```bash
psql -U <user> <db> -P pager=off -c "SELECT * FROM <table> LIMIT 10;"
```

For longer queries, use `-f` with a temp file:
```bash
cat > /tmp/query.sql <<'EOF'
SELECT ...
FROM ...
WHERE ...
EOF
psql -U <user> <db> -P pager=off -f /tmp/query.sql
```

## Querying the information schema

Useful when you need machine-readable schema data:

```bash
# All columns for a table
psql -U <user> <db> -P pager=off -c "
  SELECT column_name, data_type, is_nullable, column_default
  FROM information_schema.columns
  WHERE table_name = '<table_name>'
  ORDER BY ordinal_position;
"

# All tables and row counts (approximate)
psql -U <user> <db> -P pager=off -c "
  SELECT schemaname, relname, n_live_tup
  FROM pg_stat_user_tables
  ORDER BY n_live_tup DESC;
"
```

## ltree / hierarchical columns

If the project uses `ltree` for account hierarchies or similar:

```bash
# Check ltree extension is installed
psql -U <user> <db> -P pager=off -c '\dx ltree'

# Query subtree
psql -U <user> <db> -P pager=off -c "
  SELECT * FROM <table> WHERE path <@ '<parent.path>';
"
```

## Performance tuning with EXPLAIN ANALYZE

### Basic usage

```bash
psql -U <user> <db> -P pager=off -c "EXPLAIN ANALYZE <your query here>;"
```

`EXPLAIN` shows the query plan without executing. `EXPLAIN ANALYZE` actually
runs the query and shows real timing — use it when you need accurate row count
and cost estimates.

### Recommended options

```bash
psql -U <user> <db> -P pager=off -c "
  EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
  SELECT ...;
"
```

- `ANALYZE` — execute the query and show actual vs estimated rows/time
- `BUFFERS` — show buffer hits/misses (cache effectiveness)
- `FORMAT TEXT` — human-readable (default); use `FORMAT JSON` for tooling

### Reading the output

Key things to look for:

- **Seq Scan vs Index Scan** — a sequential scan on a large table is usually
  the culprit; check if an index is missing or not being used
- **Rows** — compare `rows=<estimated>` vs `actual rows=<actual>`; a large
  discrepancy means stale statistics (run `ANALYZE <table>`)
- **cost=N..M** — startup cost .. total cost in arbitrary planner units
- **actual time=N..M ms** — wall time for that node; the outermost node shows
  total query time
- **loops=N** — node was executed N times (common in nested loops); costs
  shown are per-loop, so multiply by loops for total

### Finding slow nodes

The most expensive node is usually the one with the highest `actual time` on
the outermost loop. Look for:

```
->  Seq Scan on large_table  (cost=... rows=50000 ...) (actual time=120..980 ms ...)
```

### Forcing index use (for testing)

```bash
psql -U <user> <db> -P pager=off -c "
  SET enable_seqscan = off;
  EXPLAIN ANALYZE SELECT ...;
  RESET enable_seqscan;
"
```

This forces the planner to prefer indexes — useful for checking whether an
index *would* help, without committing to it permanently.

### Check missing indexes

```bash
psql -U <user> <db> -P pager=off -c "
  SELECT schemaname, relname, seq_scan, idx_scan,
         seq_scan - idx_scan AS seq_minus_idx
  FROM pg_stat_user_tables
  WHERE seq_scan > idx_scan
  ORDER BY seq_minus_idx DESC;
"
```

High `seq_scan` count relative to `idx_scan` suggests a missing index.

### Check index usage

```bash
psql -U <user> <db> -P pager=off -c "
  SELECT indexrelname, idx_scan, idx_tup_read, idx_tup_fetch
  FROM pg_stat_user_indexes
  ORDER BY idx_scan DESC;
"
```

Indexes with `idx_scan = 0` are unused and may be candidates for removal.

## Tips

- `-P pager=off` is essential — without it, psql may hang waiting for input
  in non-interactive contexts.
- Use `\x` (expanded output) for wide rows:
  ```bash
  psql -U <user> <db> -P pager=off -c '\x on' -c 'SELECT * FROM <table> LIMIT 1;'
  ```
- For boolean flags in psql meta-commands, the `+` suffix means verbose.
- Schema-qualify table names (`schema.table`) when working with non-public schemas.
