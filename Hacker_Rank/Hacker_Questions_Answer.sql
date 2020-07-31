- Hacker Rank --








SELECT LISTAGG(last_name, '; ')
  WITHIN GROUP (ORDER BY number, name asc) "Player List",
MIN(number) "Min Jersey #"
FROM hockey
WHERE position = 'Forward'
and number < 20;


Player List                                                    Min Jersey #
----------------------------------------------------------     ------------      

GREGORY CAMPBELL; MILAN LUCIC; NATHAN HORTON; TYLER SEGUIN      11

 --sin el lsit

Player List                                                    Min Jersey #
----------------------------------------------------------     ------------      

GREGORY CAMPBELL 												 11
MILAN LUCIC 													 11
NATHAN HORTON 													 11
TYLER SEGUIN     												 11




-- Haker rang 1
/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
--Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).

select a.name +"("+ SUBSTRING(a.occupation, 1, 1)+")"  from OCCUPATIONS a order by name asc

--Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:There are a total of [occupation_count] [occupation]s.where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

--There are a total of 2 doctors

select "There are a total of" ,count(occupation), lower(occupation) +"s." from OCCUPATIONS group by occupation order by  count(occupation) asc




--------------  Pivot------------


SELECT DaysToManufacture, AVG(StandardCost) AS AverageCost   
FROM Production.Product  
GROUP BY DaysToManufacture; 

DaysToManufacture AverageCost
----------------- -----------
0                 5.0885
1                 223.88
2                 359.1082
4                 949.4105


-- Pivot table with one row and five columns  
SELECT 'AverageCost' AS Cost_Sorted_By_Production_Days,   
[0], [1], [2], [3], [4]  
FROM  
(SELECT DaysToManufacture, StandardCost   
    FROM Production.Product) AS SourceTable  
PIVOT  
(  
AVG(StandardCost)  
FOR DaysToManufacture IN ([0], [1], [2], [3], [4])  
) AS PivotTable; 



Cost_Sorted_By_Production_Days 0           1           2           3           4         
------------------------------ ----------- ----------- ----------- ----------- -----------
AverageCost                    5.0885      223.88      359.1082    NULL        949.4105








 select name, occupation from OCCUPATIONS group by name,occupation order by occupation asc




SELECT  "name",[Doctor], [Professor], [Singer],[Actor]
    FROM 
    ( SELECT occupation, name FROM OCCUPATIONS  ) AS SourceTable
 PIVOT
 (
 max(name) FOR occupation IN ([Doctor], [Professor], [Singer],[Actor])) AS PivotTable

/*
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.



Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
Inner : 2,6,4,9,13,11	
	
1 2 
3 2 
5 6 
7 6 
2 4 
6 4 
4 15 
8 9 
10 9 
12 13 
14 13 
9 11 
13 11 
11 15 
15 NULL 

*/

select    a.N,
 case
    WHEN (a.N in (select P from BST)) and ((select P from BST b where a.n=b.n) is not null) THEN "Inner"
    WHEN (a.N not in (select P from BST c where a.n=c.n))  THEN "Leaf"
    ELSE "Root" end from BST a order by a.N;
	
	

 







/*
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/
select    
 case
    WHEN a=b and b=c THEN "Equilateral" 
    WHEN (a=b or b=c or a=c) and ((a+b > c) )THEN "Isosceles" 
    WHEN (a<>b and a<>c and b<> c) and ((a+b > c)  )THEN "Scalene" 
    WHEN (a+b <= c)  THEN "Not A Triangle"
    ELSE "Juan" end from TRIANGLES ;




10 10 10 
11 11 11 
30 32 30 
40 40 40 
20 20 21 
21 21 21 
20 22 21 
20 20 40 
20 22 21 
30 32 41 
50 22 51 
20 12 61 
20 22 50 
50 52 51 
80 80 80 



Equilateral 
Equilateral 
Isosceles 
Equilateral 
Isosceles 
Equilateral 
Scalene 
Isosceles 
Scalene 
Scalene 
Scalene 
Scalene 
Scalene 
Scalene 
Equilateral 




--select LAT_N into #Temp1
--from STATION order by LAT_N desc;
select ROW_NUMBER() OVER(ORDER BY LAT_N DESC) AS Row ,LAT_N into #Temp1 from STATION  ;
select  cast(round(LAT_N,4) as numeric(36,4)) from #Temp1 where Row =((select count(*) from #Temp1) + 1) /2


--The sum of all values in LAT_N rounded to a scale of  decimal places.
--The sum of all values in LONG_W rounded to a scale of  decimal places  --> sin Cast por alguna razon no funciona
select cast(round(Sum(LAT_N),2)as numeric(36,2)) as lat, cast(round(sum(LONG_W),2) as numeric(36,2)) as lon from STATION 




/*

Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  
key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeroes removed), 
and the actual average salary.*Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.

*/

DECLARE @FakeMean AS INT;
DECLARE @OriginalMean AS INT;
DECLARE @Solution AS INT;
SELECT @FakeMean = AVG(a.Salary) from EMPLOYEES a ;
SELECT @OriginalMean=AVG(CAST((REPLACE( CAST(b.Salary AS varchar),'0','') )as INT)) from EMPLOYEES b ;
PRINT @FakeMean - @OriginalMean

SELECT CEILING( 
    AVG(Salary) 
    - AVG(CAST((REPLACE( CAST(Salary AS varchar),'0','') )as DECIMAL))) FROM EMPLOYEES;




--Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.


 select  distinct(city)
    from station where SUBSTRING(city,1,1) not in ('A','E','I','O','U') and 
   SUBSTRING(city,len(city),1) not in ('a','e','i','o','u') 
   
   
/*
Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.
Write a query to print total number of unique hackers who made at least 1 submission each day (starting on the first day of the contest), 
and find the hacker_id and name of the hacker who made maximum number of submissions each day. If more than one such hacker has a maximum number of submissions,
print the lowest hacker_id. The query should print this information for each day of the contest, sorted by the date.
*/



select * from Submissions
select * from Hackers



 hacker_id is the id of the hacker,
 name is the name of the hacker.

Submissions:
	submission_date is the date of the submission, 
	submission_id is the id of the submission, 
    hacker_id is the id of the hacker who made the submission, 
	score is the score of the submission.

--Fin the hackers  who made at least 1 submission each day

select hacker_id as "hacker_id", count(distinct(submission_date))  as "DaysSubmision"
  into #Hackers_Candidates  from Submissions group by hacker_id  HAVING count(distinct(submission_date)) = 15;

select hacker_id as "hacker_id", max(score)  as "Score_Max"
  into #Hackers_Candidates_2  from Submissions where hacker_id in (select hacker_id from  #Hackers_Candidates ) group by hacker_id  ;
  



-- take the right information from them




/*You are given three tables: Students, Friends and Packages. 
	Students contains two columns: ID and Name. 
	Friends contains two columns:ID and Friend_ID (ID of the ONLY best friend). 
	Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
	
	Write a query to output the names of those students whose best friends got offered a higher salary than them. 
	Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.
	
*/

select a.Name from Students a inner join Friends b on a.ID=b.ID 
		inner join Packages c on b.ID = c.ID
		where a.Salary < b.SalaryS


/*

Given the table schemas below, write a query to print the 
		company_code, 
		founder name, 
		total number of lead managers, 
		total number of senior managers, 
		total number of managers, 
		total number of employees. 
				Order your output by ascending company_code.

Note:

The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.

Company
Lead_Manager
Senior_Manager
Manager
Employee