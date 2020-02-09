--get the customer names and all revenue generated from these customers, order results by the highest revenue

select c.cname, sum(p.price*od.qty) [Revenue]
from customer c, order1 o, odetails od, part p
where c.cno = o.cno and o.ono = od.ono and od.pno = p.pno
group by c.cname
order by [Revenue] desc;

/*

c.cno = o.cno 
o.ono = od.ono 
od.pno = p.pno
e.eno = o.eno

*/

--show the customer name for the customer who placed the most expensive order

select c.cname
from customer c, order1 o, odetails od, part p
where c.cno = o.cno and o.ono = od.ono and od.pno = p.pno
group by od.ono, c.cname
having sum(p.price*od.qty) >= all(
select
from part p, odetails od;

select max(revenue) from (
select sum(p.price*od.qty) [revenue]
from part p, odetails od
where p.pno = od.pno
group by od.ono) [sadssad];




