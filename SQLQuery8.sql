--show the patient name and age, for patients who were in the hospital at least 5 days
select p.patient_name,DATEDIFF(year,p.dob, getdate()) as age
from patient p, visit v
where p.patient_id = v.patient_id and DATEDIFF(day,v.admit_date, v.discharge_date)>=5;

--show the patient name and total doses they were given only when the patient was given at least 27 doses. Order the results by patient name desc
select p.patient_name, sum(th.dose) as [total doses]
from PATIENT p, THERAPY th
where p.patient_id=th.patient_id
group by p.patient_name
having sum(th.dose)>=27
order by p.patient_name desc;

--find the 3 highest dosed patient. Show the patient name for any one in the top 3 for the highest dosed patients.
select p.patient_name
from patient p, THERAPY t
where p.patient_id = t.patient_id
group by p.patient_name

having sum(t.dose) in (
select top 3 sum(dose)
from THERAPY
group by patient_id
order by sum(dose) desc )

--show patient names for the top 3 most expensive patient
select top 3 p.patient_name, sum(t.dose*d.drug_cost) [expense]
from THERAPY t, DRUG d, PATIENT p
where p.patient_id=t.patient_id and t.drug_id=d.drug_id
group by p.patient_name
order by [expense] desc; 

select p.patient_name
from therapy t, drug d, patient p
where p.patient_id = t.patient_id and t.drug_id = d.drug_id
group by p.patient_name
having sum(d.drug_cost*t.dose) in (
select top 3 sum(d.drug_cost*t.dose) [expense]
from THERAPY t, DRUG d
where t.drug_id = d.drug_id
group by t.patient_id
order by [expense] desc);

--show the patient name and average dose, for the patient who is the highest average dosed patient in the hospital
select top 1 p.patient_name, avg(t.dose) [average]
from PATIENT p, THERAPY t
where p.patient_id=t.patient_id
group by p.patient_name
order by [average] desc;

/*We've had a price change on some drugs. If the drug ytpe SOLR or SOLN or PGBK we need to charge 25% more for the drug.
If the drug is TAB or CAP, we need to lower the charge by 5%. Finally, all other drugs need to be raised 10%.
Final output: Patient name, original charge, new charge, order by charge desc*/