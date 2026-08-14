CREATE DATABASE pharma_sales_analytics;

USE pharma_sales_analytics;

USE pharma_sales_analytics;

CREATE TABLE stg_sales_hourly (
    datum VARCHAR(30),
    M01AB DECIMAL(10,3),
    M01AE DECIMAL(10,3),
    N02BA DECIMAL(10,3),
    N02BE DECIMAL(10,3),
    N05B DECIMAL(10,3),
    N05C DECIMAL(10,3),
    R03 DECIMAL(10,3),
    R06 DECIMAL(10,3),
    Year INT,
    Month INT,
    Hour INT,
    `Weekday Name` VARCHAR(15)
);

CREATE TABLE stg_sales_daily (
    datum VARCHAR(30),
    M01AB DECIMAL(10,3),
    M01AE DECIMAL(10,3),
    N02BA DECIMAL(10,3),
    N02BE DECIMAL(10,3),
    N05B DECIMAL(10,3),
    N05C DECIMAL(10,3),
    R03 DECIMAL(10,3),
    R06 DECIMAL(10,3),
    Year INT,
    Month INT,
    Hour INT,
    `Weekday Name` VARCHAR(15)
);

CREATE TABLE stg_sales_weekly (
    datum VARCHAR(30),
    M01AB DECIMAL(10,3),
    M01AE DECIMAL(10,3),
    N02BA DECIMAL(10,3),
    N02BE DECIMAL(10,3),
    N05B DECIMAL(10,3),
    N05C DECIMAL(10,3),
    R03 DECIMAL(10,3),
    R06 DECIMAL(10,3)
);

CREATE TABLE stg_sales_monthly (
    datum VARCHAR(30),
    M01AB DECIMAL(10,3),
    M01AE DECIMAL(10,3),
    N02BA DECIMAL(10,3),
    N02BE DECIMAL(10,3),
    N05B DECIMAL(10,3),
    N05C DECIMAL(10,3),
    R03 DECIMAL(10,3),
    R06 DECIMAL(10,3)
);

USE pharma_sales_analytics;

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';

USE pharma_sales_analytics;

LOAD DATA LOCAL INFILE 'D:/Data-Analytics-Portfolio/03-Pharmaceutical-Sales-Analytics/Dataset/saleshourly.csv'
INTO TABLE stg_sales_hourly
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    datum,
    M01AB,
    M01AE,
    N02BA,
    N02BE,
    N05B,
    N05C,
    R03,
    R06,
    Year,
    Month,
    Hour,
    `Weekday Name`
);

SELECT COUNT(*) AS row_count
FROM stg_sales_hourly;

SELECT COUNT(*) AS missing_datum
FROM stg_sales_hourly
WHERE datum IS NULL;

SELECT MIN(datum) AS min_date,
       MAX(datum) AS max_date
FROM stg_sales_hourly;

SELECT 
    MIN(STR_TO_DATE(datum, '%m/%d/%Y %H:%i')) AS min_date,
    MAX(STR_TO_DATE(datum, '%m/%d/%Y %H:%i')) AS max_date
FROM stg_sales_hourly;

CREATE TABLE fact_sales_hourly (
    sale_datetime DATETIME NOT NULL,
    M01AB DECIMAL(10,3),
    M01AE DECIMAL(10,3),
    N02BA DECIMAL(10,3),
    N02BE DECIMAL(10,3),
    N05B DECIMAL(10,3),
    N05C DECIMAL(10,3),
    R03 DECIMAL(10,3),
    R06 DECIMAL(10,3),
    year INT,
    month INT,
    hour INT,
    weekday_name VARCHAR(15)
);

INSERT INTO fact_sales_hourly
SELECT
    STR_TO_DATE(datum, '%m/%d/%Y %H:%i'),
    M01AB,
    M01AE,
    N02BA,
    N02BE,
    N05B,
    N05C,
    R03,
    R06,
    Year,
    Month,
    Hour,
    `Weekday Name`
FROM stg_sales_hourly;

SELECT COUNT(*) AS row_count
FROM fact_sales_hourly;

CREATE TABLE dim_drug (
    drug_id INT AUTO_INCREMENT PRIMARY KEY,
    drug_code VARCHAR(10) NOT NULL UNIQUE
);

INSERT INTO dim_drug (drug_code)
VALUES
('M01AB'),
('M01AE'),
('N02BA'),
('N02BE'),
('N05B'),
('N05C'),
('R03'),
('R06');

SELECT * FROM dim_drug;

CREATE TABLE dim_date (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    year INT,
    month INT,
    month_name VARCHAR(15),
    quarter VARCHAR(5),
    weekday_name VARCHAR(15)
);

INSERT INTO dim_date (
    full_date,
    year,
    month,
    month_name,
    quarter,
    weekday_name
)
SELECT DISTINCT
    DATE(sale_datetime),
    YEAR(sale_datetime),
    MONTH(sale_datetime),
    MONTHNAME(sale_datetime),
    CONCAT('Q', QUARTER(sale_datetime)),
    DAYNAME(sale_datetime)
FROM fact_sales_hourly
ORDER BY DATE(sale_datetime);

SELECT COUNT(*) AS date_count
FROM dim_date;

select * from fact_sales_hourly;

CREATE TABLE fact_sales (
    sales_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    date_id INT NOT NULL,
    drug_id INT NOT NULL,
    sale_datetime DATETIME NOT NULL,
    sales_quantity DECIMAL(10,3) NOT NULL,
    hour INT,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (drug_id) REFERENCES dim_drug(drug_id)
);

INSERT INTO fact_sales (
    date_id,
    drug_id,
    sale_datetime,
    sales_quantity,
    hour
)

SELECT
    d.date_id,
    dr.drug_id,
    f.sale_datetime,
    f.M01AB,
    f.hour
FROM fact_sales_hourly f
JOIN dim_date d
    ON d.full_date = DATE(f.sale_datetime)
JOIN dim_drug dr
    ON dr.drug_code = 'M01AB'

UNION ALL

SELECT
    d.date_id,
    dr.drug_id,
    f.sale_datetime,
    f.M01AE,
    f.hour
FROM fact_sales_hourly f
JOIN dim_date d
    ON d.full_date = DATE(f.sale_datetime)
JOIN dim_drug dr
    ON dr.drug_code = 'M01AE'

UNION ALL

SELECT
    d.date_id,
    dr.drug_id,
    f.sale_datetime,
    f.N02BA,
    f.hour
FROM fact_sales_hourly f
JOIN dim_date d
    ON d.full_date = DATE(f.sale_datetime)
JOIN dim_drug dr
    ON dr.drug_code = 'N02BA'

UNION ALL

SELECT
    d.date_id,
    dr.drug_id,
    f.sale_datetime,
    f.N02BE,
    f.hour
FROM fact_sales_hourly f
JOIN dim_date d
    ON d.full_date = DATE(f.sale_datetime)
JOIN dim_drug dr
    ON dr.drug_code = 'N02BE'

UNION ALL

SELECT
    d.date_id,
    dr.drug_id,
    f.sale_datetime,
    f.N05B,
    f.hour
FROM fact_sales_hourly f
JOIN dim_date d
    ON d.full_date = DATE(f.sale_datetime)
JOIN dim_drug dr
    ON dr.drug_code = 'N05B'

UNION ALL

SELECT
    d.date_id,
    dr.drug_id,
    f.sale_datetime,
    f.N05C,
    f.hour
FROM fact_sales_hourly f
JOIN dim_date d
    ON d.full_date = DATE(f.sale_datetime)
JOIN dim_drug dr
    ON dr.drug_code = 'N05C'

UNION ALL

SELECT
    d.date_id,
    dr.drug_id,
    f.sale_datetime,
    f.R03,
    f.hour
FROM fact_sales_hourly f
JOIN dim_date d
    ON d.full_date = DATE(f.sale_datetime)
JOIN dim_drug dr
    ON dr.drug_code = 'R03'

UNION ALL

SELECT
    d.date_id,
    dr.drug_id,
    f.sale_datetime,
    f.R06,
    f.hour
FROM fact_sales_hourly f
JOIN dim_date d
    ON d.full_date = DATE(f.sale_datetime)
JOIN dim_drug dr
    ON dr.drug_code = 'R06';
    
    SELECT COUNT(*) AS total_rows
FROM fact_sales;

SELECT COUNT(DISTINCT date_id) AS unique_dates
FROM fact_sales;

SELECT COUNT(DISTINCT drug_id) AS unique_drugs
FROM fact_sales;

SELECT 
    MIN(sale_datetime) AS min_datetime,
    MAX(sale_datetime) AS max_datetime
FROM fact_sales;



