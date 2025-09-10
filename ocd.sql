SELECT * FROM ocd.ocd_patient_dataset;
-- 1. Count of F vs M that have OCD & -- Average obsession score by gender
with data as (
SELECT
Gender,
COUNT(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score

FROM ocd.ocd_patient_dataset
GROUP BY 1
)
SELECT 
	sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
	sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

	round(sum(case when Gender = 'Female' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end) +sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	as pct_female,


	round(sum(case when Gender = 'Male' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end) +sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	as pct_male
from data
;


-- 2. Count & average obsession score by ethnicities that have ocd
SELECT 
Ethnicity,
COUNT(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
FROM ocd.ocd_patient_dataset
GROUP BY 1;


-- 3. Numbwe of people diagnosed with OCD MoM
-- alter table ocd.ocd_patient_dataset
-- modify `OCD Diagnosis Date` date;
SELECT
date_format(`OCD Diagnosis Date`, '%Y-%m-01') as month,
count(`Patient ID`) as patient_count
FROM ocd.ocd_patient_dataset
group by 1
order by 1;

-- 4. most common obsession type and respective average obsession score
SELECT 
`Obsession Type`,
count(`Patient ID`) as count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_score
FROM ocd.ocd_patient_dataset
group by 1
order by 2;

-- 5. most common compulsion type and respective average obsession score
SELECT 
`Compulsion Type`,
count(`Patient ID`) as count,
round(avg(`Y-BOCS Score (Compulsions)`),2) as avg_score
FROM ocd.ocd_patient_dataset
group by 1
order by 2;
