create or replace view qzyj as
select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",/*u."PAY",*/u."DIMISSION_DATE",
mmzjxz.mmzjf as 买卖中介服务费_已收_新增, mmzjjlxz.mmzjf as 买卖中介服务费_结利_新增, mmdbghxz.mmdbghf as 买卖代办过户费_已收_新增,mmdbghjlxz.mmdbghf as 买卖代办过户费_结利_新增,
mmdkxz.mmdkf as 买卖贷款服务费新增,mmpgxz.mmpgf as 买卖评估费提成新增,mmqtxz.mmqt as 买卖其他费用新增,
zlzjxz.zlzjf as 租赁中介服务费新增,zlqtxz.zlqt as 租赁其他费用新增,
dlzjxz.dlzjf as 代理中介服务费新增,
mmzjjz.mmzjf as 买卖中介服务费_已收_结转,mmzjjljz.mmzjf as 买卖中介服务费_结利_结转, mmdbghjz.mmdbghf as 买卖代办过户费_已收_结转,mmdbghjljz.mmdbghf as 买卖代办过户费_结利_结转,
mmdkjz.mmdkf as 买卖贷款服务费结转,mmpgjz.mmpgf as 买卖评估费提成结转,mmqtjz.mmqt as 买卖其他费用结转,
zlzjjz.zlzjf as 租赁中介服务费结转,zlqtjz.zlqt as 租赁其他费用结转,
dlzjjz.dlzjf as 代理中介服务费结转
from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房事业部%' or usr.username ='不算个人业绩' or usr.nameall = '联动营业部') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date(to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd'),'yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM') <= to_char(VIEW_DATE.GET_DATE,'yyyy-MM') ))) u
 --买卖中介服务费(已收)新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmzjxz
  on u.user_id = mmzjxz.area_user_id
 --买卖中介服务费(结利)新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.trloan_end,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.trloan_end,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmzjjlxz
  on u.user_id = mmzjjlxz.area_user_id
   --买卖代办过户费(已收)新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmdbghxz
  on u.user_id = mmdbghxz.area_user_id
 --买卖代办过户费(结利)新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.trloan_end,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.trloan_end,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmdbghjlxz
  on u.user_id = mmdbghjlxz.area_user_id
 --买卖贷款服务费新增
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmdkxz
 on u.user_id = mmdkxz.area_user_id
 --买卖评估费新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmpgxz
 on u.user_id = mmpgxz.area_user_id
 --买卖其他费用新增
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.area_user_id) mmqtxz
 on u.user_id = mmqtxz.area_user_id
 --租赁中介服务费新增
 left join
 (select zlfee.area_user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.area_user_id) zlzjxz
 on u.user_id = zlzjxz.area_user_id
 --租赁其他费用新增
  left join
 (select zlfee.area_user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.area_user_id) zlqtxz
 on u.user_id = zlqtxz.area_user_id
  --代理中介服务费新增
  left join
 (select dlfee.area_user_id,sum(dlfee.price) dlzjf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.area_user_id) dlzjxz
 on u.user_id = dlzjxz.area_user_id
  --买卖中介服务费(已收)结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmzjjz
  on u.user_id = mmzjjz.area_user_id
  --买卖中介服务费(结利)结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.trloan_end,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and mmfee.price >= 0 group by mmfee.area_user_id) mmzjjljz
  on u.user_id = mmzjjljz.area_user_id
    --买卖代办过户费(已收)结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmdbghjz
  on u.user_id = mmdbghjz.area_user_id
  --买卖代办过户费(结利)结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.trloan_end,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and mmfee.price >= 0 group by mmfee.area_user_id) mmdbghjljz
  on u.user_id = mmdbghjljz.area_user_id
 --买卖贷款服务费结转
 left join
  (select mmfee.area_user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmdkjz
 on u.user_id = mmdkjz.area_user_id
 --买卖评估费结转
 left join
 (select mmfee.area_user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmpgjz
 on u.user_id = mmpgjz.area_user_id
 --买卖其他费用结转
  left join
 (select mmfee.area_user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.area_user_id) mmqtjz
 on u.user_id = mmqtjz.area_user_id
 --租赁中介服务费结转
 left join
 (select zlfee.area_user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.area_user_id) zlzjjz
 on u.user_id = zlzjjz.area_user_id
 --租赁其他费用结转
  left join
 (select zlfee.area_user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.area_user_id) zlqtjz
 on u.user_id = zlqtjz.area_user_id
   --代理中介服务费结转
  left join
 (select dlfee.area_user_id,sum(dlfee.price) dlzjf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.area_user_id) dlzjjz
 on u.user_id = dlzjjz.area_user_id
 where (u.job_name = '区域总监'
        or  mmzjxz.mmzjf       != 0
		or  mmzjjlxz.mmzjf     != 0
		or  mmdbghxz.mmdbghf   != 0
		or  mmdbghjlxz.mmdbghf != 0
        or  mmdkxz.mmdkf       != 0
		or  mmpgxz.mmpgf       != 0
		or  mmqtxz.mmqt        != 0
        or  zlzjxz.zlzjf       != 0
		or  zlqtxz.zlqt        != 0
        or  dlzjxz.dlzjf       != 0
        or  mmzjjz.mmzjf       != 0
		or  mmzjjljz.mmzjf     != 0
		or  mmdbghjz.mmdbghf   != 0
		or  mmdbghjljz.mmdbghf != 0
        or  mmdkjz.mmdkf       != 0
		or  mmpgjz.mmpgf       != 0
		or  mmqtjz.mmqt        != 0
        or  zlzjjz.zlzjf       != 0
		or  zlqtjz.zlqt        != 0
        or  dlzjjz.dlzjf       != 0)
 --and   VIEW_DATE.SET_DATE('2018-10') = TO_DATE('2018-10','yyyy-MM')
 order by u.DAQUNAME,u.deptname,u.USERNAME;
