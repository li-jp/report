create or replace view qzyj as
select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",/*u."PAY",*/u."DIMISSION_DATE",
mmzjxz.mmzjf as 买卖中介服务费新增,mmdkxz.mmdkf as 买卖贷款服务费新增,mmqtxz.mmqt as 买卖其他费用新增,zlzjxz.zlzjf as 租赁中介服务费新增,dlfwfxz.dlfwf as 代理代理服务费新增,mmzjjz.mmzjf as 买卖中介服务费结转,mmdkjz.mmdkf as 买卖贷款服务费结转,mmqtjz.mmqt as 买卖其他费用结转,zlzjjz.zlzjf as 租赁中介服务费结转,dlfwfjz.dlfwf as 代理代理服务费结转,
qzmmzjxz.mmzjf as 区长买卖中介服务费新增,qzmmdkxz.mmdkf as 区长买卖贷款服务费新增,qzmmqtxz.mmqt as 区长买卖其他费用新增,qzzlzjxz.zlzjf as 区长租赁中介服务费新增,qzdlfwfxz.dlfwf as 区长代理代理服务费新增,qzmmzjjz.mmzjf as 区长买卖中介服务费结转,qzmmdkjz.mmdkf as 区长买卖贷款服务费结转,qzmmqtjz.mmqt as 区长买卖其他费用结转,qzzlzjjz.zlzjf as 区长租赁中介服务费结转,qzdlfwfjz.dlfwf as 区长代理代理服务费结转

from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房事业部%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date(to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd'),'yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM') <= to_char(VIEW_DATE.GET_DATE,'yyyy-MM') ))) u
 --买卖中介服务费新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmzjxz
  on u.user_id = mmzjxz.area_user_id
 --买卖贷款服务费新增
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmdkxz
 on u.user_id = mmdkxz.area_user_id
 --买卖其他费用新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmqtxz
 on u.user_id = mmqtxz.area_user_id
 --租赁中介服务费新增
 left join
 (select zlfee.area_user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.area_user_id) zlzjxz
 on u.user_id = zlzjxz.area_user_id
  --代理代理服务费新增
 left join
 (select dlfee.area_user_id,sum(dlfee.price) dlfwf from report_dl_fee_info dlfee  where dlfee.fee_name = '代理服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.area_user_id) dlfwfxz
 on u.user_id = dlfwfxz.area_user_id
  --买卖中介服务费结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmzjjz
  on u.user_id = mmzjjz.area_user_id
 --买卖贷款服务费结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmdkjz
 on u.user_id = mmdkjz.area_user_id
 --买卖其他费用结转
  left join
 (select mmfee.area_user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmqtjz
 on u.user_id = mmqtjz.area_user_id
 --租赁中介服务费结转
 left join
 (select zlfee.area_user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.area_user_id) zlzjjz
 on u.user_id = zlzjjz.area_user_id
  --代理代理服务费结转
 left join
 (select dlfee.area_user_id,sum(dlfee.price) dlfwf from report_dl_fee_info dlfee  where dlfee.fee_name = '代理服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.area_user_id) dlfwfjz
 on u.user_id = dlfwfjz.area_user_id
 
 --商圈经理个人业绩
 --买卖中介服务费新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) qzmmzjxz
  on u.user_id = qzmmzjxz.user_id
 --买卖贷款服务费新增
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) qzmmdkxz
 on u.user_id = qzmmdkxz.user_id
 --买卖其他费用新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) qzmmqtxz
 on u.user_id = qzmmqtxz.user_id
 --租赁中介服务费新增
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.user_id) qzzlzjxz
 on u.user_id = qzzlzjxz.user_id
  --代理代理服务费新增
 left join
 (select dlfee.user_id,sum(dlfee.price) dlfwf from report_dl_fee_info dlfee  where dlfee.fee_name = '代理服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.user_id) qzdlfwfxz
 on u.user_id = qzdlfwfxz.user_id
  --买卖中介服务费结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) qzmmzjjz
  on u.user_id = qzmmzjjz.user_id
 --买卖贷款服务费结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) qzmmdkjz
 on u.user_id = qzmmdkjz.user_id
 --买卖其他费用结转
  left join
 (select mmfee.user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) qzmmqtjz
 on u.user_id = qzmmqtjz.user_id
 --租赁中介服务费结转
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.user_id) qzzlzjjz
 on u.user_id = qzzlzjjz.user_id
  --代理代理服务费结转
 left join
 (select dlfee.user_id,sum(dlfee.price) dlfwf from report_dl_fee_info dlfee  where dlfee.fee_name = '代理服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.user_id) qzdlfwfjz
 on u.user_id = qzdlfwfjz.user_id
 where (u.job_name = '商圈经理'
        or mmzjxz.mmzjf  != 0
        or mmdkxz.mmdkf  != 0 
        or mmqtxz.mmqt   != 0 
        or zlzjxz.zlzjf  != 0 
        or dlfwfxz.dlfwf != 0 
        or mmzjjz.mmzjf  != 0 
        or mmdkjz.mmdkf  != 0 
        or mmqtjz.mmqt   != 0 
        or zlzjjz.zlzjf  != 0 
        or dlfwfjz.dlfwf != 0
		or qzmmzjxz.mmzjf  != 0
        or qzmmdkxz.mmdkf  != 0 
        or qzmmqtxz.mmqt   != 0 
        or qzzlzjxz.zlzjf  != 0 
        or qzdlfwfxz.dlfwf != 0 
        or qzmmzjjz.mmzjf  != 0 
        or qzmmdkjz.mmdkf  != 0 
        or qzmmqtjz.mmqt   != 0 
        or qzzlzjjz.zlzjf  != 0 
        or qzdlfwfjz.dlfwf != 0)
--and   VIEW_DATE.SET_DATE('2018-10') = TO_DATE('2018-10','yyyy-MM')
 order by u.DAQUNAME,u.deptname,u.USERNAME;
