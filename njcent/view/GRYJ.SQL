create or replace view gryj as
select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",/*u."PAY",*/u."DIMISSION_DATE",mmzjxz.mmzjf as 买卖中介服务费新增,mmdkxz.mmdkf as 买卖贷款服务费新增,mmqtxz.mmqt as 买卖其他费用新增,zlzjxz.zlzjf as 租赁中介服务费新增,dlfwfxz.dlfwf as 代理中介服务费新增,mmzjjz.mmzjf as 买卖中介服务费结转,mmdkjz.mmdkf as 买卖贷款服务费结转,mmqtjz.mmqt as 买卖其他费用结转,zlzjjz.zlzjf as 租赁中介服务费结转,dlfwfjz.dlfwf as 代理中介服务费结转
from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房业务部%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date(to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd'),'yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM') <= to_char(VIEW_DATE.GET_DATE,'yyyy-MM') ))) u
 --买卖中介服务费新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) mmzjxz
  on u.user_id = mmzjxz.user_id
 --买卖贷款服务费新增
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) mmdkxz
 on u.user_id = mmdkxz.user_id
 --买卖其他费用新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) mmqtxz
 on u.user_id = mmqtxz.user_id
 --租赁中介服务费新增
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.user_id) zlzjxz
 on u.user_id = zlzjxz.user_id
  --代理中介服务费新增
 left join
 (select dlfee.user_id,sum(dlfee.price) dlfwf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.user_id) dlfwfxz
 on u.user_id = dlfwfxz.user_id
  --买卖中介服务费结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) mmzjjz
  on u.user_id = mmzjjz.user_id
 --买卖贷款服务费结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) mmdkjz
 on u.user_id = mmdkjz.user_id
 --买卖其他费用结转
  left join
 (select mmfee.user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) mmqtjz
 on u.user_id = mmqtjz.user_id
 --租赁中介服务费结转
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.user_id) zlzjjz
 on u.user_id = zlzjjz.user_id
  --代理中介服务费结转
 left join
 (select dlfee.user_id,sum(dlfee.price) dlfwf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.user_id) dlfwfjz
 on u.user_id = dlfwfjz.user_id
 --where   VIEW_DATE.SET_DATE('2018-10') = TO_DATE('2018-10','yyyy-MM')
 order by u.DAQUNAME,u.deptname,u.USERNAME;
