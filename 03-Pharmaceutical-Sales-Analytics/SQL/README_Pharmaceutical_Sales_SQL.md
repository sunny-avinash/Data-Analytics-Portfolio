# Pharmaceutical Sales Analytics — SQL Analysis

## Project Overview

This project uses MySQL to analyze hourly pharmaceutical sales data and convert the source CSV data into a clean analytical Star Schema.

The SQL phase covers:

- Data loading and validation
- Staging-table creation
- Wide-to-long transformation
- Dimensional modeling
- Sales KPIs
- Product performance
- Time-based analysis
- Year-over-year growth
- Ranking and cumulative analysis
- Drug × weekday analysis
- Final data-integrity validation

This is the SQL stage of the Pharmaceutical Sales Analytics portfolio project. Python EDA was completed before this phase, and Tableau will be used for the final interactive dashboard.

## Source Dataset

The project contains four CSV files:

| File | Rows | Grain |
|---|---:|---|
| `saleshourly.csv` | 50,532 | Hourly |
| `salesdaily.csv` | 2,106 | Daily |
| `salesweekly.csv` | 302 | Weekly |
| `salesmonthly.csv` | 70 | Monthly |

The hourly file is the primary detailed source for the analytical fact table. The other files represent aggregated time grains and are retained as source/staging data.

## Tools & Concepts

- MySQL
- MySQL Workbench
- SQL
- CTEs
- Aggregate functions
- Joins
- Date functions
- Window functions
- `LAG()`
- `RANK()`
- Running totals
- Star Schema modeling

## Database

```sql
CREATE DATABASE pharma_sales_analytics;
USE pharma_sales_analytics;
```

## Database Design

### Staging Tables

```text
stg_sales_hourly
stg_sales_daily
stg_sales_weekly
stg_sales_monthly
```

### Analytical Tables

```text
dim_date
dim_drug
fact_sales
```

### Star Schema

```text
             dim_date
                 |
                 v
             fact_sales
                 ^
                 |
              dim_drug
```

## Data Import & Validation

`saleshourly.csv` was imported into `stg_sales_hourly` using MySQL Workbench's Table Data Import Wizard after `LOAD DATA LOCAL INFILE` was restricted by the MySQL configuration.

Validated results:

- Row count: **50,532**
- Missing `datum`: **0**
- Actual date range: **2014-01-02 08:00:00 → 2019-10-08 19:00:00**

The date range was validated with:

```sql
SELECT
    MIN(STR_TO_DATE(datum, '%m/%d/%Y %H:%i')) AS min_date,
    MAX(STR_TO_DATE(datum, '%m/%d/%Y %H:%i')) AS max_date
FROM stg_sales_hourly;
```

## Analytical Model

### `dim_drug`

Contains the 8 drug codes:

```text
M01AB
M01AE
N02BA
N02BE
N05B
N05C
R03
R06
```

### `dim_date`

Contains:

- `date_id`
- `full_date`
- `year`
- `month`
- `month_name`
- `quarter`
- `weekday_name`

The dimension contains **2,106 dates**.

### `fact_sales_hourly`

A cleaned hourly table with a proper `DATETIME` column was created from the staging data.

### `fact_sales`

The final long-format fact table contains:

```text
sales_id
date_id
drug_id
sale_datetime
sales_quantity
hour
```

The eight drug columns from the original wide dataset were unpivoted into rows.

Final row count:

```text
50,532 × 8 = 404,256
```

## SQL Business Analysis

### 1. Total Pharmaceutical Sales

```sql
SELECT
    ROUND(SUM(sales_quantity), 2) AS total_sales
FROM fact_sales;
```

Result:

```text
127,595.67
```

### 2. Sales by Drug

```sql
SELECT
    d.drug_code,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
JOIN dim_drug d
    ON f.drug_id = d.drug_id
GROUP BY d.drug_code
ORDER BY total_sales DESC;
```

Results:

| Rank | Drug | Total Sales |
|---:|---|---:|
| 1 | N02BE | 63,005.42 |
| 2 | N05B | 18,645.76 |
| 3 | R03 | 11,608.82 |
| 4 | M01AB | 10,600.97 |
| 5 | M01AE | 8,204.66 |
| 6 | N02BA | 8,172.23 |
| 7 | R06 | 6,107.85 |
| 8 | N05C | 1,249.96 |

**Insight:** N02BE is the dominant product by total sales.

### 3. Sales by Year

```sql
SELECT
    d.year,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.year
ORDER BY d.year;
```

| Year | Total Sales |
|---:|---:|
| 2014 | 20,238.35 |
| 2015 | 22,752.36 |
| 2016 | 25,234.93 |
| 2017 | 19,399.51 |
| 2018 | 22,884.56 |
| 2019 | 17,085.96 |

**Insight:** 2016 recorded the highest annual sales; 2019 recorded the lowest.

### 4. Sales by Month

```sql
SELECT
    d.month,
    d.month_name,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.month, d.month_name
ORDER BY d.month;
```

**Insight:** January was the highest-sales month and July was the lowest-sales month.

### 5. Sales by Hour

```sql
SELECT
    f.hour,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
GROUP BY f.hour
ORDER BY f.hour;
```

**Insight:** Sales are concentrated during daytime and evening hours, with strong periods around 11:00–12:00 and 19:00–20:00.

### 6. Sales by Weekday

```sql
SELECT
    d.weekday_name,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.weekday_name
ORDER BY FIELD(
    d.weekday_name,
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday'
);
```

**Insight:** Saturday had the highest weekday sales and Thursday had the lowest.

### 7. Sales Contribution by Drug

```sql
SELECT
    d.drug_code,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales,
    ROUND(
        SUM(f.sales_quantity) /
        (SELECT SUM(sales_quantity) FROM fact_sales) * 100,
        2
    ) AS sales_contribution_pct
FROM fact_sales f
JOIN dim_drug d
    ON f.drug_id = d.drug_id
GROUP BY d.drug_code
ORDER BY sales_contribution_pct DESC;
```

| Drug | Contribution |
|---|---:|
| N02BE | 49.38% |
| N05B | 14.61% |
| R03 | 9.10% |
| M01AB | 8.31% |
| M01AE | 6.43% |
| N02BA | 6.40% |
| R06 | 4.79% |
| N05C | 0.98% |

**Insight:** N02BE contributes approximately 49.38% of total sales. The top four products contribute approximately 81.40%.

### 8. Year-over-Year Growth with `LAG()`

```sql
WITH yearly_sales AS (
    SELECT
        d.year,
        ROUND(SUM(f.sales_quantity), 2) AS total_sales
    FROM fact_sales f
    JOIN dim_date d
        ON f.date_id = d.date_id
    GROUP BY d.year
)
SELECT
    year,
    total_sales,
    ROUND(
        (
            total_sales - LAG(total_sales) OVER (ORDER BY year)
        )
        / LAG(total_sales) OVER (ORDER BY year) * 100,
        2
    ) AS yoy_growth_pct
FROM yearly_sales
ORDER BY year;
```

| Year | YoY Growth |
|---:|---:|
| 2014 | — |
| 2015 | +12.42% |
| 2016 | +10.91% |
| 2017 | -23.12% |
| 2018 | +17.96% |
| 2019 | -25.34% |

**Insight:** 2019 had the largest year-over-year decline at -25.34%.

### 9. Drug Ranking with `RANK()`

```sql
SELECT
    d.drug_code,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(f.sales_quantity) DESC
    ) AS sales_rank
FROM fact_sales f
JOIN dim_drug d
    ON f.drug_id = d.drug_id
GROUP BY d.drug_code
ORDER BY sales_rank;
```

Ranking:

1. N02BE
2. N05B
3. R03
4. M01AB
5. M01AE
6. N02BA
7. R06
8. N05C

### 10. Cumulative Sales with a Window Function

```sql
WITH drug_sales AS (
    SELECT
        d.drug_code,
        ROUND(SUM(f.sales_quantity), 2) AS total_sales
    FROM fact_sales f
    JOIN dim_drug d
        ON f.drug_id = d.drug_id
    GROUP BY d.drug_code
)
SELECT
    drug_code,
    total_sales,
    ROUND(
        SUM(total_sales) OVER (
            ORDER BY total_sales DESC
        ),
        2
    ) AS cumulative_sales
FROM drug_sales
ORDER BY total_sales DESC;
```

**Insight:** The first four products accumulate approximately 81.40% of total sales, supporting the Pareto finding.

### 11. Drug × Weekday Analysis

```sql
SELECT
    d.weekday_name,
    dr.drug_code,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
JOIN dim_drug dr
    ON f.drug_id = dr.drug_id
GROUP BY
    d.weekday_name,
    dr.drug_code
ORDER BY
    FIELD(
        d.weekday_name,
        'Monday', 'Tuesday', 'Wednesday', 'Thursday',
        'Friday', 'Saturday', 'Sunday'
    ),
    total_sales DESC;
```

The query returned **56 combinations** (7 weekdays × 8 drugs).

**Insight:** N02BE remains the strongest-selling product across all weekdays.

### 12. Top-Selling Drug by Year

```sql
WITH yearly_drug_sales AS (
    SELECT
        d.year,
        dr.drug_code,
        ROUND(SUM(f.sales_quantity), 2) AS total_sales
    FROM fact_sales f
    JOIN dim_date d
        ON f.date_id = d.date_id
    JOIN dim_drug dr
        ON f.drug_id = dr.drug_id
    GROUP BY d.year, dr.drug_code
),
ranked_drugs AS (
    SELECT
        year,
        drug_code,
        total_sales,
        RANK() OVER (
            PARTITION BY year
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM yearly_drug_sales
)
SELECT
    year,
    drug_code,
    total_sales
FROM ranked_drugs
WHERE sales_rank = 1
ORDER BY year;
```

Result: **N02BE was the top-selling drug in every year from 2014 through 2019.**

## Final Data Integrity Validation

```sql
SELECT
    COUNT(*) AS fact_rows,
    COUNT(DISTINCT date_id) AS unique_dates,
    COUNT(DISTINCT drug_id) AS unique_drugs,
    ROUND(SUM(sales_quantity), 2) AS total_sales
FROM fact_sales;
```

Final result:

| Metric | Result |
|---|---:|
| Fact rows | 404,256 |
| Unique dates | 2,106 |
| Unique drugs | 8 |
| Total sales | 127,595.67 |

All expected values were confirmed.

## Key Business Insights

- N02BE contributes **49.38%** of total sales.
- The top four drugs contribute approximately **81.40%** of total sales.
- N02BE ranked #1 overall and in every year analyzed.
- 2016 was the strongest annual sales year.
- 2019 was the weakest annual sales year.
- January was the strongest month; July was the weakest.
- Saturday had the highest weekday sales; Thursday had the lowest.
- Sales are concentrated during daytime and evening hours.
- 2019 recorded the largest YoY decline at **-25.34%**.

## Project Structure

```text
03-Pharmaceutical-Sales-Analytics/
│
├── Dataset/
│   ├── saleshourly.csv
│   ├── salesdaily.csv
│   ├── salesweekly.csv
│   └── salesmonthly.csv
│
├── Python/
│   └── Pharmaceutical_Sales_Analysis.ipynb
│
├── SQL/
│   ├── pharma_sales_schema.sql
│   ├── pharma_sales_analysis.sql
│   └── README.md
│
├── Tableau/
│   └── README.md
│
└── README.md
```

## Project Roadmap

### Phase 1 — Python EDA ✅

Completed:

- Data inspection and validation
- Drug-level analysis
- Year/month/hour analysis
- Pareto analysis
- Weekday analysis
- Drug × weekday heatmap

### Phase 2 — SQL Analysis ✅

Completed:

- Database setup
- Staging tables
- Data import
- Star Schema
- Fact and dimension tables
- Wide-to-long transformation
- Business KPIs
- Time-based analysis
- Product ranking
- `LAG()`
- `RANK()`
- Cumulative analysis
- Drug × weekday analysis
- Top drug by year
- Final integrity validation

### Phase 3 — Tableau ⏳

Planned:

- Connect Tableau to MySQL
- Build the data model
- Create KPI cards
- Build sales trend dashboards
- Add drug/product analysis
- Add time analysis
- Add interactive filters
- Create the final portfolio dashboard

## SQL Skills Demonstrated

**MySQL | Database Design | Staging Tables | Star Schema | Fact/Dimension Modeling | Joins | GROUP BY | Aggregations | CTEs | Date Functions | Window Functions | LAG() | RANK() | Running Totals | Contribution Analysis | Business Analysis | Data Validation**

## Portfolio Project

**Project:** Pharmaceutical Sales Analytics  
**Database:** `pharma_sales_analytics`  
**Primary Source:** `saleshourly.csv`  
**Final Fact Rows:** 404,256  
**SQL Status:** ✅ Complete  
**Next Stage:** Tableau Dashboard
