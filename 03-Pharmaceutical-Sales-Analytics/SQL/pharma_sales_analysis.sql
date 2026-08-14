SELECT 
    ROUND(SUM(sales_quantity), 2) AS total_sales
FROM fact_sales;

SELECT
    d.drug_code,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
JOIN dim_drug d
    ON f.drug_id = d.drug_id
GROUP BY d.drug_code
ORDER BY total_sales DESC;

SELECT
    d.year,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.year
ORDER BY d.year;

SELECT
    d.month,
    d.month_name,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.month, d.month_name
ORDER BY d.month;

SELECT
    f.hour,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
GROUP BY f.hour
ORDER BY f.hour;

SELECT
    d.weekday_name,
    ROUND(SUM(f.sales_quantity), 2) AS total_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.weekday_name
ORDER BY FIELD(
    d.weekday_name,
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
);

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
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
    ),
    total_sales DESC;
    
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

SELECT
    COUNT(*) AS fact_rows,
    COUNT(DISTINCT date_id) AS unique_dates,
    COUNT(DISTINCT drug_id) AS unique_drugs,
    ROUND(SUM(sales_quantity), 2) AS total_sales
FROM fact_sales;















