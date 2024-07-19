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