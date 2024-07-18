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