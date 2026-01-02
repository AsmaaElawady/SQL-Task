-- 1.	Display all the employees Data.
Select * from Employee

-- 2.	Display the employee First name, last name, Salary and Department number.
select Fname, Lname, Salary, Dno from Employee

-- 3.	Display all the projects names, locations and the department which is responsible about it.
select Pname, Plocation
from Project INNER JOIN Departments 
ON Project.Dnum = Departments.Dnum

-- 4.	If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary .Display each employee full name and his annual commission in an ANNUAL COMM column (alias).
select 
    Fname + ' ' + Lname as FullName,
    (Salary * 12 * 0.10) as AnnualComm
from Employee

-- 5.	Display the employees Id, name who earns more than 1000 LE monthly.
select SSN, Fname from Employee
where Salary>1000

-- 6.	Display the employees Id, name who earns more than 10000 LE annually.
select SSN, Fname from Employee
where (Salary * 12)>10000

-- 7.	Display the names and salaries of the female employees 
select Fname,Lname as FullName  from Employee
where Sex = 'F'

-- 8.	Display each department id, name which managed by a manager with id equals 968574.
select Dname, Dnum 
from Departments
where MGRSSN = 968574

-- 9.	Dispaly the ids, names and locations of  the pojects which controled with department 10.
select Pnumber, Pname, Plocation from Project 
where Dnum = 10



--                                        lab part 2

-- For each project, list the project name and the total hours per week (for all employees) spent on that project
select Pname, sum(Hours) as TotalHours
from Project JOIN Works_for 
on Pnumber = pno
group by Pname

-- 1.	Display the data of the department which has the smallest employee ID over all employees' ID.
select Top 1 * from Departments JOIN Employee
on Dnum = Dno 
order by SSN

-- 2.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
select avg(Salary),max(Salary),min(Salary), Dname from Employee JOIN Departments
on Dnum = Dno 
Group by Dname

-- 3.	List the full name of all managers who have no dependents.
select Dnum, Dname, count(SSN) as empCount
from Departments JOIN Employee 
on Dnum = Dno
group by Dnum, Dname
having avg(Salary) < (
select avg(Salary)
from Employee)

-- 4.	For each department-- if its average salary is less than the average salary of all employees-- display its number, name and number of its employees.
select distinct Fname, Lname
from Employee JOIN Departments on SSN = MGRSSN
LEFT JOIN Dependent ON SSN = ESSN
WHERE ESSN IS NULL

-- 5.	Retrieve a list of employee’s names and the projects names they are working on ordered by department number and within each department, ordered alphabetically by last name, first name.
select Fname, Lname, Pname
from Employee
JOIN Works_for on SSN = ESSN
JOIN Project on Pno = Pnumber
order by Dno, Lname, Fname

-- 6.	Try to get the max 2 salaries using sub query
select distinct Salary
from Employee
where Salary IN (
    select TOP 2 Salary
    from Employee
    order by Salary DESC
)
order by Salary DESC

-- 7.	Get the full name of employees that is similar to any dependent name
select distinct Fname, Lname
from Employee
JOIN Dependent
ON Fname +  Lname= Dependent_name

-- 8.	In the department table insert new department called "DEPT IT”, with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'
INSERT INTO Departments(Dname, Dnum, MGRSSN, MGRStartDate)
VALUES ('DEPT IT',100,112233,'1-11-2006')


-- Bouns
-- 9.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) ==== Bons

-- update employee table
update Employee
set Dno = 100
where SSN = 968574

update Employee
set Dno = 20
where SSN = 102672  -- no employee with this SSN


-- a.	First try to update her record in the department table
update Departments
set MGRSSN = 968574
where Dnum = 100

-- b.	Update your record to be department 20 manager.
-- check if employee with SSN = 102672
select * from Employee where SSN = 102672  

-- no employee with SSN = 102672
update Departments
set MGRSSN = 102672    -- this will make error
where Dnum = 20


select SSN from Employee

-- c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

-- no employee with this SSN
update Employee
set Superssn = 102672
where SSN = 102660 


-- 10.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
update Employee
set Salary = Salary * 1.30
from Employee JOIN Works_for
on SSN = ESSn JOIN Project
on Pno = Pnumber
where Pname = 'Al Rabwah'

