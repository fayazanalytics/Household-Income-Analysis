#Consider the "household" table provided. Suppose you want to assign a "segment" label to each member based on their expenses as follows:
#If expenses are less than 6000, the segment label should be "Low"
#If expenses are between 6000 and 9000 (inclusive), the segment label should be "Medium"
#If expenses are greater than 9000, the segment label should be "High"
#Write a query to apply these segments to the table and choose all the members which falls under segment “High” as per the above conditions.

SELECT member_name, expenses,
CASE	
WHEN expenses < 6000 THEN 'Low'
WHEN expenses BETWEEN 6000 AND 9000 THEN 'Medium'
ELSE 'High' END AS segment
FROM household;

#The household table contains information about the members of a family, including their income and expenses. You want to retrieve the details of members whose total spending is greater than their income?

SELECT * FROM household WHERE (CASE WHEN expenses - income < 0 THEN 0 ELSE expenses - income END) > 0;

#Retrieve the details of members who were born after 1990 and whose major expense type is either "Rent" or "Mortgage."?

#Which member(s) of the household has/have the highest net income (income minus expenses) among those whose major expense type is either 'Rent' or 'Mortgage'?

SELECT 
  member_name,
  SUM(CASE WHEN major_expense_type IN ('Rent', 'Mortgage') THEN income - expenses ELSE 0 END) AS net_income
FROM household
WHERE major_expense_type IN ('Rent', 'Mortgage')
GROUP BY member_id
ORDER BY net_income DESC
LIMIT 2;

#Which member of the household has the highest ratio of income to expenses?

SELECT member_name
FROM household
ORDER BY CASE
WHEN expenses = 0 THEN 0
ELSE income / expenses
END DESC
LIMIT 1;

#Which age group has the highest average income?

SELECT 
  CASE 
    WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 20 AND 30 THEN '20-30' 
    WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 30 AND 40 THEN '30-40' 
    WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 40 AND 50 THEN '40-50' 
    WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 50 AND 60 THEN '50-60' 
    ELSE '60 and above' 
  END AS age_group,
  AVG(income) AS avg_income
FROM household
GROUP BY age_group
ORDER BY avg_income DESC
LIMIT 1;

#Which major expense type has the highest count of household members spending on it?

SELECT
CASE
WHEN major_expense_type = 'Rent' THEN 'Rent'
WHEN major_expense_type = 'Mortgage' THEN 'Mortgage'
WHEN major_expense_type = 'Education' THEN 'Education'
WHEN major_expense_type = 'Medical' THEN 'Medical'
ELSE 'Other'
END AS Expense_Type,
COUNT(*) AS Count
FROM household
GROUP BY Expense_Type
ORDER BY Count DESC
LIMIT 1;

#What is the average income of household members who spend more than 8000 on major expenses?

SELECT
AVG(income) AS Average_Income
FROM household
WHERE expenses > 8000
GROUP BY CASE
WHEN expenses >= 10000 THEN 'High'
WHEN expenses >= 8000 AND expenses < 10000 THEN 'Medium'
ELSE 'Low'
END
HAVING COUNT(*) > 1;

#How many members of the household have an income greater than the average income of their respective age groups?

SELECT COUNT(member_name)
FROM (
  SELECT member_name, income,
    CASE 
      WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 20 AND 30 THEN '20-30' 
      WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 30 AND 40 THEN '30-40' 
      WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 40 AND 50 THEN '40-50' 
      WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 50 AND 60 THEN '50-60' 
      ELSE '60 and above' 
    END AS age_group,
    AVG(income) OVER (PARTITION BY 
      CASE 
        WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 20 AND 30 THEN '20-30' 
        WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 30 AND 40 THEN '30-40' 
        WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 40 AND 50 THEN '40-50' 
        WHEN TIMESTAMPDIFF(YEAR, birth_date, NOW()) BETWEEN 50 AND 60 THEN '50-60' 
        ELSE '60 and above' 
      END
    ) AS avg_income
  FROM household
) AS t
WHERE income > avg_income;

#Which major expense type(s) accounts for more than 50% of the household's total expenses?

SELECT major_expense_type
FROM (
SELECT major_expense_type,
SUM(expenses) OVER (PARTITION BY major_expense_type) AS total_expenses,
CASE
WHEN SUM(expenses) OVER () > 0 AND
SUM(expenses) OVER (PARTITION BY major_expense_type) / SUM(expenses) OVER () > 0.5
THEN 'More than 50%'
ELSE ''
END AS more_than_50_percent
FROM household
) AS subquery
WHERE more_than_50_percent = 'More than 50%';

--- Which household member(s) spent more than $1000 on medical expenses?
SELECT 
  h.member_name
FROM 
  household h 
JOIN 
  expenses e ON h.member_id = e.member_id 
WHERE 
  e.expense_type = 'Medical' 
  AND e.amount > 1000 
GROUP BY 
  h.member_name 
HAVING 
  COUNT(*) >= 1;


--- Which household member(s) spent less than 20% of their income on expenses?

SELECT 
  h.member_name
FROM 
  household h 
JOIN 
  (SELECT 
    member_id, 
    SUM(amount) AS total_expenses 
  FROM 
    expenses 
  GROUP BY 
    member_id) AS e ON h.member_id = e.member_id 
WHERE 
  e.total_expenses < 0.2 * h.income 
GROUP BY 
  h.member_name 
HAVING 
  COUNT(*) >= 1
