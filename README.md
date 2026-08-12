# cine-review

A relational database schema for a movie review platform, think Letterboxd or Rotten Tomatoes. Built in MySQL as a self-directed backend/SQL project, covering schema design, stored procedures, views, and normalization from scratch.

## What it models

Movies, their cast and crew (actors and directors, each with their own acting method or directing style), user reviews and ratings, watchlists, streaming platform availability, and award nominations, both for movies and for individual people. Two separate identity domains sit side by side: **person** (industry professionals, directors, actors) and **app_user** (the people who log in and review). See [Design decisions](#design-decisions) for why.

## Schema at a glance

- **28 tables** — lookup/catalog tables, a table-per-type `person`/`director`/`actor` hierarchy, core entities, and many-to-many junctions
- **8 stored procedures** — inserts with validation, authorization-checked updates/deletes, two read helpers
- **7 views** — rankings and activity reports over the transactional schema
- **26 sample queries** — a technique showcase across relational operators, aggregation, dates, and joins

Full ER diagram: [`er_diagram.md`](./er_diagram.md) (renders inline on GitHub and in VS Code) or [`er_diagram.mwb`](./er_diagram.mwb) (MySQL Workbench, for editing).

## Tech stack

MySQL 8+. Surrogate `CHAR(36)` UUID primary keys throughout, `DELIMITER`-based stored procedures, `CHECK` constraints, differentiated `ON DELETE` behavior per relationship, and `GROUP_CONCAT`/window-adjacent aggregation in the reporting views.

## Repository structure

```
cine-review/
├── ddl/
│   ├── 001_tables.sql              # schema: all 28 tables
│   ├── 002_stored_procedures.sql   # 8 procedures
│   └── 003_views.sql               # 7 reporting views
├── dml/
│   ├── 001_seed_data.sql           # baseline seed data (29 tables' worth of rows)
│   ├── 002_query_showcase.sql      # 26 example queries, technique reference
│   ├── 003_procedures_driven_data.sql  # additional data inserted via CALL
│   └── 004_view_samples.sql        # sample SELECT * FROM each view
├── er_diagram.mwb                  # ER diagram (MySQL Workbench source)
├── .gitattributes
└── .gitignore
```

Every file carries its own header and inline comments explaining what it contains and, where relevant, why it's built the way it is, the `ddl/` files in particular document the reasoning behind constraints, data types, and key design choices table by table.

## Getting started

Run in order, in the same MySQL session:

```
ddl/001_tables.sql
ddl/002_stored_procedures.sql
ddl/003_views.sql
dml/001_seed_data.sql
dml/003_procedures_driven_data.sql
```

`dml/002_query_showcase.sql` and `dml/004_view_samples.sql` are optional — example queries against the schema, not required to build it.

## Design decisions

A few choices worth calling out, expanded further in the code comments where they're implemented:

- **`person` vs. `app_user` as independent identities.** `person` is catalog identity, industry professionals the system catalogs, populated by an admin. `app_user` is operational identity, who logs in and acts, self-registered, needs `password_hash`/`role_id`. No overlap in this domain: a director doesn't need an account to review movies as themselves.
- **Table-per-type for `person` -> `director`/`actor`.** Avoids nullable columns for role-specific attributes sitting unused on most rows, and avoids a `type` discriminator pushing conditional logic into every query that needs the role-specific data.
- **Surrogate UUID keys everywhere even where a natural key exists.** `movie.tmdb_id` is a real, unique external ID, but it's kept as a `UNIQUE` attribute, not the primary key, so the schema's internal identity doesn't depend on an external system it doesn't control (and isn't always populated: smaller regional releases aren't always catalogued in TMDB).
- **`ON DELETE` set deliberately per relationship, not by default.** `CASCADE` where the child row has no meaning without that specific parent (a review without its user or movie). `RESTRICT` where the parent is a catalog value shared by many unrelated rows (role, category, status), cascading there would silently destroy unrelated data. `SET NULL` where the reference is optional/descriptive on an otherwise still-valid row (country, classification).
- **`movie_award`/`person_award` use a surrogate PK instead of a composite one.** The same movie can be nominated for the same award multiple times across different categories or years, *Parasite* has 4 rows for 2 awards and 3 different Oscar categories alone. A composite `(movie_id, award_id)` PK would reject all but the first of those rows; real uniqueness is enforced instead by `UNIQUE(movie_id, award_id, year, category_id)`.

## Known limitations

- **Age-rating validation isn't enforced at the database level.** `classification.min_age` exists, but "a user can't review a movie below their classification's minimum age" would require comparing it against `app_user.birth_date`, two different tables, which a `CHECK` constraint can't express. It would need a `TRIGGER` or application-layer validation; identified, not implemented.
- **`sp_insert_movie` and `sp_insert_person` aren't wrapped in explicit transactions.** A failure partway through either procedure (e.g. an invalid genre) leaves the earlier inserts in that call committed rather than rolled back.
- Procedures signal failure with `SELECT 'ERROR: ...' AS message` rather than `SIGNAL SQLSTATE`, `CALL` can complete with no thrown exception while still failing its business rule, so the message output needs checking rather than assuming success.

## Author

Samuel Mancera - [LinkedIn](www.linkedin.com/in/samuel-mancera-481494429) - [GitHub](https://github.com/smancera-io)