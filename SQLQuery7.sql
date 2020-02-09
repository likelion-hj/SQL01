--show the part name and price for the top 5 most ordered parts (in terms of quantity ordered)

select p.pname, p.price
from part p, odetails od
where p.pno = od.pno
group by p.pname, p.price

having sum(od.qty) in ( 
select top 5 sum(qty)
from ODETAILS
group by pno
order by sum(qty) desc)

/*list the patient id and patient name where the patient has an allergy to soy wheat or the patient has a diagnosis of heart failure 
(hint there are multiple spellings of heart failure)
order the results by patient name descending*/

select p.patient_id, p.patient_name
from patient p, visit v
where p.patient_id = v.patient_id and (p.allergies ='soy wheat' or v.diagnosis like '%heart%')
order by p.patient_name desc

--show the physician's name, the drug name for the drugs they prescribed along with the number of times that drug was administered to a patent.
--order the results by 'number of times' descending

select ph.physician_name, d.drug_name, count(t.drug_id) [Number of Times]
from physician ph, patient p, therapy t, drug d
where ph.physician_id = p.physician_id and p.patient_id = t.patient_id and t.drug_id = d.drug_id
group by ph.physician_name, d.drug_name
order by [Number of Times] desc
