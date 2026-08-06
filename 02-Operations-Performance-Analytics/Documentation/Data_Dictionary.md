# Data Dictionary

## dim_team
| Column | Type | Description |
|---|---|---|
| team_id | VARCHAR | Unique Team ID |
| team_name | VARCHAR | Team Name |
| target_productivity | INT | Productivity Target (%) |
| target_quality | INT | Quality Target (%) |
| region | VARCHAR | Region |

## dim_manager
manager_id, manager_name, designation, experience_years

## dim_process
process_id, process_name, business_unit

## dim_country
country_id, country_name, region

## dim_shift
shift_id, shift_name, start_time, end_time

## dim_leave
leave_id, leave_type

## dim_date
date_id, full_date, day_name, month_name, quarter, year

## dim_employee
employee_id, employee_name, gender, team_id, manager_id,
process_id, country_id, shift_id, hire_date, status
