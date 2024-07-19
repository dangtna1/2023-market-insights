## Top paying jobs as a Data Analyst working remotely

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    job_posted_date::DATE,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact as jpf INNER JOIN company_dim as cd 
    ON jpf.company_id = cd.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

## Top paying jobs' skills as a Data Analyst

## Top in-demand skills as Data Analyst

## top paying skills as Data Analyst

## top optimal skills as Data Analyst