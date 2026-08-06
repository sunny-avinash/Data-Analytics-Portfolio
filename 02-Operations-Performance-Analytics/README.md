# 📊 Operations Performance Analytics Dashboard

An end-to-end **Business Intelligence (BI)** project built using **Power BI, MySQL, SQL, Python, and DAX** to monitor operational performance, workforce productivity, employee performance, customer satisfaction, and attendance metrics.

The project simulates a real-world BPO/Operations environment by integrating multiple datasets into a centralized analytical dashboard for business decision-making.

---

## 📌 Project Overview

The Operations Performance Analytics Dashboard provides management with a centralized view of operational KPIs through interactive reports and visualizations.

The dashboard helps answer key business questions such as:

- Which employees are the top performers?
- Which teams complete the highest number of cases?
- Which managers oversee the most productive teams?
- How are operations performing month-over-month?
- Which processes require improvement?
- How productive is each operational shift?
- How satisfied are customers?

---

## 🎯 Project Objectives

- Build an end-to-end Business Intelligence solution
- Design a Star Schema data model
- Create interactive Power BI dashboards
- Develop reusable DAX measures
- Monitor operational KPIs
- Enable data-driven decision-making

---

# 🛠️ Technology Stack

| Technology | Purpose |
|------------|---------|
| Power BI | Dashboard Development |
| MySQL | Database |
| SQL | Data Extraction & Analysis |
| Python (Jupyter Notebook) | Fact Data Generation |
| DAX | KPI Calculations |
| Power Query | Data Transformation |
| GitHub | Version Control |

---

# 🏗️ Project Architecture

```
CSV Files
     │
     ▼
MySQL Database
     │
     ▼
Power Query
     │
     ▼
Star Schema Data Model
     │
     ▼
DAX Measures
     │
     ▼
Power BI Dashboard
```

---

# 🗄️ Data Model

The project follows a **Star Schema** consisting of one Fact table connected to multiple Dimension tables.

## Fact Table

- fact_operations

Approximately **100,000 operational records** containing:

- Employee
- Date
- Team
- Manager
- Country
- Process
- Shift
- Cases Completed
- Login Hours
- Productive Hours
- Idle Hours
- Overtime Hours
- Quality Score
- CSAT
- Adherence
- Handle Time
- Attendance Status

---

## Dimension Tables

- dim_employee
- dim_date
- dim_team
- dim_manager
- dim_country
- dim_process
- dim_shift
- dim_leave

---

# 📊 Dashboard Pages

## 1️⃣ Executive Dashboard

### KPIs

- Total Employees
- Total Cases Completed
- Total Login Hours
- Total Productive Hours
- Total Overtime Hours
- Productivity %
- Average Quality Score
- Average CSAT
- Average Adherence
- Average Handle Time

### Filters

- Year
- Month
- Country
- Process
- Team
- Manager

---

## 2️⃣ Operations Trends

### Visualizations

- Monthly Cases Completed Trend
- Monthly Login Hours Trend
- Monthly Productive vs Idle Hours

---

## 3️⃣ Employee Performance

### Visualizations

- Top 10 Employees by Cases Completed
- Bottom 10 Employees by Cases Completed
- Top 10 Employees by Productivity
- Bottom 10 Employees by Productivity

---

## 4️⃣ Employee Satisfaction

### Visualizations

- Top 10 Employees by CSAT
- Bottom 10 Employees by CSAT
- Top 10 Employees by Quality Score
- Bottom 10 Employees by Quality Score

---

## 5️⃣ Process & Team Analysis

### Visualizations

- Cases Completed by Process
- Cases Completed by Team
- Cases Completed by Manager
- Cases Completed by Country

---

## 6️⃣ Attendance & Productivity

### Visualizations

- Attendance Status Distribution
- Average Adherence by Team
- Productivity by Process
- Average Handle Time by Shift
- Productivity by Team

---

# 📈 Key Performance Indicators (KPIs)

- Total Employees
- Total Cases Completed
- Total Login Hours
- Total Productive Hours
- Total Idle Hours
- Total Overtime Hours
- Productivity %
- Average Quality Score
- Average CSAT
- Average Adherence
- Average Handle Time

---

# 📂 Repository Structure

```
Operations-Performance-Analytics/
│
├── Dashboard/
│   └── Operations_Performance_Dashboard.pbix
│
├── Dataset/
│   ├── Fact_Data.csv
│   └── Dimension Tables/
│
├── SQL/
│   ├── Database Scripts
│   └── Table Creation Scripts
│
├── Python/
│   └── Generate_Fact_Data.ipynb
│
├── Screenshots/
│   ├── Executive Dashboard.png
│   ├── Operations Trends.png
│   ├── Employee Performance.png
│   ├── Employee Satisfaction.png
│   ├── Process & Team Analysis.png
│   └── Attendance & Productivity.png
│
├── README.md
└── Documentation.pdf
```

---

# 🚀 Features

- Interactive Dashboard
- Star Schema Data Model
- DAX Measures
- Cross Filtering
- KPI Cards
- Multi-page Reports
- Dynamic Slicers
- Business Intelligence Reporting
- Responsive Dashboard Design

---

# 💡 Business Insights

The dashboard enables organizations to:

- Monitor employee productivity
- Compare team performance
- Evaluate manager performance
- Analyze operational trends
- Measure customer satisfaction
- Track attendance and overtime
- Identify process bottlenecks
- Support data-driven operational decisions

---

# 🎓 Skills Demonstrated

- Power BI Dashboard Development
- Data Modeling (Star Schema)
- SQL Querying
- MySQL Database Design
- Python Data Generation
- Power Query
- DAX Measures
- KPI Reporting
- Data Visualization
- Business Intelligence
- Analytical Thinking

---

# 📷 Dashboard Preview

> Add screenshots of each dashboard page inside the **Screenshots** folder.

- Executive Dashboard
- Operations Trends
- Employee Performance
- Employee Satisfaction
- Process & Team Analysis
- Attendance & Productivity

---

# 🔮 Future Enhancements

- Row-Level Security (RLS)
- Drill-through Reports
- Custom Tooltips
- Mobile Layout
- Automated Data Refresh
- Predictive Analytics

---

# 👨‍💻 Author

**Sunny Avinash**

Data Analyst

### Skills

- Power BI
- SQL
- MySQL
- Python
- Tableau
- Excel
- Data Analytics

---

## ⭐ If you found this project helpful, consider giving it a star!
