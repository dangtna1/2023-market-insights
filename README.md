## Top 10 paying jobs as a Data Analyst working remotely

- **Query**
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
- **Result**    

| Job ID   | Job Title                                | Location | Schedule Type | Posted Date | Average Salary (Yearly) | Company Name                             |
|----------|------------------------------------------|----------|---------------|-------------|-------------------------|------------------------------------------|
| 226942   | Data Analyst                             | Anywhere | Full-time     | 2023-02-20  | $650,000.0              | Mantys                                   |
| 547382   | Director of Analytics                    | Anywhere | Full-time     | 2023-08-23  | $336,500.0              | Meta                                     |
| 552322   | Associate Director - Data Insights       | Anywhere | Full-time     | 2023-06-18  | $255,829.5              | AT&T                                     |
| 99305    | Data Analyst, Marketing                  | Anywhere | Full-time     | 2023-12-05  | $232,423.0              | Pinterest Job Advertisements             |
| 1021647  | Data Analyst (Hybrid/Remote)             | Anywhere | Full-time     | 2023-01-17  | $217,000.0              | Uclahealthcareers                        |
| 168310   | Principal Data Analyst (Remote)          | Anywhere | Full-time     | 2023-08-09  | $205,000.0              | SmartAsset                               |
| 731368   | Director, Data Analyst - HYBRID          | Anywhere | Full-time     | 2023-12-07  | $189,309.0              | Inclusively                              |
| 310660   | Principal Data Analyst, AV Performance   | Anywhere | Full-time     | 2023-01-05  | $189,000.0              | Motional                                 |
| 1749593  | Principal Data Analyst                   | Anywhere | Full-time     | 2023-07-11  | $186,000.0              | SmartAsset                               |
| 387860   | ERM Data Analyst                         | Anywhere | Full-time     | 2023-06-09  | $184,000.0              | Get It Recruit - Information Technology  |

## Top paying jobs' skills as a Data Analyst

```sql
WITH top_paying_jobs AS (
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
    LIMIT 10
)
SELECT
    tpj.*,
    skills
FROM
    top_paying_jobs AS tpj 
    INNER JOIN skills_job_dim as sjd ON tpj.job_id = sjd.job_id
    INNER JOIN skills_dim as sd ON sjd.skill_id = sd.skill_id
ORDER BY salary_year_avg DESC
```

## Top in-demand skills as Data Analyst using CTE

- **Query**
```sql
WITH top_demand_skill_ids AS (
    SELECT
        skill_id,
        COUNT(jpf.job_id) AS number_of_jobs
    FROM
        job_postings_fact AS jpf INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    WHERE
        job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
    ORDER BY number_of_jobs DESC
)
SELECT
    top_demand_skill_ids.skill_id,
    skills,
    number_of_jobs
FROM
    top_demand_skill_ids INNER JOIN skills_dim ON top_demand_skill_ids.skill_id = skills_dim.skill_id
ORDER BY number_of_jobs DESC
LIMIT 5;
```

- **Result**

| Skill ID | Skill    | Number of Jobs |
|----------|----------|----------------|
| 0        | SQL      | 92,628         |
| 181      | Excel    | 67,031         |
| 1        | Python   | 57,326         |
| 182      | Tableau  | 46,554         |
| 183      | Power BI | 39,468         |

## top paying skills as Data Analyst
- **Query**
```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg)) AS year_skill_avg
FROM
    job_postings_fact AS jpf 
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY    
    year_skill_avg DESC
LIMIT 25
```
- **Result**

| Skill         | Yearly Average Salary |
|---------------|-----------------------|
| PySpark       | $208,172              |
| Bitbucket     | $189,155              |
| Couchbase     | $160,515              |
| Watson        | $160,515              |
| DataRobot     | $155,486              |
| GitLab        | $154,500              |
| Swift         | $153,750              |
| Jupyter       | $152,777              |
| Pandas        | $151,821              |
| Elasticsearch | $145,000              |
| GoLang        | $145,000              |
| NumPy         | $143,513              |
| Databricks    | $141,907              |
| Linux         | $136,508              |
| Kubernetes    | $132,500              |
| Atlassian     | $131,162              |
| Twilio        | $127,000              |
| Airflow       | $126,103              |
| Scikit-learn  | $125,781              |
| Jenkins       | $125,436              |
| Notion        | $125,000              |
| Scala         | $124,903              |
| PostgreSQL    | $123,879              |
| GCP           | $122,500              |
| MicroStrategy | $121,619              |

## top optimal skills as Data Analyst
- **Query**
```sql
-- optimal skills are:
-- - high paying
-- - high demand
-- - allow to work from home

SELECT
    sjd.skill_id,
    skills,
    COUNT(jpf.job_id) as number_of_jobs,
    ROUND(AVG(salary_year_avg), 0) as skill_year_avg
FROM    
    job_postings_fact as jpf 
    INNER JOIN skills_job_dim as sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim as sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    sjd.skill_id,
    sd.skills
HAVING
    COUNT(sjd.job_id) > 10
ORDER BY
    skill_year_avg DESC,
    number_of_jobs DESC
LIMIT 25;
```
- **Result**

## Job Listings and Average Salary by Skill

| Skill ID | Skill       | Number of Jobs | Yearly Average Salary |
|----------|-------------|----------------|-----------------------|
| 8        | Go          | 27             | $115,320              |
| 234      | Confluence  | 11             | $114,210              |
| 97       | Hadoop      | 22             | $113,193              |
| 80       | Snowflake   | 37             | $112,948              |
| 74       | Azure       | 34             | $111,225              |
| 77       | BigQuery    | 13             | $109,654              |
| 76       | AWS         | 32             | $108,317              |
| 4        | Java        | 17             | $106,906              |
| 194      | SSIS        | 12             | $106,683              |
| 233      | Jira        | 20             | $104,918              |
| 79       | Oracle      | 37             | $104,534              |
| 185      | Looker      | 49             | $103,795              |
| 2        | NoSQL       | 13             | $101,414              |
| 1        | Python      | 236            | $101,397              |
| 5        | R           | 148            | $100,499              |
| 78       | Redshift    | 16             | $99,936               |
| 187      | Qlik        | 13             | $99,631               |
| 182      | Tableau     | 230            | $99,288               |
| 197      | SSRS        | 14             | $99,171               |
| 92       | Spark       | 13             | $99,077               |
| 13       | C++         | 11             | $98,958               |
| 186      | SAS         | 63             | $98,902               |
| 7        | SAS         | 63             | $98,902               |
| 61       | SQL Server  | 35             | $97,786               |
| 9        | JavaScript  | 20             | $97,587               |

