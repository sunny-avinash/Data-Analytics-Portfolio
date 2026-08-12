# Pharmaceutical Sales Analytics --- Python EDA

## 📌 Project Overview

This project performs **Exploratory Data Analysis (EDA)** on hourly
pharmaceutical sales data using Python.

The objective is to understand sales patterns across drugs, years,
months, hours, weekdays, product contribution, and drug-weekday
combinations.

This is the **Python stage** of the Pharmaceutical Sales Analytics
portfolio project. SQL analysis and Tableau visualization will follow as
separate stages.

## 🎯 Business Objectives

-   Identify the highest-selling pharmaceutical products.
-   Analyze yearly, monthly, hourly, and weekday sales patterns.
-   Measure each drug's contribution to total sales.
-   Identify sales concentration using Pareto analysis.
-   Compare drug performance across weekdays.
-   Generate business insights from the sales data.

## 🗂️ Dataset

**File:** `saleshourly.csv`

-   **Rows:** 50,532
-   **Columns:** 13
-   **Period:** 2014--2019
-   **Drug columns:** M01AB, M01AE, N02BA, N02BE, N05B, N05C, R03, R06

  Column           Description
  ---------------- ------------------------------
  `datum`          Date and time of observation
  `M01AB`          Drug/product sales
  `M01AE`          Drug/product sales
  `N02BA`          Drug/product sales
  `N02BE`          Drug/product sales
  `N05B`           Drug/product sales
  `N05C`           Drug/product sales
  `R03`            Drug/product sales
  `R06`            Drug/product sales
  `Year`           Year
  `Month`          Month number
  `Hour`           Hour of day
  `Weekday Name`   Day of week

## 🛠️ Tools & Libraries

-   Python
-   Jupyter Notebook
-   Pandas
-   Matplotlib

## 🔍 Data Preparation

### Load Dataset

``` python
import pandas as pd

file_path = r"D:\Data-Analytics-Portfolio\03-Pharmaceutical-Sales-Analytics\Dataset\saleshourly.csv"

df = pd.read_csv(file_path)
df.head()
```

### Convert Date Column

``` python
df['datum'] = pd.to_datetime(df['datum'])
```

### Data Quality Checks

``` python
print("Duplicate rows:", df.duplicated().sum())
print("Missing values:", df.isnull().sum().sum())
```

Result:

-   Duplicate rows: **0**
-   Missing values: **0**

## 📊 Exploratory Data Analysis

### 1. Drug-Level Descriptive Statistics

``` python
drug_columns = [
    'M01AB', 'M01AE', 'N02BA', 'N02BE',
    'N05B', 'N05C', 'R03', 'R06'
]

df[drug_columns].describe().T
```

### 2. Total Sales by Drug

`N02BE` is the dominant product.

  Drug      Total Sales
  ------- -------------
  N02BE       63,005.40
  N05B        18,645.74
  R03         11,608.82
  M01AB       10,600.94
  M01AE        8,204.62
  N02BA        8,172.21
  R06          6,107.82
  N05C         1,249.96

### 3. Total Sales by Year

``` python
df['Total_Sales'] = df[drug_columns].sum(axis=1)

yearly_sales = (
    df.groupby('Year')['Total_Sales']
      .sum()
      .sort_index()
)
```

  Year     Total Sales
  ------ -------------
  2014       20,238.34
  2015       22,752.36
  2016       25,234.93
  2017       19,399.37
  2018       22,884.56
  2019       17,085.96

**Insight:** 2016 recorded the highest annual sales, while 2019 recorded
the lowest.

### 4. Monthly Sales

January recorded the highest monthly sales, while July recorded the
lowest.

### 5. Hourly Sales

Sales are concentrated during daytime and evening hours. The strongest
observed hourly sales are around 19:00--20:00.

### 6. Drug Sales Trend by Year

A multi-line trend chart was created to compare each drug from 2014 to
2019. `N02BE` consistently dominates the other products.

## 📈 Pareto Analysis

``` python
drug_contribution = (
    df[drug_columns]
    .sum()
    .sort_values(ascending=False)
)

drug_contribution_pct = (
    drug_contribution /
    drug_contribution.sum() * 100
).round(2)

pareto = drug_contribution_pct.to_frame(name='Sales_%')
pareto['Cumulative_%'] = pareto['Sales_%'].cumsum()
```

  Drug      Sales Contribution   Cumulative
  ------- -------------------- ------------
  N02BE                 49.38%       49.38%
  N05B                  14.61%       63.99%
  R03                    9.10%       73.09%
  M01AB                  8.31%       81.40%
  M01AE                  6.43%       87.83%
  N02BA                  6.40%       94.23%
  R06                    4.79%       99.02%
  N05C                   0.98%      100.00%

**Key insight:** N02BE contributes approximately **49.38%** of total
sales, while the top four products contribute approximately **81.40%**.

## 📅 Weekday Analysis

``` python
weekday_order = [
    'Monday', 'Tuesday', 'Wednesday',
    'Thursday', 'Friday', 'Saturday', 'Sunday'
]

weekday_sales = (
    df.groupby('Weekday Name')['Total_Sales']
      .sum()
      .reindex(weekday_order)
)
```

**Key insight:** Saturday has the highest overall sales, while Thursday
has the lowest.

## 🔥 Drug × Weekday Heatmap

``` python
weekday_drug_sales = (
    df.groupby('Weekday Name')[drug_columns]
      .sum()
      .reindex(weekday_order)
)
```

The heatmap shows that:

-   `N02BE` is the strongest-selling product across all weekdays.
-   `N02BE` is particularly strong on Saturday and Sunday.
-   `N05B` is the second major contributor.
-   `N05C` has comparatively low sales.

## 📊 Visualizations Created

1.  Total Sales by Drug
2.  Total Pharmaceutical Sales by Year
3.  Total Pharmaceutical Sales by Month
4.  Total Pharmaceutical Sales by Hour
5.  Drug Sales Trend by Year
6.  Pharmaceutical Sales Pareto Analysis
7.  Total Pharmaceutical Sales by Weekday
8.  Pharmaceutical Sales by Drug and Weekday Heatmap

## 💡 Key Business Insights

-   **N02BE** is the clear sales leader.
-   N02BE contributes approximately **49.38%** of total sales.
-   The top four products contribute approximately **81.40%** of total
    sales.
-   **2016** had the highest annual sales.
-   **2019** had the lowest annual sales.
-   **January** had the highest monthly sales.
-   **July** had the lowest monthly sales.
-   Sales are concentrated during daytime and evening hours.
-   **Saturday** had the highest weekday sales.
-   N02BE dominates across the weekday/product heatmap.

## 📁 Project Structure

``` text
03-Pharmaceutical-Sales-Analytics/
│
├── Dataset/
│   └── saleshourly.csv
│
├── Python/
│   └── Pharmaceutical_Sales_Analysis.ipynb
│
├── SQL/
│   └── README.md
│
├── Tableau/
│   └── README.md
│
└── README.md
```

## 🚀 Project Roadmap

### Phase 1 --- Python EDA ✅

-   Data loading and validation
-   Data quality checks
-   Descriptive statistics
-   Drug-level analysis
-   Time-based analysis
-   Pareto analysis
-   Weekday analysis
-   Drug × weekday heatmap

### Phase 2 --- SQL Analysis 🔄

Planned:

-   Database/table creation
-   Data validation
-   Drug performance
-   Time-based analysis
-   Rankings
-   Window functions
-   Year-over-year growth
-   Cumulative sales

### Phase 3 --- Tableau Dashboard ⏳

Planned:

-   Executive KPIs
-   Sales trends
-   Drug performance
-   Time-of-day analysis
-   Weekday analysis
-   Pareto/product contribution
-   Interactive filters

## 🎓 Skills Demonstrated

**Python \| Pandas \| Matplotlib \| Jupyter Notebook \| Data Cleaning \|
EDA \| GroupBy \| Aggregation \| Time-Series Analysis \| Data
Visualization \| Pareto Analysis \| Business Insights**

## 👨‍💻 Portfolio Project

**Project:** Pharmaceutical Sales Analytics\
**Current Stage:** Python Exploratory Data Analysis\
**Tools:** Python, Pandas, Matplotlib, Jupyter Notebook\
**Next Stage:** SQL Business Analysis
