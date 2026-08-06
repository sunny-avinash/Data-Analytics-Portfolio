# Data Profiling

## Project
Operations Performance Analytics

## Dimension Tables

| Table | Rows | Description |
|------|----:|-------------|
| dim_team | 6 | Team master |
| dim_manager | 6 | Manager master |
| dim_process | 10 | Business processes |
| dim_country | 10 | Countries/Regions |
| dim_shift | 4 | Shift timings |
| dim_leave | 8 | Leave types |
| dim_date | 365 | Calendar dimension |
| dim_employee | 500 | Employee master |

## Data Quality Checks
- Primary keys are unique.
- No blank IDs.
- Standardized naming conventions.
- Appropriate data types.
- No duplicate records.

## Next Step
Generate fact_operations_daily.csv (~100,000+ records).
