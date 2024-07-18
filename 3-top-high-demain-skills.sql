-- what are the most in-demand skills for my role?
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
