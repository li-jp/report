create or replace view qzyj as
select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",/*u."PAY",*/u."DIMISSION_DATE",u.IF_NEWOROLD,
mmzjfwfxz.mmzjfwf as 买卖中介服务费新增, mmmfzjfxz.mmmfzjf as 买卖卖方中介费新增, mmdkfwfxz.mmdkfwf as 买卖贷款服务费新增, mmpgfsrxz.mmpgfsr as 买卖评估费收入新增, mmdbghfxz.mmdbghf as 买卖代办过户费新增,mmdzfwfxz.mmdzfwf as 买卖垫资服务费新增, mmqtfyxz.mmqtfy as 买卖其他费用新增,zlzjfwfxz.zlzjfwf as 租赁中介服务费新增,
mmzjfwfjz.mmzjfwf as 买卖中介服务费结转, mmmfzjfjz.mmmfzjf as 买卖卖方中介费结转, mmdkfwfjz.mmdkfwf as 买卖贷款服务费结转, mmpgfsrjz.mmpgfsr as 买卖评估费收入结转, mmdbghfjz.mmdbghf as 买卖代办过户费结转,mmdzfwfjz.mmdzfwf as 买卖垫资服务费结转, mmqtfyjz.mmqtfy as 买卖其他费用结转,zlzjfwfjz.zlzjfwf as 租赁中介服务费结转
from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%区%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date(to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd'),'yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM-dd') <= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') ))) u
 --买卖中介服务费新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmzjfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmzjfwfxz
  on u.user_id = mmzjfwfxz.area_user_id
 --买卖卖方中介费新增
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmmfzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '卖方中介费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmmfzjfxz
 on u.user_id = mmmfzjfxz.area_user_id
  --买卖贷款服务费新增
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmdkfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmdkfwfxz
 on u.user_id = mmdkfwfxz.area_user_id
 --买卖评估费收入新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmpgfsr from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费收入' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmpgfsrxz
 on u.user_id = mmpgfsrxz.area_user_id
  --买卖代办过户费新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmdbghfxz
 on u.user_id = mmdbghfxz.area_user_id
   --买卖垫资服务费新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmdzfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '垫资服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmdzfwfxz
 on u.user_id = mmdzfwfxz.area_user_id
 --买卖其他费用新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmqtfy from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmqtfyxz
 on u.user_id = mmqtfyxz.area_user_id
 --租赁中介服务费新增
 left join
 (select zlfee.area_user_id,sum(zlfee.price) zlzjfwf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.area_user_id) zlzjfwfxz
 on u.user_id = zlzjfwfxz.area_user_id
  --买卖中介服务费结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmzjfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmzjfwfjz
  on u.user_id = mmzjfwfjz.area_user_id
  --买卖卖方中介费结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmmfzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '卖方中介费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmmfzjfjz
  on u.user_id = mmmfzjfjz.area_user_id
 --买卖贷款服务费结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmdkfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmdkfwfjz
 on u.user_id = mmdkfwfjz.area_user_id
 --买卖评估费收入结转
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmpgfsr from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费收入' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmpgfsrjz
 on u.user_id = mmpgfsrjz.area_user_id
  --买卖代办过户费结转
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmdbghfjz
 on u.user_id = mmdbghfjz.area_user_id
   --买卖垫资服务费结转
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmdzfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '垫资服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmdzfwfjz
 on u.user_id = mmdzfwfjz.area_user_id
 --买卖其他费用结转
  left join
 (select mmfee.area_user_id,sum(mmfee.price) mmqtfy from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmqtfyjz
 on u.user_id = mmqtfyjz.area_user_id
 --租赁中介服务费结转
 left join
 (select zlfee.area_user_id,sum(zlfee.price) zlzjfwf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.area_user_id) zlzjfwfjz
 on u.user_id = zlzjfwfjz.area_user_id
 where u.deptname like '%%'
 --and   VIEW_DATE.SET_DATE('2018-10') = TO_DATE('2018-10','yyyy-MM')
 and   (u.job_name = '营业经理'
        or  mmzjfwfxz.mmzjfwf != 0
        or  mmmfzjfxz.mmmfzjf != 0
        or  mmdkfwfxz.mmdkfwf != 0
        or  mmpgfsrxz.mmpgfsr != 0
        or  mmdbghfxz.mmdbghf != 0
        or  mmdzfwfxz.mmdzfwf != 0
        or  mmqtfyxz.mmqtfy   != 0
        or  zlzjfwfxz.zlzjfwf != 0
        or  mmzjfwfjz.mmzjfwf != 0
        or  mmmfzjfjz.mmmfzjf != 0
        or  mmdkfwfjz.mmdkfwf != 0
        or  mmpgfsrjz.mmpgfsr != 0
        or  mmdbghfjz.mmdbghf != 0
        or  mmdzfwfjz.mmdzfwf != 0
        or  mmqtfyjz.mmqtfy   != 0
        or  zlzjfwfjz.zlzjfwf != 0)
 order by u.nameall,u.deptname;
