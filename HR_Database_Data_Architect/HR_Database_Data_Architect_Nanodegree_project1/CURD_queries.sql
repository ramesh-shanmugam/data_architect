
/* Question 1: Return a list of employees with Job Titles and Department Names */

select Employee_Name,Job_Title, Depart_Name from
employment_details 
inner join employee_details on employee_details.Employee_ID = employment_details.Emp_ID
inner join department on employment_details.Depart_ID = department.Department_ID
inner join job_title on job_title.Job_ID = employment_details.Job_ID

/*Question 2: Insert Web Programmer as a new job title*/

insert into job_title(Job_Title) values("Web Programmer");
select * from job_title;

/*Question 3: Correct the job title from web programmer to web developer*/


UPDATE job_title SET Job_Title='Web Developer' WHERE Job_Title='Web Programmer';
select * from job_title;

/*Question 4: Delete the job title Web Developer from the database*/


delete from job_title where Job_Title='Web Developer';
select * from job_title;

/* Question 5: How many employees are in each department? */
select department.Depart_Name as `department Name`,
count(employment_details.Emp_ID) as `Count`
from department
inner join employment_details on department.Department_ID = employment_details.Depart_ID
group by department.Depart_Name;


/*Question 6: Write a query that returns current and past jobs (include employee name, job title, department, manager name, start and end date for position) for employee Toni Lembeck.*/


with manager_table as ( select distinct employee_details.Employee_ID as manager_id,
employee_details.Employee_Name as manager_name
from employee_details
inner join employment_details on employee_details.Employee_ID = employment_details.Manager_ID)
select employee_details.Employee_Name as employee_name ,job_title.Job_Title as job_title,
department.Depart_Name as depart_name,manager_table.manager_name as manager_name,
employment_details.Start_DT as start_date, employment_details.End_DT as end_date
from employment_details
inner join employee_details on employee_details.Employee_ID = employment_details.Emp_ID
inner join department on department.Department_ID = employment_details.Depart_ID
inner join job_title on job_title.Job_ID = employment_details.Job_ID
inner join manager_table on manager_table.manager_id = employment_details.Manager_ID
where employee_details.Employee_Name ='Toni Lembeck';

