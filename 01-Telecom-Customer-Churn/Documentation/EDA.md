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
