create or replace view report_user_dept_info as
select u.id user_id,u.username, job.name job_name,u.status,u.induction_time,  u.star_level,d.id dept_id,d.name deptname,d.nameall,p.name daquname,p.id pianqu_id,/*pay.pay, */to_date(to_char(u.Dimission_Date,'yyyy-mm-dd'),'yyyy-mm-dd') Dimission_Date from
 sys_user u
left join sys_department d on u.dept_id = d.id

left join sys_pianqu p on p.ID = d.pianqu_id
left join sys_job job on u.job_id = job.id
--left join sys_base_pay pay on pay.job_name = job.name and pay.star_level = u.star_level
where u.is_rec =0;
