-- get the skills of top paying jobs that we have found in the first query
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