Business Question 1
What is the total number of customers?

SELECT COUNT(*) AS Total_Customers
FROM raw_telco_churn;

Business Question 2
How many customers have churned?

SELECT COUNT(*) AS Churned_Customers
FROM raw_telco_churn
WHERE Churn = 'Yes';

Business Question 3
How many customers are active?

SELECT COUNT(*) AS Active_Customers
FROM raw_telco_churn
WHERE Churn = 'No';

## Business Question 4

### Question
What is the overall customer churn rate?

### SQL
SELECT
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(*),
        2
    ) AS Churn_Rate
FROM raw_telco_churn;

### Result
26.54%

### Business Insight
Approximately one out of every four customers has churned.

### Recommendation
Prioritize retention strategies for high-risk customer segments to reduce revenue loss.
