--Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.

--Assumption:

--There are no duplicates in the candidates table.
--candidates Table:
--Column Name	Type
--candidate_id	integer
--skill	varchar
--candidates Example Input:
--candidate_id	skill
--123	Python
--123	Tableau
--123	PostgreSQL
--234	R
--234	PowerBI
--234	SQL Server
--345	Python
--345	Tableau
--Example Output:
--candidate_id
--123
--Explanation
--Candidate 123 is displayed because they have Python, Tableau, and PostgreSQL skills. 345 isn't included in the output because 
--they're missing one of the required skills: PostgreSQL.

SELECT candidate_id 
FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
group by candidate_id 
having count(skill)>=3
ORDER BY candidate_id ASC;