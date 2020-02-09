

select pname, price
from part
where price > (

select avg(price)
from part
)

select avg(price)
from part



--show me employees who have a salary > the avg salary of all employees.
select *
from employee

select ename, salary
from employee
where salary > (
select avg(salary)
from employee
);

--show me employees who have a salary > the avg salary of people in their department
select ename, salary, dept
from employee e
where e.salary > (
select avg(salary)
from employee
where employee.dept = e.dept);




--show me the top 3 customers who have placed the most orders

select c.cname
from customer c, order1 o
where c.cno = o.cno
group by c.cname
having count(o.ono) in (

select top 3 count(ono) [numberoforder] --whatever you use in your subquery to generate the list is what you compare with in your main query
from order1
group by cno
order by [numberoforder] desc
); 