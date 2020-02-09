--get the names of employees who have taken orders for parts, where the price was more than 400

select distinct e.ename
from employee e, order1 o, ODETAILS od, PART p
where e.eno=o.eno and o.ono =od.ono and od.pno =p.pno and p.price>400.00;

/*what if I ask for the same information, except this time, the criteria is 
  the revenue from the order had to be greater than 20,000
  Order of operation: FROM, WHERE, GROUP BY, SELECT, HAVING, ORDER BY
  */

select e.ename [Employee Name]
from employee e, order1 o, ODETAILS od, PART p
where e.eno=o.eno and o.ono =od.ono and od.pno =p.pno
group by e.ename
having sum(p.price*od.qty)>20000
order by [Employee Name] desc;

/*WHERE clause is good for connecting tables and SIMPLE filtering.
  HAVING clause is good for complex filtering (min, max, sum, count)*/

--write a query to show me the names of employees who have a salary greater than the average in our company
  
select ename, salary
from EMPLOYEE
where salary >( --nesting the query to make dynamic, check innermost query only to verify your code
select avg(salary)
from EMPLOYEE
); 

--which customers have ordered more often than the average customer? Show me thier names

select cname, count(o.cno) 
from customer c, order1 o
where c.cno=o.cno 
group by c.cname
having count(o.cno)> (
select count(ono)/count(distinct cno)
from Order1
);

--get the names of employees and the difference between the average salary of a "sales" employee.
--and this employee. Order the results by difference in salary descending.
select ename, (select avg(salary) from employee where dept = 'Sales') - salary as [difference_in_salary]
from EMPLOYEE
order by [difference_in_salary] desc;

--show the names of parts where the prices of the part is greater than the average price of all parts
select pname, price
from part
where price>(select avg(price) from part);
