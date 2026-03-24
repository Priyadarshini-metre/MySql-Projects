CREATE DATABASE hospital_db;
USE hospital_db;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    disease VARCHAR(100),
    admission_date DATE
);

INSERT INTO patients VALUES
(1,'Arun Kumar',34,'Male','9876543210','Fever','2026-01-10'),
(2,'Priya Sharma',28,'Female','9876543211','Diabetes','2026-01-12'),
(3,'Rahul Das',45,'Male','9876543212','Heart Issue','2026-01-15'),
(4,'Meena Devi',30,'Female','9876543213','Migraine','2026-01-18'),
(5,'Suresh Patel',52,'Male','9876543214','BP','2026-01-20'),
(6,'Anita Roy',26,'Female','9876543215','Fever','2026-01-22'),
(7,'Karan Singh',40,'Male','9876543216','Asthma','2026-01-25'),
(8,'Neha Gupta',33,'Female','9876543217','Allergy','2026-01-26'),
(9,'Ravi Verma',60,'Male','9876543218','Diabetes','2026-01-27'),
(10,'Pooja Mehta',22,'Female','9876543219','Cold','2026-01-28'),
(11,'Ajay Kumar',36,'Male','9876543220','Fever','2026-02-01'),
(12,'Sneha Reddy',29,'Female','9876543221','Skin Infection','2026-02-02'),
(13,'Vikram Rao',50,'Male','9876543222','Heart Issue','2026-02-03'),
(14,'Deepa Iyer',41,'Female','9876543223','BP','2026-02-05'),
(15,'Ramesh Gupta',55,'Male','9876543224','Diabetes','2026-02-07'),
(16,'Kavita Joshi',31,'Female','9876543225','Migraine','2026-02-09'),
(17,'Manoj Sharma',48,'Male','9876543226','Asthma','2026-02-11'),
(18,'Sunita Nair',38,'Female','9876543227','Fever','2026-02-12'),
(19,'Harish Patel',44,'Male','9876543228','Allergy','2026-02-13'),
(20,'Lakshmi Devi',35,'Female','9876543229','Cold','2026-02-14');
select * from patients;

#1.Find total number of patients.
select count(patient_id) from patients;

#2.Find average age of patients.
select avg(age) from patients;

#3.Find maximum patient age.
select max(age) from patients;

#4.Find minimum patient age.
select min(age) from patients;

#5.Count patients per disease.
select disease,count(patient_id) from patients group by disease;

#6.Find diseases affecting more than 2 patients.
select disease,count(patient_id) from patients 
group by disease 
having count(patient_id)>2;

#7.Find diseases affecting exactly 1 patient.
select disease ,count(patient_id) from patients
group by disease
having count(patient_id)=1;

#8.Find diseases affecting the highest number of patients.
select disease from patients
group by disease
having count(patient_id) 
order by disease desc
limit 1;


#9.Find diseases affecting the least number of patients.
select disease from patients
group by disease
having count(patient_id)
order by disease asc
limit 1;

#10.find disease where average patient age is above 40
select disease from patients
group by disease
having avg(age)>40;

#11.Find diseases where maximum patient age exceeds 50.
select disease from patients
group by disease
having max(age)>50;

#12.find disease where minimun patient age is below 30
select disease from patients
group by disease 
having min(age)<30;

select * from patients;

#13.find the admission dates with more than one patient.
select admission_date,count(*) from patients
group by admission_date
having count(*)>1;

#14.Find number of patients admitted each day.
select day(admission_date) as day,
count(*) from patients
group by (admission_date);

#15.Find number of patients admitted each month.
select month(admission_date) as month,
count(*) from patients
group by month(admission_date);

#16.Find earliest admission date.
select min(admission_date) as earliets_date from patients;

#17.Find latest admission date.
select max(admission_date) as latest_date from patients;

#18.Find patients admitted before Feb 1.
select admission_date from patients
where admission_date<"2026-02-01";

#19.Find patients admitted after Jan 25.
select admission_date from patients
where admission_date>"2026-01-25";

#20.Find patients admitted between two dates.
select * from patients
where admission_date between "2026-01-01" and "2026-02-01";

#21.Find diseases where total patient age exceeds 100.
select disease,sum(age) from patients
group by disease
having sum(age)>100;

#22.Find diseases with average patient age above hospital average.
select disease,avg(age) from patients
group by disease
having avg(age)> (select avg(age) from patients);


#23.Find patients older than average patient age.
select * from patients
where age>(select avg(age) from patients);

#24.Find patients younger than average patient age.
select * from patients
where age<(select avg(age) from patients);

#25.Find patients with same age.
SELECT *FROM patients
WHERE age IN (SELECT age FROM patients GROUP BY age
HAVING COUNT(*) > 1
);

#26.Find diseases shared by multiple patients.
select disease from patients
group by disease
having count(*) >1;

#27.Find patients whose disease contains 'Heart'.
select disease from patients where disease like "%heart%" ;

#28.Find patients whose disease contains 'Allergy'.
select disease from patients where disease like "%allergy%";

#29.Find diseases starting with 'A'.
select disease from patients where disease like "a%";

#30.Find diseases ending with 's'.
select disease from patients where disease like "%s";

#31.Find diseases having exactly two patients.
select disease,count(*)  from patients 
group by disease
having count(*) =2;

#32.Find diseases having more male patients than female patients.
select disease from patients
group by disease 
having sum(case when gender="male" then 1 else 0 end)> 
sum(case when gender="female" then 1 else 0 end);

#33.Find diseases having more female patients than male patients.
select disease from patients
group by disease
having sum(case when gender="female" then 1 else 0 end)>
sum(case when gender="male" then 1 else 0 end);

#34.Find diseases where male patient count equals female count.
select disease from patients
group by disease
having sum(case when gender="female" then 1 else 0 end)=
sum(case when gender="male" then 1 else 0 end);

#35.Find diseases where average patient age exceeds 35.
select disease ,avg(age) from patients
group by disease
having avg(age)>35;

#36.Rank diseases based on patient count.
select disease,count(*),
rank() over (order by count(*) desc) as rnk
from patients
group by disease;

#37.Find top 3 diseases with most patients.
SELECT disease, COUNT(*) AS patient_count
FROM patients
GROUP BY disease
ORDER BY patient_count DESC
LIMIT 3;

#38.Find bottom 3 diseases with least patients.
select disease , count(*) from patients
group by disease
order by count(*) asc
limit 3;

#39.Find diseases with duplicate entries.
select disease ,count(*) from patients 
group by disease
having count(*)>1;

#40.Find distinct diseases.
select distinct disease from patients;

#41.Find patient names with longest length.
select name from patients
where length(name)=(select max(length(name))from patients);

#42.find patients names with shortest length
select name from patients
where length(name)=(select min(length(name)) from patients);

#43.Find patients admitted on the same date.
select * from patients
where admission_date 
in (select admission_date from patients 
group by admission_date
having count(*)>1);

#44.Find diseases appearing only once.
SELECT disease
FROM patients
GROUP BY disease
HAVING COUNT(*) = 1;


#45.Find diseases appearing more than once.
select disease from patients
group by disease
having count(disease)>1;

#46.Find patients whose age equals maximum age.
select * from patients
where age =(select max(age) from  patients);

#47.Find patients whose age equals minimum age.
select * from patients
where age=(select min(age) from patients);

#48.Find patients whose admission date equals earliest date.
select * from patients
where admission_date =(select min(admission_date) from patients);

#49.Find patients whose admission date equals latest date.
select * from patients
where admission_date=(select max(admission_date) from patients);

#50.Rank patients based on age.
select name,age, rank()
over (order by age desc) as age_rnk
from patients;

#51.Find top 5 oldest patients.
select * from patients
order by age desc
limit 5;

#52.Find top 5 youngest patients.
select * from patients
order by age asc
limit 5;

#53.Calculate running count of patients by admission date.
select admission_date , count(*) 
over (order by admission_date) as running_count
from patients;

#54.Calculate cumulative patient count.
SELECT admission_date,
SUM(1) OVER(ORDER BY admission_date) AS cumulative_count
FROM patients;


#55.Find age difference from average age.
select age,name -(select avg(age) from patients) as age_difference
from patients;

#56.Calculate percentage of patients per disease.
Select disease,
count(*) * 100.0 / (SELECT COUNT(*) FROM patients) AS percentage
FROM patients
GROUP BY disease;

#57.Rank patients within each disease by age.
 select name,age ,rank()
 over (partition by disease order by age desc) as rank_in_disease
 from patients;
 
#58.Find first patient admitted for each disease.
SELECT * FROM (SELECT *, 
ROW_NUMBER() OVER(PARTITION BY disease ORDER BY admission_date) AS rn
FROM patients
) t
WHERE rn = 1;

#59.Find last patient admitted for each disease.
select * from (
select *,row_number() 
over(partition by disease order by admission_date desc) as rn
from patients ) t
where rn=1;


#60.Find disease with highest average age.
select disease,avg(age) as avg_age from patients
group by disease
order by avg_age desc
limit 1;     

USE hospital_db;
CREATE TABLE billing (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    treatment VARCHAR(100),
    doctor_fee DECIMAL(10,2),
    medicine_cost DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);


INSERT INTO billing VALUES
(1,1,'General Checkup',500,300,800,'Paid'),
(2,2,'Diabetes Test',700,400,1100,'Paid'),
(3,3,'Heart Scan',2000,800,2800,'Pending'),
(4,4,'Migraine Treatment',600,200,800,'Paid'),
(5,5,'BP Check',500,150,650,'Paid'),
(6,6,'Fever Treatment',400,200,600,'Paid'),
(7,7,'Asthma Treatment',900,350,1250,'Pending'),
(8,8,'Allergy Test',800,300,1100,'Paid'),
(9,9,'Diabetes Check',700,300,1000,'Pending'),
(10,10,'Cold Treatment',300,150,450,'Paid'),
(11,11,'Fever Check',400,200,600,'Paid'),
(12,12,'Skin Treatment',800,250,1050,'Pending'),
(13,13,'Heart Consultation',1500,500,2000,'Paid'),
(14,14,'BP Treatment',600,200,800,'Paid'),
(15,15,'Diabetes Treatment',900,300,1200,'Pending');
select * from billing;

#61.Find total hospital revenue.
select sum(total_amount) as revenue from billing;

#62.Find average billing amount.
select avg(total_amount) as avg_billing from billing;

#63.Find highest billing amount.
select max(total_amount) as higest_billing from billing;

#64.Find lowest billing amount.
select min(total_amount) as lowest_billing from billing;

select * from billing;

#65.Count billing records.
select count(*) as records from billing;

#66.Find treatments generating total revenue.
select treatment,sum(total_amount) from billing
group by treatment;

#67.Find treatments generating highest revenue.
select treatment,sum(total_amount) as sums from billing
group by treatment
order by sums desc
limit 1;

#68.Find treatments generating lowest revenue.
select treatment,sum(total_amount) as lowest from billing
group by treatment
order by lowest asc
limit 1;

select * from billing;

#69.Find treatments performed most frequently.
SELECT treatment, COUNT(*) freq
FROM billing
GROUP BY treatment
ORDER BY freq DESC
LIMIT 1;

#70.Find treatments performed least frequently.
select treatment,count(*) freq
from billing
group by treatment
order by freq
limit 1;

#71.Find treatments where average bill exceeds 1000.
select treatment ,avg(total_amount) as avg_bill 
from billing
group by treatment
having avg_bill>1000;

#72.Find treatments where total revenue exceeds 2000.
select treatment ,sum(total_amount) from billing
group by treatment
having sum(total_amount)>2000;

#73.Find treatments where billing count exceeds 2.
select treatment,count(*) from billing
group by treatment
having count(*)>2;

#74.Find treatments where minimum bill is below 600.
select treatment,min(total_amount) from billing
group by treatment
having min(total_amount)<600;

#75.Find treatments where maximum bill exceeds 1500.
select treatment,max(total_amount) from billing
group by treatment
having max(total_amount)>1500; 

select * from billing;

#76.Find patients with billing above average.
select * from billing where total_amount>
(select avg(total_amount) from billing);

#77.Find patients with billing below average.
select * from billing where total_amount <
(select avg(total_amount) from billing);

#78.Find bills equal to average billing.
select * from billing where total_amount=
(select avg(total_amount) from billing);

#79.Find bills above maximum medicine cost.
select * from billing where total_amount >
(select max(medicine_cost) from billing);

#80.Find bills where medicine cost exceeds doctor fee.
select * from billing where medicine_cost >doctor_fee;

#81.Find bills where doctor fee exceeds medicine cost.
select * from billing where doctor_fee > medicine_cost;

#82.Find pending payment bills.
select * from billing where payment_status="pending";

#83.Count pending payment bills.
select count(*) from billing where payment_status="pending";

#84.Count paid bills.
select count(*) from billing where payment_status="paid";

#85.Find treatments with pending payments.
select treatment,payment_status  from billing where payment_status="pending";

select * from billing;

#86.Find treatments with paid payments.
select treatment from billing where payment_status="paid";

#87.Find average medicine cost per treatment.
select treatment, avg(medicine_cost) as avg_medicine_cost
from billing
group by treatment;

#88.Find maximum medicine cost per treatment.
select treatment,max(medicine_cost) as max_medicine_cost
from billing
group by treatment;

#89.Find minimum medicine cost per treatment.
select treatment,min(medicine_cost) as min_medicine_cost
from billing
group by treatment;

#90.Find treatments with medicine cost above average.
select * from billing where medicine_cost >
(select avg(medicine_cost) from billing);

#91.Find treatments with medicine cost below average.
select treatment from billing where medicine_cost <
(select avg(medicine_cost) from billing);

#92.Find second highest bill.
select total_amount from billing
order by total_amount desc
limit 1 offset 1;

#93.Find third highest bill.
select total_amount from billing
order by total_amount desc
limit 1 offset 2;

#94.Find top 3 billing amounts.
select total_amount from billing
order by total_amount desc
limit 3;

#95.Find top 5 medicine costs.
select total_amount from billing
order by total_amount desc
limit 5;

#96.Find billing grouped by treatment.
select treatment,count(*) 
from billing
group by treatment;

#97.Find revenue per treatment.
select treatment,sum(total_amount)
from billing
group by treatment;

#98.Find average billing per treatment.
select treatment,avg(total_amount)
from billing
group by treatment;

select * from billing;

#99.Find total doctor fee collected per treatment.
select treatment,sum(doctor_fee ) as total_doc_fee
from billing
group by treatment;

#100.Find total medicine cost per treatment.
select treatment,sum(medicine_cost) as total_med_fee
from billing
group by treatment;

#101.Find treatments with highest doctor fee total.
select treatment,sum(doctor_fee) as total_fee
from billing
group by treatment
order by total_fee desc
limit 1;

#102.Find treatments with highest medicine cost total.
select treatment , sum(medicine_cost) as total_med_fee
from billing
group by treatment
order by total_med_fee desc
limit 1;

#103.Find billing percentage contribution per treatment.
select treatment,sum(total_amount)*100/(select sum(total_amount) from billing) as percentage
from billing
group by treatment;

#104.Calculate running revenue total.
select bill_id,total_amount,
sum(total_amount) over (order by bill_id) as running_total from billing;

#105.Calculate cumulative billing.
select bill_id,total_amount,
sum(total_amount) over (order by bill_id) as cumulative_bill from billing;

#106.Rank treatments based on revenue.
select treatment,sum(total_amount),rank()
over (order by sum(total_amount) desc) as rank_revenue
from billing
group by treatment;

#107.Rank treatments based on billing count.
select treatment,count(total_amount),rank()
over(order by count(total_amount) desc) as rank_count
from billing
group by treatment;

#108.Rank bills based on amount.
select bill_id,total_amount,rank()
over (order by total_amount desc) as amount_rank
from billing;

#109.Rank bills based on medicine cost.
select bill_id,medicine_cost,rank()
over (order by medicine_cost desc)  as med_rank
from billing;

select * from billing;

#110.Rank bills based on doctor fee.
select bill_id,doctor_fee,rank()
over (order by doctor_fee desc)as doc_rank
from billing;

#111.Find treatments with more than one patient.
select treatment 
from billing 
group by treatment
having count(patient_id)>1;

#112.Find patients with multiple billing records.
select patient_id from billing
group by patient_id
having count(bill_id)>1;


#113.Find treatments used by more than 2 patients.
select treatment
from billing
group by treatment
having count(patient_id)>2;

#114.Find treatments used by exactly one patient.
select treatment 
from billing 
group by treatment
having count(patient_id)=1;

#115.Find treatments used by exactly two patients.
select treatment
from billing
group by treatment
having count(patient_id)=2;

#116.Find bills where total equals doctor fee + medicine cost.
select * from billing where total_amount=doctor_fee+medicine_cost;

#117.Find incorrect billing totals.
select * from billing where total_amount != doctor_fee+medicine_cost;

#118.Find patients whose billing equals maximum billing.
select patient_id from billing where total_amount=
(select max(total_amount) from billing);

#119.Find patients whose billing equals minimum billing.
select patient_id from billing where total_amount=
(select min(total_amount) from billing);

#120.Find billing above treatment average.
select * from billing b where total_amount >
(select avg(total_amount) from billing where treatment=b.treatment);

#121.Find billing below treatment average.
select * from billing b where total_amount <
(select avg(total_amount) from billing where treatment=b.treatment);

#122.Rank bills within each treatment.
SELECT bill_id,treatment,total_amount,
RANK() OVER(PARTITION BY treatment ORDER BY total_amount DESC) AS rank_bill
FROM billing;

#123.Find highest bill per treatment.
SELECT *FROM(
SELECT bill_id,treatment,total_amount,
RANK() OVER(PARTITION BY treatment ORDER BY total_amount DESC) r
FROM billing
) t
WHERE r=1;

#124.Find lowest bill per treatment.
SELECT *FROM(
SELECT bill_id,treatment,total_amount,
RANK() OVER(PARTITION BY treatment ORDER BY total_amount ) r
FROM billing
) t
WHERE r=1;


#125.Find second highest bill per treatment.
SELECT * FROM(
SELECT bill_id,treatment,total_amount,
RANK() OVER(PARTITION BY treatment ORDER BY total_amount DESC) r
FROM billing
) t
WHERE r=2;

SELECT bill_id,treatment,total_amount,
RANK() OVER(PARTITION BY treatment ORDER BY total_amount DESC)
from billing;

#126.Find running total per treatment.
SELECT bill_id,treatment,total_amount,
SUM(total_amount) OVER(PARTITION BY treatment ORDER BY bill_id) AS running_total
FROM billing;

#127.Find revenue difference from average.
SELECT bill_id,total_amount,
total_amount - AVG(total_amount) OVER() AS diff_from_avg
FROM billing;

#128.Find percentage share per bill.
SELECT bill_id,total_amount,
(total_amount*100.0 / SUM(total_amount) OVER()) AS percentage
FROM billing;

#129.Find cumulative medicine cost.
SELECT bill_id,medicine_cost,
SUM(medicine_cost) OVER(ORDER BY bill_id) AS cumulative_medicine
FROM billing;

#130.Find cumulative doctor fee.
SELECT bill_id,doctor_fee,
SUM(doctor_fee) OVER(ORDER BY bill_id) AS cumulative_doctor_fee
FROM billing;

USE hospital_db;
select * from billing;
select * from  patients;


CREATE TABLE doctor_schedules (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(100),
    available_day VARCHAR(20),
    available_time VARCHAR(50)
);

INSERT INTO doctor_schedules VALUES
(1,'Dr. Rajesh','Cardiologist','Monday','10AM-2PM'),
(2,'Dr. Anita','Dermatologist','Tuesday','11AM-3PM'),
(3,'Dr. Kumar','General Physician','Wednesday','9AM-1PM'),
(4,'Dr. Sneha','Neurologist','Thursday','10AM-2PM'),
(5,'Dr. Vikram','Orthopedic','Friday','12PM-4PM'),
(6,'Dr. Meera','Gynecologist','Saturday','9AM-1PM'),
(7,'Dr. Arjun','ENT','Monday','2PM-6PM'),
(8,'Dr. Pooja','Pediatrician','Tuesday','10AM-2PM'),
(9,'Dr. Ravi','Cardiologist','Wednesday','11AM-3PM'),
(10,'Dr. Nisha','Dentist','Thursday','9AM-12PM'),
(11,'Dr. Sanjay','Orthopedic','Friday','1PM-5PM'),
(12,'Dr. Deepa','Neurologist','Saturday','10AM-2PM'),
(13,'Dr. Manoj','General Physician','Monday','8AM-12PM'),
(14,'Dr. Kavita','Dermatologist','Tuesday','1PM-4PM'),
(15,'Dr. Suresh','ENT','Wednesday','2PM-6PM');




#131.Show patient name with billing amount.
SELECT p.name, b.total_amount
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#132.Show patient name with treatment.
select p.name ,b.treatment
from patients p
join billing b
on p.patient_id=b.patient_id;

#133.Show patient name with doctor fee.
select p.name,b.doctor_fee
from patients p
join billing b
on p.patient_id=b.patient_id;

#134.Show patient name with medicine cost.
select p.name ,b.medicine_cost
from patients p
join billing b
on p.patient_id=b.patient_id;

#135.Show patient name with payment status.
select p.name,b.payment_status
from patients p
join billing b
on p.patient_id=b.patient_id;

#136.Show patient name, disease, and treatment.
select p.name,p.disease,b.treatment
from patients p
join billing b
on p.patient_id=b.patient_id;

#137.Show patient name, age, and billing amount.
select p.name,p.age,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id;

#138.Show patient name with admission date and bill.
select p.name,p.admission_date,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id;

#139.Show patients with pending payments.
select p.name ,b.payment_status
from patients p
join billing b
on p.patient_id=b.patient_id
where b.payment_status="pending";

#140.Show patients with paid bills.
select p.name ,b.payment_status
from patients p
join billing b
on p.patient_id=b.patient_id
where b.payment_status="paid";

#141.Find patients whose bill exceeds 1000.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id
where b.total_amount>100;

#142.Find patients whose bill is below 800.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id
where b.total_amount<800;

#143.Find patients with highest billing.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id
order by b.total_amount desc
limit 1;

#144.Find patients with lowest billing.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id
order by b.total_amount asc
limit 1;

#145.Find patients with billing above hospital average.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id
where b.total_amount>(select avg(b.total_amount) from billing);

#146.Find diseases generating highest revenue.
select p.disease,sum(b.total_amount) as total_revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease
order by total_revenue desc
limit 1;

#147.Find diseases generating lowest revenue.
select p.disease,sum(b.total_amount) as total_revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease
order by total_revenue asc
limit 1;

#148.Find revenue per disease.
select p.disease , sum(b.total_amount) as disease_revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease;

#149.Find average billing per disease.
select p.disease,avg(b.total_amount) as avg_billing
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease;

#150.Find maximum billing per disease.
select p.disease,max(b.total_amount) as max_billing
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease;

#151.Find minimum billing per disease.
select p.disease,min(b.total_amount) as min_billing
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease;

#152.Find diseases with most treatments.
select p.disease,count(b.treatment) as treatment_count
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease
order by treatment_count desc
limit 1;

#153.Find diseases with least treatments.
select p.disease,count(b.treatment) as treatment_count
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease
order by treatment_count 
limit 1;

#154.Find patients treated for heart issues.
select p.name,p.disease
from patients p
where p.disease like "%heart%";

 select name,disease from patients where disease like "%heart%";
 
#155.Find patients treated for fever.
select p.name,p.disease
from patients p
where p.disease like "%fever%";

 select name,disease from patients where disease like "%fever%";
 
#156.Find female patients with pending bills.
select p.name,p.gender ,b.payment_status
from patients p
join billing b
on p.patient_id=b.patient_id
where p.gender="female" and b.payment_status="pending";

#157.Find male patients with paid bills.
select p.name,p.gender ,b.payment_status
from patients p
join billing b
on p.patient_id=b.patient_id
where p.gender="male" and b.payment_status="paid";

#158.Find total billing per patient name.
select p.name,sum(total_amount) as total_billing
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.name;

#159.Find patient with maximum medicine cost.
SELECT p.name, MAX(b.medicine_cost) AS max_medicine_cost
FROM patients p
JOIN billing b 
ON p.patient_id = b.patient_id
group by p.name;

#160.Find patient with maximum doctor fee.
SELECT p.name, Min(b.doctor_fee) AS min_doc_cost
FROM patients p
JOIN billing b 
ON p.patient_id = b.patient_id
group by p.name;

#161.Find patient spending most money.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id
order by b.total_amount desc
limit 1;

#162.Find patient spending least money.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id
order by b.total_amount asc
limit 1;

#163.Find patients with multiple treatments.
select p.name,count(b.treatment) as treatment_count
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.name
having count(b.treatment)>1;

#164.Find treatments used by multiple diseases.
select b.treatment,count(distinct p.disease) as disease_count
from patients p
join billing b
on p.patient_id=b.patient_id
group by b.treatment
having count(distinct p.disease)>1;

#165.Find treatments used by single disease.
select b.treatment,count(distinct p.disease) as disease_count
from patients p
join billing b
on p.patient_id=b.patient_id
group by b.treatment
having count(distinct p.disease)=1;

#166.Find patients admitted in January with bills above 1000.
select p.name,b.total_amount,p.admission_date
from patients p
join billing b
on p.patient_id=b.patient_id
where month(p.admission_date)=1 and b.total_amount>1000;

#167.Find patients admitted in February with bills below 800.
select p.name,b.total_amount,p.admission_date
from patients p
join billing b
on p.patient_id=b.patient_id
where month(p.admission_date)=2 and b.total_amount<800;

#168.Find patients whose disease matches treatment keyword.
select p.name,p.disease,b.treatment
from patients p
join billing b
on p.patient_id=b.patient_id
where b.treatment like concat ('%',p.disease,'%');

#169.Find patients whose disease differs from treatment keyword.
select p.name,p.disease,b.treatment
from patients p
join billing b
on p.patient_id=b.patient_id
where b.treatment not like concat ('%',p.disease,'%');

#170.Find patient generating highest revenue.
select p.name,sum(b.total_amount) as revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.name
order by revenue desc
limit 1;

#171.Rank patients by billing.
select p.name,b.total_amount,rank()
over (order by b.total_amount desc) as billing_rank
from patients p
join billing b
on p.patient_id=b.patient_id;

#172.Rank patients by medicine cost.
select p.name,b.medicine_cost,rank()
over (order by b.medicine_cost desc) as billing_rank
from patients p
join billing b
on p.patient_id=b.patient_id;

#173.Rank patients by doctor fee.
select p.name,b.doctor_fee,rank()
over (order by b.doctor_fee desc) as billing_rank
from patients p
join billing b
on p.patient_id=b.patient_id;

#174.Rank patients within each disease by billing.
select p.name,p.disease,b.total_amount,rank()
over (partition by p.disease order by b.total_amount desc) as rank_no
from patients p
join billing b
on p.patient_id=b.patient_id;

#175.Rank patients within each treatment by billing.
select p.name,b.treatment,b.total_amount,rank()
over (partition by b.treatment order by b.total_amount desc) as rank_no
from patients p
join billing b
on p.patient_id=b.patient_id;

#176.Find highest billing patient per disease.
SELECT *
FROM(
SELECT p.name,p.disease,b.total_amount,
ROW_NUMBER() OVER(PARTITION BY p.disease ORDER BY b.total_amount DESC) rn
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id
) t
WHERE rn=1;

#177.Find lowest billing patient per disease.
SELECT *
FROM(
SELECT p.name,p.disease,b.total_amount,
ROW_NUMBER() OVER(PARTITION BY p.disease ORDER BY b.total_amount asc ) rn
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id
) t
WHERE rn=1;

#178.Find second highest billing patient per disease.
SELECT *
FROM(
SELECT p.name,p.disease,b.total_amount,
ROW_NUMBER() OVER(PARTITION BY p.disease ORDER BY b.total_amount DESC) rn
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id
) t
WHERE rn=2;

#179.Calculate revenue share per patient.
select p.name,b.total_amount,b.total_amount/sum(b.total_amount)
over() * 100 as revenue_share
from patients p
join billing b
on p.patient_id=b.patient_id;

SELECT p.name,
SUM(b.total_amount) AS revenue,
SUM(b.total_amount) /
SUM(SUM(b.total_amount)) OVER() *100 AS share
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id
GROUP BY p.name;

#180.Calculate revenue share per disease.
SELECT p.disease,
SUM(b.total_amount) AS revenue,
SUM(b.total_amount) /
SUM(SUM(b.total_amount)) OVER() *100 AS share
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id
GROUP BY p.disease;

#181.Find cumulative revenue by patient admission date.
SELECT p.admission_date,
SUM(b.total_amount) OVER(ORDER BY p.admission_date) AS cumulative_revenue
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id;

#182.Find cumulative billing by disease.
SELECT p.disease,
SUM(b.total_amount) OVER(ORDER BY p.admission_date) AS cumulative_revenue
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id;

#183.Find running total per patient.
SELECT p.name,
       b.bill_id,
       b.total_amount,
       SUM(b.total_amount) OVER(
           PARTITION BY p.patient_id
           ORDER BY b.bill_id
       ) AS running_total
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#184.Find billing difference from disease average.
SELECT p.name,
       p.disease,
       b.total_amount,
       b.total_amount - AVG(b.total_amount) OVER(PARTITION BY p.disease) AS billing_diff
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#185.Find billing difference from hospital average.
SELECT p.name,
       p.disease,
       b.total_amount,
       b.total_amount - AVG(b.total_amount) OVER() AS hospital_avg
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#186.Find treatments whose revenue exceeds disease average revenue.
select b.treatment ,sum(b.total_amount) as revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by b.treatment,p.disease
having sum(b.total_amount)>
(select avg(total_amount)
from billing);

#187.Find patients whose billing exceeds disease average billing.
select p.name ,b.total_amount,p.disease
from patients p
join billing b
on p.patient_id=b.patient_id
where b.total_amount>
(select avg(b2.total_amount)
from patients p2
join billing b2
on p2.patient_id=b2.patient_id
where p2.disease=p.disease);

#188.Find diseases whose revenue exceeds hospital average revenue.
select disease ,sum(b.total_amount) as revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by disease
having sum(b.total_amount)>
(select avg(total_amount)
from billing);

#189.Find patients whose billing equals second highest bill.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id
where(
select distinct total_amount
from billing 
order by total_amount desc
limit 1 offset 1);

#190.Find patients whose billing equals third highest bill.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id=b.patient_id
where(
select distinct total_amount
from billing 
order by total_amount desc
limit 1 offset 2);

#191.Find diseases with revenue above 2000.
select p.disease, sum(total_amount) as revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease
having sum(b.total_amount)>2000;

#192.Find diseases with revenue below 1000.
select p.disease, sum(total_amount) as revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease
having sum(b.total_amount)<1000;

#193.Find diseases generating more than average revenue.
select p.disease,sum(b.total_amount) as revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease
having sum(b.total_amount)>
(select avg(total_amount) from billing);

#194.Find patients generating more than average revenue.
select p.name,sum(b.total_amount) as revenue
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.name
having sum(b.total_amount)>
(select avg(total_amount) from billing);

#195.Find treatments generating more than average revenue.
select b.treatment,sum(b.total_amount) as revenue
from billing b
group by b.treatment
having sum(b.total_amount)>
(select avg(total_amount) from billing);

select treatment, sum(total_amount) as revenue
from billing 
group by treatment
having sum(total_amount)>(select avg(total_amount) from billing);

#196.Find cumulative treatment revenue.
select treatment ,sum(total_amount) over (order by treatment) as cummulative_revenue
from billing ;

#197.Find running average billing per treatment.
select treatment,bill_id,avg(total_amount) over(partition by treatment order by bill_id)
as running_avg
from billing ;

#198.Find patients contributing top 20% revenue.
SELECT *
FROM
(
SELECT p.name,
SUM(b.total_amount) AS revenue,
PERCENT_RANK() OVER(ORDER BY SUM(b.total_amount) DESC) AS pr
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.name
) t
WHERE pr <= 0.2;

#199.Find patients contributing bottom 20% revenue.
SELECT *
FROM
(
SELECT p.name,
SUM(b.total_amount) AS revenue,
PERCENT_RANK() OVER(ORDER BY SUM(b.total_amount) ) AS pr
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.name
) t
WHERE pr <= 0.2;

#200.Rank diseases based on revenue.
select p.disease ,sum(b.total_amount) as revenue,
rank() over(order by sum(b.total_amount)desc) as rank_no
from patients p
join billing b
on p.patient_id=b.patient_id
group by p.disease;

#section 4


#201.Find diseases with more than two patients.
select disease,count(patient_id) as patient_count
from patients
group by disease
having count(patient_id)>2;

#202.Find treatments generating revenue above 2000.
select treatment , sum(total_amount) as revenue
from billing
group by treatment
having sum(total_amount)>2000;

#203.Find diseases where average billing exceeds hospital average.
SELECT p.disease, AVG(b.total_amount) AS avg_bill
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease
HAVING AVG(b.total_amount) >
(
    SELECT AVG(total_amount)
    FROM billing
);

#204.Find treatments with billing count above average billing count.
select treatment,count(*) as billing_count
from billing 
group by treatment
having count(*)>
(select avg(cnt)
from(
select count(*) as cnt
from billing
group by treatment)as t);

#205.Find diseases with highest patient count.
select disease,count(*) as patient_count
from patients
group by disease
order by patient_count desc
limit 1;

#206.Find diseases with lowest patient count.
select disease ,count(*) as patient_count
from patients
group by disease
order by patient_count asc
limit 1;

#207.Find treatments with highest revenue.
select treatment,sum(total_amount) as revenue
from billing
group by treatment
order by revenue desc
limit 1;

#208.Find treatments with lowest revenue.
select treatment,sum(total_amount) as revenue
from billing
group by treatment
order by revenue desc
limit 1;

#209.Find patients with billing greater than average billing.
select p.name,b.total_amount
from patients p
join billing b
on p.patient_id = b.patient_id
where b.total_amount>
(select avg(total_amount)
from billing);

#210.Find patients with billing equal to maximum billing.
SELECT p.name, b.total_amount
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
WHERE b.total_amount =
(
SELECT MAX(total_amount)
FROM billing
);

#211.Find patients with billing equal to minimum billing.
SELECT p.name, b.total_amount
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
WHERE b.total_amount =
(
SELECT MIN(total_amount)
FROM billing
);

#212.Find diseases whose revenue equals maximum disease revenue.
SELECT disease, SUM(total_amount) AS revenue
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY disease
HAVING SUM(total_amount) =
(
SELECT MAX(rev)
FROM
(
SELECT SUM(total_amount) AS rev
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY disease
) t
);

#123.Find diseases whose revenue equals minimum disease revenue.
SELECT disease, SUM(total_amount) AS revenue
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY disease
HAVING SUM(total_amount) =
(
SELECT MIN(rev)
FROM
(
SELECT SUM(total_amount) AS rev
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY disease
) t
);

#214.Find treatments whose revenue equals maximum treatment revenue.
SELECT treatment, SUM(total_amount) AS revenue
FROM billing
GROUP BY treatment
HAVING SUM(total_amount) =
(
SELECT MAX(rev)
FROM
(
SELECT SUM(total_amount) AS rev
FROM billing
GROUP BY treatment
) t
);

#215.Find treatments whose revenue equals minimum treatment revenue.
SELECT treatment, SUM(total_amount) AS revenue
FROM billing
GROUP BY treatment
HAVING SUM(total_amount) =
(
SELECT Min(rev)
FROM
(
SELECT SUM(total_amount) AS rev
FROM billing
GROUP BY treatment
) t
);

#216.Rank patients by billing amount.
select p.name,b.total_amount,rank() 
over (order by b.total_amount desc) as rank_no
from patients p
join billing b
on p.patient_id=b.patient_id;

#217.Rank patients by doctor fee.
select p.name,b.doctor_fee,rank() 
over (order by b.doctor_fee desc) as rank_no
from patients p
join billing b
on p.patient_id=b.patient_id;

#218.Rank patients by medicine cost.
select p.name,b.medicine_cost,rank() 
over (order by b.medicine_cost desc) as rank_no
from patients p
join billing b
on p.patient_id=b.patient_id;

#219.Rank diseases by revenue.
SELECT p.disease,
SUM(b.total_amount) AS revenue,
RANK() OVER(ORDER BY SUM(b.total_amount) DESC) AS rank_no
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease;



#220.Rank treatments by revenue.
SELECT treatment,
SUM(total_amount) AS revenue,
RANK() OVER(ORDER BY SUM(total_amount) DESC) AS rank_no
FROM billing
GROUP BY treatment;

#221.Find top patient per disease using ROW_NUMBER().
select * from (select p.name ,p.disease,b.total_amount,row_number() over
(partition by p.disease order by b.total_amount desc) as rn
from patients p
join billing b
on p.patient_id=b.patient_id) t
where rn=1;

#222.Find top treatment per disease using RANK().
SELECT *
FROM
(
SELECT p.disease,
       b.treatment,
       SUM(b.total_amount) AS revenue,
       RANK() OVER(
           PARTITION BY p.disease
           ORDER BY SUM(b.total_amount) DESC
       ) AS rnk
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease, b.treatment
) t
WHERE rnk = 1;

#223.Find second highest bill per disease.
select * from (select p.name,p.disease,b.total_amount,row_number()
over(partition by p.disease order by b.total_amount desc)as rn
from patients p
join billing b
on p.patient_id=b.patient_id) t
where rn=2;

#224.Find third highest bill per disease.
select * from (select p.name,p.disease,b.total_amount,row_number()
over(partition by p.disease order by b.total_amount desc)as rn
from patients p
join billing b
on p.patient_id=b.patient_id) t
where rn=3;

#225.Calculate running revenue.
select bill_id,total_amount,sum(total_amount)
 over(order by bill_id) as running_revenue
from billing;

#226.Calculate cumulative revenue by treatment.
select treatment,bill_id,total_amount,sum(total_amount) 
over(partition by treatment order by bill_id) as cumulative_revenue
from billing;

#227.Calculate cumulative revenue by disease.
select p.disease,b.bill_id,b.total_amount,sum(b.total_amount)
over(partition by treatment order by bill_id) as cummulative_revenue
from patients p
join billing b
on p.patient_id=b.patient_id;

#228.Find billing difference from average billing.
SELECT p.name,
       b.total_amount,
       b.total_amount - AVG(b.total_amount) OVER() AS billing_difference
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#229.Find billing difference from disease average.
SELECT p.name,
       p.disease,
       b.total_amount,
       b.total_amount - AVG(b.total_amount) OVER(PARTITION BY p.disease) AS disease_avg_diff
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#230.Calculate billing percentage contribution.
SELECT p.name,
       b.total_amount,
       (b.total_amount * 100.0) /
       SUM(b.total_amount) OVER() AS billing_percentage
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#231.Calculate percentage revenue per disease.
SELECT p.disease,
       SUM(b.total_amount) AS revenue,
       (SUM(b.total_amount) * 100.0) /
       SUM(SUM(b.total_amount)) OVER() AS percentage_revenue
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease;

#232.Calculate percentage revenue per treatment.
SELECT treatment,
       SUM(total_amount) AS revenue,
       (SUM(total_amount) * 100.0) /
       SUM(SUM(total_amount)) OVER() AS percentage_revenue
FROM billing
GROUP BY treatment;

#233.Find patients contributing highest revenue share.
SELECT *
FROM
(
SELECT p.name,
       SUM(b.total_amount) AS revenue,
       RANK() OVER(ORDER BY SUM(b.total_amount) DESC) AS rnk
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.name
) t
WHERE rnk = 1;

#234.Find treatments contributing highest revenue share.
SELECT *
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       RANK() OVER(ORDER BY SUM(total_amount) DESC) AS rnk
FROM billing
GROUP BY treatment
) t
WHERE rnk = 1;

#235.Find diseases contributing highest revenue share.
SELECT p.name,
       p.disease,
       b.total_amount
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
WHERE b.total_amount >
(
SELECT AVG(b2.total_amount)
FROM patients p2
JOIN billing b2
ON p2.patient_id = b2.patient_id
WHERE p2.disease = p.disease
);

#236.Find patients above disease average billing.
SELECT p.name,
       p.disease,
       b.total_amount
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
WHERE b.total_amount <
(
SELECT AVG(b2.total_amount)
FROM patients p2
JOIN billing b2
ON p2.patient_id = b2.patient_id
WHERE p2.disease = p.disease
);

#237.Find patients below disease average billing.
SELECT p.name,
       p.disease,
       b.total_amount
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
WHERE b.total_amount <
(
SELECT AVG(b2.total_amount)
FROM patients p2
JOIN billing b2
ON p2.patient_id = b2.patient_id
WHERE p2.disease = p.disease
);

#238.Find treatments above hospital average revenue.
SELECT treatment, SUM(total_amount) AS revenue
FROM billing
GROUP BY treatment
HAVING SUM(total_amount) >
(
SELECT AVG(total_amount)
FROM billing
);

#239.Find diseases above hospital average revenue.
SELECT p.disease, SUM(b.total_amount) AS revenue
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease
HAVING SUM(b.total_amount) >
(
SELECT AVG(total_amount)
FROM billing
);

#240.Find patients whose billing exceeds treatment average.
SELECT p.name,
       b.treatment,
       b.total_amount
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
WHERE b.total_amount >
(
SELECT AVG(b2.total_amount)
FROM billing b2
WHERE b2.treatment = b.treatment
);

#241.Find patients whose billing is below treatment average.
SELECT p.name,
       b.treatment,
       b.total_amount
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
WHERE b.total_amount <
(
SELECT AVG(b2.total_amount)
FROM billing b2
WHERE b2.treatment = b.treatment
);

#242.Find diseases whose billing count exceeds hospital average billing count.
SELECT p.disease, COUNT(b.bill_id) AS billing_count
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease
HAVING COUNT(b.bill_id) >
(
SELECT AVG(cnt)
FROM
(
SELECT COUNT(*) AS cnt
FROM billing
GROUP BY patient_id
) t
);

#243.Find treatments whose billing count exceeds hospital average billing count.
SELECT treatment, COUNT(*) AS billing_count
FROM billing
GROUP BY treatment
HAVING COUNT(*) >
(
SELECT AVG(cnt)
FROM
(
SELECT COUNT(*) AS cnt
FROM billing
GROUP BY treatment
) t
);

#244.Find diseases whose revenue exceeds treatment revenue of Fever.
SELECT p.disease, SUM(b.total_amount) AS revenue
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease
HAVING SUM(b.total_amount) >
(
SELECT SUM(total_amount)
FROM billing
WHERE treatment = 'Fever'
);

#245.Find treatments whose revenue exceeds treatment revenue of Cold.
SELECT treatment, SUM(total_amount) AS revenue
FROM billing
GROUP BY treatment
HAVING SUM(total_amount) >
(
SELECT SUM(total_amount)
FROM billing
WHERE treatment = 'Cold'
);

#246.Find diseases with patient count greater than median count.
SELECT disease, COUNT(*) AS patient_count
FROM patients
GROUP BY disease
HAVING COUNT(*) >
(
SELECT AVG(cnt)
FROM
(
SELECT COUNT(*) AS cnt
FROM patients
GROUP BY disease
) t
);

#247.Find treatments with revenue greater than median revenue.
SELECT treatment, revenue
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       NTILE(2) OVER(ORDER BY SUM(total_amount)) AS grp
FROM billing
GROUP BY treatment
) t
WHERE grp = 2;

#248.Rank treatments within diseases.
SELECT p.disease,
       b.treatment,
       SUM(b.total_amount) AS revenue,
       RANK() OVER(
           PARTITION BY p.disease
           ORDER BY SUM(b.total_amount) DESC
       ) AS rank_no
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease, b.treatment;

#249.Rank patients within diseases.
SELECT p.name,
       p.disease,
       b.total_amount,
       RANK() OVER(
           PARTITION BY p.disease
           ORDER BY b.total_amount DESC
       ) AS rank_no
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#250.Rank diseases within gender.
SELECT gender,
       disease,
       COUNT(*) AS patient_count,
       RANK() OVER(
           PARTITION BY gender
           ORDER BY COUNT(*) DESC
       ) AS rank_no
FROM patients
GROUP BY gender, disease;

#251.Find cumulative patient count per disease.
SELECT disease,
       COUNT(*) AS patient_count,
       SUM(COUNT(*)) OVER(
           ORDER BY disease
       ) AS cumulative_count
FROM patients
GROUP BY disease;

#252.Find cumulative billing per disease.
SELECT p.disease,
       SUM(b.total_amount) AS revenue,
       SUM(SUM(b.total_amount)) OVER(
           ORDER BY p.disease
       ) AS cumulative_revenue
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease;

#253.Find cumulative billing per treatment.
SELECT treatment,
       SUM(total_amount) AS revenue,
       SUM(SUM(total_amount)) OVER(
           ORDER BY treatment
       ) AS cumulative_revenue
FROM billing
GROUP BY treatment;

#254.Find running average billing.
SELECT bill_id,
       total_amount,
       AVG(total_amount) OVER(
           ORDER BY bill_id
       ) AS running_avg
FROM billing;

#255.Find running average medicine cost.
SELECT bill_id,
       medicine_cost,
       AVG(medicine_cost) OVER(ORDER BY bill_id) AS running_avg_medicine
FROM billing;

#256.Find running average doctor fee.
SELECT bill_id,
       doctor_fee,
       AVG(doctor_fee) OVER(ORDER BY bill_id) AS running_avg_doctor_fee
FROM billing;

#257.Find patients whose billing exceeds running average.
SELECT *
FROM
(
SELECT p.name,
       b.bill_id,
       b.total_amount,
       AVG(b.total_amount) OVER(ORDER BY b.bill_id) AS running_avg
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
) t
WHERE total_amount > running_avg;

#258.Find treatments whose revenue exceeds running average.
SELECT *
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       AVG(SUM(total_amount)) OVER(ORDER BY treatment) AS running_avg
FROM billing
GROUP BY treatment
) t
WHERE revenue > running_avg;

#259.Find diseases whose revenue exceeds running average.
SELECT *
FROM
(
SELECT p.disease,
       SUM(b.total_amount) AS revenue,
       AVG(SUM(b.total_amount)) OVER(ORDER BY p.disease) AS running_avg
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease
) t
WHERE revenue > running_avg;

#260.Find revenue difference from previous billing.
SELECT bill_id,
       total_amount,
       total_amount - LAG(total_amount) OVER(ORDER BY bill_id) AS diff_prev
FROM billing;

#261.Find revenue difference from next billing.
SELECT bill_id,
       total_amount,
       LEAD(total_amount) OVER(ORDER BY bill_id) - total_amount AS diff_next
FROM billing;

#262.Find billing gap between consecutive bills.
SELECT bill_id,
       total_amount,
       total_amount - LAG(total_amount) OVER(ORDER BY bill_id) AS billing_gap
FROM billing;

#263.Find treatment revenue growth.
SELECT treatment,
       SUM(total_amount) AS revenue,
       SUM(total_amount) -
       LAG(SUM(total_amount)) OVER(ORDER BY treatment) AS growth
FROM billing
GROUP BY treatment;

#264.Find revenue change from previous treatment.
SELECT treatment,
       SUM(total_amount) AS revenue,
       SUM(total_amount) -
       LAG(SUM(total_amount)) OVER(ORDER BY treatment) AS revenue_change
FROM billing
GROUP BY treatment;

#265.Find patient billing growth.
SELECT p.name,
       b.total_amount,
       b.total_amount -
       LAG(b.total_amount) OVER(PARTITION BY p.name ORDER BY b.bill_id) AS growth
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#266.Find disease revenue growth.
SELECT p.disease,
       SUM(b.total_amount) AS revenue,
       SUM(b.total_amount) -
       LAG(SUM(b.total_amount)) OVER(ORDER BY p.disease) AS growth
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease;

#267.Find treatments with increasing revenue trend.
SELECT *
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       LAG(SUM(total_amount)) OVER(ORDER BY treatment) AS prev_rev
FROM billing
GROUP BY treatment
) t
WHERE revenue > prev_rev;

#268.Find treatments with decreasing revenue trend.
SELECT *
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       LAG(SUM(total_amount)) OVER(ORDER BY treatment) AS prev_rev
FROM billing
GROUP BY treatment
) t
WHERE revenue < prev_rev;

#269.Find patients with increasing billing trend.
SELECT *
FROM
(
SELECT p.name,
       b.bill_id,
       b.total_amount,
       LAG(b.total_amount) OVER(PARTITION BY p.name ORDER BY b.bill_id) AS prev_bill
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
) t
WHERE total_amount > prev_bill;

#270.Find patients with decreasing billing trend.
SELECT *
FROM
(
SELECT p.name,
       b.bill_id,
       b.total_amount,
       LAG(b.total_amount) OVER(PARTITION BY p.name ORDER BY b.bill_id) AS prev_bill
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
) t
WHERE total_amount < prev_bill;

#271.Find patients with revenue above 90th percentile.
SELECT *
FROM
(
SELECT p.name,
       SUM(b.total_amount) AS revenue,
       PERCENT_RANK() OVER(ORDER BY SUM(b.total_amount)) AS pr
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.name
) t
WHERE pr >= 0.9;

#272.Find running average doctor fee.
SELECT bill_id,
       doctor_fee,
       AVG(doctor_fee) OVER(ORDER BY bill_id) AS running_avg_doctor_fee
FROM billing;

#273.Find patients whose billing exceeds running average.
SELECT *
FROM
(
SELECT p.name,
       b.bill_id,
       b.total_amount,
       AVG(b.total_amount) OVER(ORDER BY b.bill_id) AS running_avg
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
) t
WHERE total_amount > running_avg;

#274.Find treatments whose revenue exceeds running average.
SELECT *
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       AVG(SUM(total_amount)) OVER(ORDER BY treatment) AS running_avg
FROM billing
GROUP BY treatment
) t
WHERE revenue > running_avg;

#275.Find diseases whose revenue exceeds running average.
SELECT *
FROM
(
SELECT p.disease,
       SUM(b.total_amount) AS revenue,
       AVG(SUM(b.total_amount)) OVER(ORDER BY p.disease) AS running_avg
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease
) t
WHERE revenue > running_avg;

#276.Find revenue difference from previous billing.
SELECT bill_id,
       total_amount,
       total_amount - LAG(total_amount) OVER(ORDER BY bill_id) AS revenue_diff
FROM billing;

#277.Find revenue difference from next billing.
SELECT bill_id,
       total_amount,
       LEAD(total_amount) OVER(ORDER BY bill_id) - total_amount AS revenue_diff
FROM billing;

#278.Find billing gap between consecutive bills.
SELECT bill_id,
       total_amount,
       total_amount - LAG(total_amount) OVER(ORDER BY bill_id) AS billing_gap
FROM billing;

#279.Find treatment revenue growth.
SELECT treatment,
       SUM(total_amount) AS revenue,
       SUM(total_amount) -
       LAG(SUM(total_amount)) OVER(ORDER BY treatment) AS growth
FROM billing
GROUP BY treatment;

#280.Find revenue change from previous treatment.
SELECT treatment,
       SUM(total_amount) AS revenue,
       SUM(total_amount) -
       LAG(SUM(total_amount)) OVER(ORDER BY treatment) AS revenue_change
FROM billing
GROUP BY treatment;

#281.Find patient billing growth.
SELECT p.name,
       b.total_amount,
       b.total_amount -
       LAG(b.total_amount) OVER(PARTITION BY p.name ORDER BY b.bill_id) AS growth
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id;

#282.Find disease revenue growth.
SELECT p.disease,
       SUM(b.total_amount) AS revenue,
       SUM(b.total_amount) -
       LAG(SUM(b.total_amount)) OVER(ORDER BY p.disease) AS growth
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease;

#283.Find treatments with increasing revenue trend.
SELECT *
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       LAG(SUM(total_amount)) OVER(ORDER BY treatment) AS prev_rev
FROM billing
GROUP BY treatment
) t
WHERE revenue > prev_rev;

#284.Find treatments with decreasing revenue trend.
SELECT *
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       LAG(SUM(total_amount)) OVER(ORDER BY treatment) AS prev_rev
FROM billing
GROUP BY treatment
) t
WHERE revenue < prev_rev;

#285.Find patients with increasing billing trend.
SELECT *
FROM
(
SELECT p.name,
       b.bill_id,
       b.total_amount,
       LAG(b.total_amount) OVER(PARTITION BY p.name ORDER BY b.bill_id) AS prev_bill
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
) t
WHERE total_amount > prev_bill;

#286.Find patients with decreasing billing trend.
SELECT *
FROM
(
SELECT p.name,
       b.bill_id,
       b.total_amount,
       LAG(b.total_amount) OVER(PARTITION BY p.name ORDER BY b.bill_id) AS prev_bill
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
) t
WHERE total_amount > prev_bill;

#287.Find patients with revenue above 90th percentile.
SELECT *
FROM
(
SELECT p.name,
       SUM(b.total_amount) AS revenue,
       PERCENT_RANK() OVER(ORDER BY SUM(b.total_amount)) AS pr
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.name
) t
WHERE pr >= 0.9;

#288.Find treatments above 90th percentile revenue.
SELECT *
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       PERCENT_RANK() OVER(ORDER BY SUM(total_amount)) AS pr
FROM billing
GROUP BY treatment
) t
WHERE pr >= 0.9;

#289.Find diseases above 90th percentile revenue.
SELECT *
FROM
(
SELECT p.disease,
       SUM(b.total_amount) AS revenue,
       PERCENT_RANK() OVER(ORDER BY SUM(b.total_amount)) AS pr
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease
) t
WHERE pr >= 0.9;

#290.Find patients below 10th percentile revenue.
SELECT *
FROM
(
SELECT p.name,
       SUM(b.total_amount) AS revenue,
       PERCENT_RANK() OVER(ORDER BY SUM(b.total_amount)) AS pr
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.name
) t
WHERE pr <= 0.1;

#291.Find treatments below 10th percentile revenue.
SELECT *
FROM
(
SELECT treatment,
       SUM(total_amount) AS revenue,
       PERCENT_RANK() OVER(ORDER BY SUM(total_amount)) AS pr
FROM billing
GROUP BY treatment
) t
WHERE pr <= 0.1;

#292.Find diseases below 10th percentile revenue.
SELECT *
FROM
(
SELECT p.disease,
       SUM(b.total_amount) AS revenue,
       PERCENT_RANK() OVER(ORDER BY SUM(b.total_amount)) AS pr
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
GROUP BY p.disease
) t
WHERE pr <= 0.1;

#293.Find median billing per treatment.
SELECT treatment,
AVG(total_amount) AS median_billing
FROM
(
SELECT treatment,
total_amount,
ROW_NUMBER() OVER(PARTITION BY treatment ORDER BY total_amount) rn,
COUNT(*) OVER(PARTITION BY treatment) cnt
FROM billing
) t
WHERE rn IN (FLOOR((cnt+1)/2), FLOOR((cnt+2)/2))
GROUP BY treatment;

#294.Find median billing per disease.
SELECT disease,
AVG(total_amount) AS median_billing
FROM
(
SELECT p.disease,
b.total_amount,
ROW_NUMBER() OVER(PARTITION BY p.disease ORDER BY b.total_amount) rn,
COUNT(*) OVER(PARTITION BY p.disease) cnt
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
) t
WHERE rn IN (FLOOR((cnt+1)/2), FLOOR((cnt+2)/2))
GROUP BY disease;

#295.Find median billing per patient.
SELECT name,
AVG(total_amount) AS median_billing
FROM
(
SELECT p.name,
b.total_amount,
ROW_NUMBER() OVER(PARTITION BY p.name ORDER BY b.total_amount) rn,
COUNT(*) OVER(PARTITION BY p.name) cnt
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
) t
WHERE rn IN (FLOOR((cnt+1)/2), FLOOR((cnt+2)/2))
GROUP BY name;


#296.Find median billing across hospital.
SELECT AVG(total_amount) AS hospital_median
FROM
(
SELECT total_amount,
ROW_NUMBER() OVER(ORDER BY total_amount) rn,
COUNT(*) OVER() cnt
FROM billing
) t
WHERE rn IN (FLOOR((cnt+1)/2), FLOOR((cnt+2)/2));

#297.Find treatments above median revenue.
SELECT treatment, SUM(total_amount) revenue
FROM billing
GROUP BY treatment
HAVING SUM(total_amount) >
(
SELECT AVG(total_amount) FROM billing
);

#298.Find diseases above median revenue.
SELECT p.disease, SUM(b.total_amount) revenue
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.disease
HAVING SUM(b.total_amount) >
(
SELECT AVG(total_amount) FROM billing
);

#299.Find patients above median billing.
SELECT p.name, b.total_amount
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
WHERE b.total_amount >
(
SELECT AVG(total_amount) FROM billing
);

#300.Find treatments below median revenue.
SELECT treatment, SUM(total_amount) revenue
FROM billing
GROUP BY treatment
HAVING SUM(total_amount) <
(
SELECT AVG(total_amount) FROM billing
);

-- Find diseases below median revenue.
SELECT p.disease, SUM(b.total_amount) revenue
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.disease
HAVING SUM(b.total_amount) <
(
SELECT AVG(total_amount) FROM billing
);

-- Find top 10% revenue generating treatments.
SELECT *
FROM
(
SELECT treatment,
SUM(total_amount) revenue,
NTILE(10) OVER(ORDER BY SUM(total_amount) DESC) percentile
FROM billing
GROUP BY treatment
) t
WHERE percentile=1;

-- Find top 10% revenue generating patients.
SELECT *
FROM
(
SELECT p.name,
SUM(b.total_amount) revenue,
NTILE(10) OVER(ORDER BY SUM(b.total_amount) DESC) percentile
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.name
) t
WHERE percentile=1;

-- Find top 10% revenue generating diseases.
SELECT *
FROM
(
SELECT p.disease,
SUM(b.total_amount) revenue,
NTILE(10) OVER(ORDER BY SUM(b.total_amount) DESC) percentile
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.disease
) t
WHERE percentile=1;

-- Find bottom 10% revenue generating treatments.
SELECT *
FROM
(
SELECT treatment,
SUM(total_amount) revenue,
NTILE(10) OVER(ORDER BY SUM(total_amount)) percentile
FROM billing
GROUP BY treatment
) t
WHERE percentile=1;

-- Find bottom 10% revenue generating patients.
SELECT *
FROM
(
SELECT p.name,
SUM(b.total_amount) revenue,
NTILE(10) OVER(ORDER BY SUM(b.total_amount)) percentile
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.name
) t
WHERE percentile=1;

-- Find bottom 10% revenue generating diseases.
SELECT *
FROM
(
SELECT p.disease,
SUM(b.total_amount) revenue,
NTILE(10) OVER(ORDER BY SUM(b.total_amount)) percentile
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.disease
) t
WHERE percentile=1;

-- Find patient revenue percentile rank.
SELECT p.name,
SUM(b.total_amount) revenue,
PERCENT_RANK() OVER(ORDER BY SUM(b.total_amount)) percentile_rank
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.name;

-- Find treatment revenue percentile rank.
SELECT treatment,
SUM(total_amount) revenue,
PERCENT_RANK() OVER(ORDER BY SUM(total_amount)) percentile_rank
FROM billing
GROUP BY treatment;

-- Find disease revenue percentile rank.
SELECT p.disease,
SUM(b.total_amount) revenue,
PERCENT_RANK() OVER(ORDER BY SUM(b.total_amount)) percentile_rank
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.disease;

-- Find revenue distribution.
SELECT total_amount,
NTILE(4) OVER(ORDER BY total_amount) distribution_group
FROM billing;

-- Find revenue quartiles.
SELECT total_amount,
NTILE(4) OVER(ORDER BY total_amount) quartile
FROM billing;

-- Find revenue variance across treatments.
SELECT treatment,
VARIANCE(SUM(total_amount)) OVER() variance_value
FROM billing
GROUP BY treatment;

-- Find revenue variance across diseases.
SELECT p.disease,
VARIANCE(SUM(b.total_amount)) OVER() variance_value
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.disease;

-- Find revenue variance across patients.
SELECT p.name,
VARIANCE(SUM(b.total_amount)) OVER() variance_value
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.name;

-- Find overall hospital revenue ranking.
SELECT p.name,
SUM(b.total_amount) revenue,
RANK() OVER(ORDER BY SUM(b.total_amount) DESC) hospital_rank
FROM patients p
JOIN billing b ON p.patient_id=b.patient_id
GROUP BY p.name;








