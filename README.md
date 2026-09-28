[![SQL](https://img.shields.io/badge/SQL-PostgreSQL%20%2F%20SQLite-4169E1?logo=postgresql&logoColor=white)]()

# SQL Database Design

Two SQL assignments from a database systems course: relational schema design, relational algebra, and analytical queries (joins, window functions, views) over both toy and real-world datasets.

| Project | What it covers |
|---|---|
| [`assignment-2-relational-algebra/`](assignment-2-relational-algebra/) | `pizza.sql` — a small relational schema (people/pizzerias/pizzas) with 7 queries + matching relational algebra. `soccer.sql` — 11 analytical queries (views, `UNION`, self-joins) over 100+ years of English/French/German/Italian league results. |
| [`assignment-3-ships-sp500/`](assignment-3-ships-sp500/) | `ships_post.sql` — the classic WWII "capital ships" relational exercise: schema design, queries, updates/deletes, and integrity constraints enforced via `WITH CHECK OPTION` views. `sp500_post.sql` — window-function analysis (`LAG`, `ROW_NUMBER`, `RANK`, `DENSE_RANK`) over S&P 500 daily price history. |

## Running

Each `.sql` file is standalone and annotated with the question it answers. Load a file into `psql` (or SQLite for the ships/pizza toy schemas) and run it directly; the soccer/sp500 files expect their CSVs (in each project's `data/` folder) imported as tables first — see the comment block at the top of each file for the exact table names expected.

## Attribution

`assignment-2-relational-algebra/pizza.sql` and `soccer.sql` were completed jointly with a partner, **Rishon Rajesh**, as a paired assignment. `assignment-3-ships-sp500/` is solely my own work.

## 🎓 Project Context

Built as part of **CSC 370: Database Systems** at the University of Victoria.

## ⚠️ Academic Integrity Notice

This repository is maintained for portfolio and educational purposes only. If you are
currently enrolled in CSC 370 at the University of Victoria or a similar database
systems course, please note that using this code in your own assignments may
constitute a violation of Academic Integrity policies.
