# Household-Income-Analysis

# Household Income Analysis - SQL Project
# Overview
The Household Income Analysis project involves analyzing the income and expenses of household members using various SQL queries. The goal is to derive meaningful insights from the dataset and categorize members based on specific financial metrics, such as expenses, income, and major expense types. These queries explore aspects such as income-to-expense ratios, age group financial trends, and identifying spending behaviors.

# Dataset
# The dataset used in this project consists of a household table, which contains information about the members of a family, including their:

# member_id
# member_name
# birth_date
# income
# expenses
# major_expense_type
# The expenses table includes detailed information on various expense categories for each household member.

# Key SQL Queries
# Assign Expense Segments Based on Spending
# Classifies members into "Low", "Medium", or "High" spending segments based on their total expenses.

# Condition:
Less than 6000: Low
6000 to 9000: Medium
Above 9000: High
Result: Members falling under the "High" segment.
Members with Expenses Greater than Income
Retrieves details of members whose total expenses exceed their income.

# Members Born After 1990 with Rent/Mortgage Expenses
Filters members who were born after 1990 and whose major expenses are either "Rent" or "Mortgage".

# Household Member with Highest Net Income (Rent/Mortgage)
Finds the member with the highest net income (income minus expenses) among those whose major expense is either "Rent" or "Mortgage".

# Member with Highest Income-to-Expense Ratio
Identifies the household member with the highest ratio of income to expenses.

# Age Group with Highest Average Income
Groups members by age and determines the age group with the highest average income. Age groups include:

20-30
30-40
40-50
50-60
60 and above

# Most Common Major Expense Type
Finds the major expense type with the highest number of household members spending on it, such as Rent, Mortgage, Education, or Medical.

# Average Income of Members Spending Over $8000 on Expenses
Calculates the average income of members who spend more than $8000 on major expenses.

# Members with Income Above Age Group Average
Counts the number of household members whose income is greater than the average income of their respective age group.

# Expense Type Accounting for More Than 50% of Total Household Expenses
Identifies which major expense type(s) account for more than 50% of the total household expenses.

# Members Spending More Than $1000 on Medical Expenses
Filters members who have spent over $1000 on medical expenses.

# Members Spending Less than 20% of Income on Expenses
Lists household members who spend less than 20% of their income on expenses.

# Tools and Technologies Used
SQL: To write and execute complex queries for data analysis.
Database Management System (DBMS): The dataset is stored in a relational database and accessed via SQL queries.
Insights and Applications
This project provides valuable insights into the spending behavior of household members, enabling segmentation based on financial health and spending patterns. The analysis can be used for financial planning, budget management, or understanding the impact of various expense categories on household financial stability.


