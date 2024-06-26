
--- Identify the total number of hiring posts in the U.S
SELECT
    COUNT(*) AS number_of_post
FROM job_postings_fact
WHERE job_country = 'United States';


--- What job titles appeared most of the time in the U.S job market
SELECT 
    job_title_short AS job_title,
    COUNT(job_id) AS job_title_count,
    ROUND((COUNT(*)/SUM(COUNT(job_id)) OVER()) * 100,2) AS percentage,
    ROUND(AVG(salary_year_avg),0) AS yearly_salary
FROM job_postings_fact
WHERE job_country = 'United States'
GROUP BY job_title_short
ORDER BY job_title_count DESC;


--- Identify top 5 job sites for DA roles
SELECT
    job_via,
    COUNT(job_id) AS number_of_post
FROM job_postings_fact
WHERE job_country = 'United States' AND
    job_title_short = 'Data Analyst'
GROUP BY job_via
ORDER BY number_of_post DESC
LIMIT 5


--- Companies have the most job hiring posts for DA roles
SELECT
    cd.name,
    COUNT(job_id) As number_of_post,
    ROUND(AVG(salary_year_avg),2) AS yearly_salary
FROM job_postings_fact
JOIN company_dim AS cd
    ON cd.company_id = job_postings_fact.company_id
WHERE job_country = 'United States' AND
    job_title_short = 'Data Analyst'
GROUP BY cd.name
ORDER BY number_of_post DESC
LIMIT 5



