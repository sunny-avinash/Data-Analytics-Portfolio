# Exploratory Data Analysis (EDA)

## Project

Telecom Customer Churn Analysis

---

# Objective

The objective of this Exploratory Data Analysis (EDA) is to understand the customer base, identify churn-related metrics, and discover business insights that help reduce customer attrition.

---

# Dataset

- Dataset Name: Telco Customer Churn
- Total Records: 7,043
- Database: telecom_churn_db
- Table: raw_telco_churn

---

# Business Question 1

## What is the total number of customers?

### SQL

```sql
SELECT COUNT(*) AS Total_Customers
FROM raw_telco_churn;
```

### Result

| Total Customers |
|---------------:|
| 7043 |

### Business Insight

The telecom company currently serves **7,043 customers**.

### Recommendation

This value serves as the baseline for all KPIs and business metrics.

---

# Business Question 2

## How many customers have churned?

### SQL

```sql
SELECT COUNT(*) AS Churned_Customers
FROM raw_telco_churn
WHERE Churn='Yes';
```

### Result

| Churned Customers |
|-----------------:|
| 1869 |

### Business Insight

A significant number of customers have discontinued their services.

### Recommendation

Further analysis is required to determine the factors contributing to customer churn.

---

# Business Question 3

## How many customers are active?

### SQL

```sql
SELECT COUNT(*) AS Active_Customers
FROM raw_telco_churn
WHERE Churn='No';
```

### Result

| Active Customers |
|----------------:|
| 5174 |

### Business Insight

Approximately three-fourths of the customers continue to use the service.

### Recommendation

Analyze customer characteristics to understand why these customers remain loyal.

---

# Business Question 4

## What is the overall churn rate?

### SQL

```sql
SELECT
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/
COUNT(*),2) AS Churn_Rate
FROM raw_telco_churn;
```

### Result

| Churn Rate |
|-----------:|
| 26.54% |

### Business Insight

Nearly one out of every four customers has churned.

### Recommendation

Reducing churn should be considered a strategic business priority.

---

# Business Question 5

## What is the retention rate?

### SQL

```sql
SELECT
ROUND(
SUM(CASE WHEN Churn='No' THEN 1 ELSE 0 END)*100.0/
COUNT(*),2) AS Retention_Rate
FROM raw_telco_churn;
```

### Result

| Retention Rate |
|--------------:|
| 73.46% |

### Business Insight

Almost three-fourths of customers remain with the company.

### Recommendation

Identify successful retention factors and strengthen them.

---

# Business Question 6

## What is the total monthly revenue?

### SQL

```sql
SELECT
ROUND(SUM(MonthlyCharges),2) AS Monthly_Revenue
FROM raw_telco_churn;
```

### Result

| Monthly Revenue |
|----------------:|
| 456,116.60 |

### Business Insight

The company generates approximately **456K** in recurring monthly revenue.

### Recommendation

Reducing churn directly protects recurring monthly revenue.

---

# Business Question 7

## What is the total lifetime revenue?

### SQL

```sql
SELECT
ROUND(SUM(TotalCharges),2) AS Total_Revenue
FROM raw_telco_churn;
```

### Result

| Total Revenue |
|--------------:|
| 16,056,168.70 |

### Business Insight

The dataset represents over **16 million** in customer revenue.

### Recommendation

Focus on retaining high-value customers to maximize lifetime value.

---

# Business Question 8

## What is the Average Revenue Per User (ARPU)?

### SQL

```sql
SELECT
ROUND(AVG(MonthlyCharges),2) AS ARPU
FROM raw_telco_churn;
```

### Result

| ARPU |
|-----:|
| 64.76 |

### Business Insight

The average customer contributes approximately **64.76** per month.

### Recommendation

Increase ARPU through cross-selling and premium service offerings.

---

# Business Question 9

## What is the average customer tenure?

### SQL

```sql
SELECT
ROUND(AVG(Tenure),2) AS Avg_Tenure
FROM raw_telco_churn;
```

### Result

| Average Tenure |
|--------------:|
| 32.37 Months |

### Business Insight

Customers stay with the company for approximately **32 months** on average.

### Recommendation

Retention initiatives should focus on customers during their early months.

---

# Business Question 10

## Which contract type has the highest number of customers?

### SQL

```sql
SELECT
Contract,
COUNT(*) AS Customers
FROM raw_telco_churn
GROUP BY Contract
ORDER BY Customers DESC;
```

### Result

| Contract | Customers |
|-----------|----------:|
| Month-to-month | 3875 |
| Two year | 1695 |
| One year | 1473 |

### Business Insight

More than half of the customers are on month-to-month contracts.

### Recommendation

Month-to-month customers are typically more likely to churn. Marketing campaigns should encourage customers to migrate to longer-term contracts.

---

# Summary

## Key Findings

- Total Customers: **7,043**
- Churn Rate: **26.54%**
- Retention Rate: **73.46%**
- Monthly Revenue: **456,116.60**
- Lifetime Revenue: **16,056,168.70**
- ARPU: **64.76**
- Average Tenure: **32.37 Months**
- Most Common Contract: **Month-to-Month**

---

# Conclusion

The exploratory analysis indicates that customer churn is a major business concern, with over one-quarter of customers leaving the company. The prevalence of month-to-month contracts suggests an opportunity to improve customer retention through longer-term contract incentives, personalized engagement, and targeted retention campaigns.
