# Pharmaceutical Sales Analytics — Tableau

## Overview
This README documents the Tableau visualization layer of the Pharmaceutical Sales Analytics portfolio project.

The Tableau workbook connects to the MySQL database `pharma_sales_analytics` and presents the business analysis completed during the SQL and Python stages.

The dashboards cover overall sales performance, product contribution, time trends, hourly and weekday patterns, YoY growth, drug-level trends, and drug × weekday analysis.

## Tools
- Tableau
- MySQL
- Python / Pandas / Matplotlib
- CSV source data

## Data Model

### Fact table
`fact_sales`

Key fields:
- `sales_id`
- `date_id`
- `drug_id`
- `sale_datetime`
- `sales_quantity`
- `hour`

### Dimension tables
`dim_date`
- `date_id`
- `full_date`
- `year`
- `month`
- `month_name`
- `weekday_name`

`dim_drug`
- `drug_id`
- `drug_code`

Relationships:
```text
fact_sales.date_id = dim_date.date_id
fact_sales.drug_id = dim_drug.drug_id
```

---

# Dashboard 1 — Pharmaceutical Sales Analytics — Executive Overview

## Interactive Filters
- Year: 2014–2019
- Month Name
- Drug Code

## KPI — Total Sales
Rounded Tableau KPI:
**127,596**

Validated SQL/Python total:
**127,595.67**

## KPI — Top Drug
Default result:
- Drug: **N02BE**
- Sales: **63,005** (approximately 63,005.42)

The Top Drug KPI uses dedicated **Top Drug Flag** logic so it can identify the highest-selling drug without being unintentionally restricted by the global Drug Code filter.

## Sales Trend by Year

| Year | Total Sales |
|---|---:|
| 2014 | 20,238.35 |
| 2015 | 22,752.36 |
| 2016 | 25,234.93 |
| 2017 | 19,399.51 |
| 2018 | 22,884.56 |
| 2019 | 17,085.96 |

2016 was the strongest annual sales year.

## Sales by Drug

| Rank | Drug Code | Total Sales |
|---:|---|---:|
| 1 | N02BE | 63,005.42 |
| 2 | N05B | 18,645.76 |
| 3 | R03 | 11,608.82 |
| 4 | M01AB | 10,600.97 |
| 5 | M01AE | 8,204.66 |
| 6 | N02BA | 8,172.23 |
| 7 | R06 | 6,107.85 |
| 8 | N05C | 1,249.96 |

## Sales Trend by Month

| Month | Total Sales |
|---|---:|
| January | 13,970.82 |
| February | 11,604.59 |
| March | 11,363.61 |
| April | 10,248.72 |
| May | 9,925.97 |
| June | 8,992.86 |
| July | 8,758.50 |
| August | 9,037.61 |
| September | 11,000.86 |
| October | 12,051.04 |
| November | 9,534.38 |
| December | 11,106.71 |

January is the highest-sales month; July is the lowest.

## Sales Contribution by Drug

| Drug Code | Contribution |
|---|---:|
| N02BE | 49.38% |
| N05B | 14.61% |
| R03 | 9.10% |
| M01AB | 8.31% |
| M01AE | 6.43% |
| N02BA | 6.40% |
| R06 | 4.79% |
| N05C | 0.98% |

N02BE contributes approximately half of total sales.

---

# Dashboard 2 — Pharmaceutical Sales & Product Insights

## Sales by Hour
Hourly sales are very low overnight and strongest during the daytime/evening period, especially around **11–12** and **18–20**. The highest individual hourly sales level is around **19:00**.

## Sales by Weekday

| Weekday | Total Sales |
|---|---:|
| Monday | 18,242.84 |
| Tuesday | 18,065.27 |
| Wednesday | 17,771.54 |
| Thursday | 17,212.43 |
| Friday | 18,134.51 |
| Saturday | 19,767.62 |
| Sunday | 18,401.46 |

Saturday is the strongest weekday.

## YoY Sales Growth

| Year | YoY Growth |
|---|---:|
| 2014 | NULL |
| 2015 | 12.42% |
| 2016 | 10.91% |
| 2017 | -23.12% |
| 2018 | 17.96% |
| 2019 | -25.34% |

The 2014 NULL is expected because there is no prior year for comparison.

## Drug Sales Trend by Year
A multi-line view compares the yearly sales trends of all eight drug codes. N02BE remains substantially higher than the other drugs throughout the period.

## Drug × Weekday Heatmap
A **7 × 8 = 56-cell** heatmap showing sales by weekday and drug code. Sales quantity controls color intensity and the values are displayed in the cells.

---

# Key Business Findings

1. **N02BE dominates the portfolio**, contributing 49.38% of total sales.
2. **2016** is the strongest annual sales year at approximately 25,234.93.
3. Major YoY declines occurred in **2017 (-23.12%)** and **2019 (-25.34%)**.
4. **January** is the strongest month at approximately 13,970.82.
5. **Saturday** is the strongest weekday at approximately 19,767.62.
6. Sales are concentrated in daytime/evening hours, with strong activity around 11–12 and 18–20.

---

# Tableau Workbook Structure

## Worksheets
```text
KPI - Total Sales
KPI - Top Drug
Sales Trend by Year
Sales Trend by Month
Sales by Drug
Sales by Hour
Sales by Weekday
Sales Contribution by Drug
YoY Sales Growth
Drug Sales Trend by Year
Drug × Weekday Heatmap
```

## Dashboards
```text
Pharmaceutical Sales Analytics — Executive Overview
Pharmaceutical Sales & Product Insights
```

## Dashboard Interactivity
Both dashboards contain:
- Year
- Month Name
- Drug Code

The Top Drug KPI uses dedicated Top Drug Flag logic rather than the global Drug Code filter.

---

# Validation

Key validated dataset figures:

```text
Fact rows:       404,256
Unique dates:      2,106
Unique drugs:          8
Total sales:      127,595.67
Top drug:             N02BE
Top drug sales:   63,005.42
```

The Tableau Total Sales KPI displays the rounded value **127,596**.

---

# Portfolio Skills Demonstrated

- Tableau–MySQL connectivity
- Star-schema data modeling
- KPI development
- Interactive filters
- Time-series analysis
- Product performance analysis
- Percent-of-total analysis
- YoY growth analysis
- Ranking and contribution analysis
- Heatmap visualization
- Dashboard layout and design
- Cross-validation with SQL and Python

---

# Suggested Project Structure

```text
03-Pharmaceutical-Sales-Analytics/
├── Dataset/
├── SQL/
│   ├── database_structure.sql
│   ├── SQL_Business_Analysis.sql
│   └── README.md
├── Python/
│   ├── pharmaceutical_sales_analysis.ipynb
│   └── README.md
├── Tableau/
│   ├── Pharmaceutical_Sales_Analytics_Portfolio.twbx
│   └── README.md
└── README.md
```

---

# End-to-End Workflow

```text
Raw CSV Data
     ↓
Python Analysis
     ↓
MySQL Data Modeling
     ↓
SQL Business Analysis
     ↓
Tableau Dashboards
     ↓
Business Insights
```

## Conclusion
The Tableau layer converts the SQL and Python analysis into an interactive business intelligence solution with an executive overview and a deeper product/operational insights dashboard.
