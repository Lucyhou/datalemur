--snapshot

--Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

--Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

--Notes:

--Calculate the following percentages:
--time spent sending / (Time spent sending + Time spent opening)
--Time spent opening / (Time spent sending + Time spent opening)
--To avoid integer division in percentages, multiply by 100.0 and not 100.
--Effective April 15th, 2023, the solution has been updated and optimised.

--activities Table
--Column Name	Type
--activity_id	integer
--user_id	integer
--activity_type	string ('send', 'open', 'chat')
--time_spent	float
--activity_date	datetime
--activities Example Input
--activity_id	user_id	activity_type	time_spent	activity_date
--7274	123	open	4.50	06/22/2022 12:00:00
--2425	123	send	3.50	06/22/2022 12:00:00
--1413	456	send	5.67	06/23/2022 12:00:00
--1414	789	chat	11.00	06/25/2022 12:00:00
--2536	456	open	3.00	06/25/2022 12:00:00
--age_breakdown Table
--Column Name	Type
--user_id	integer
--age_bucket	string ('21-25', '26-30', '31-25')
--age_breakdown Example Input
--user_id	age_bucket
--123	31-35
--456	26-30
--789	21-25
--Example Output
--age_bucket	send_perc	open_perc
--26-30	65.40	34.60
--31-35	43.75	56.25

with t1 as(SELECT ab.age_bucket, a.*
FROM age_breakdown ab 
left join activities a on ab.user_id=a.user_id)


select age_bucket
,round(send_t/(send_t+open_t)*100.0,2) send_perc
,round(open_t/(send_t+open_t)*100.0,2) open_perc
FROM 
(
select age_bucket
,sum(case when activity_type='send' then time_spent else 0 end) send_t
,sum(case when activity_type ='open' then time_spent else 0 end) open_t
,sum(time_spent)
from t1
group by age_bucket
)b ;