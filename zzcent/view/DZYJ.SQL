CREATE OR REPLACE VIEW DZYJ AS
WITH JL AS (
  SELECT T.user_id, T.store_user_id, T.area_user_id, T.input_date, T.proportion, T.fee_name, T.rachel_date, T.review_date,T.Early_Profit_Date, T.reason, T.contract_code, T.handwriting_code, T.deal_date, T.trloan_end,
  CASE WHEN to_char(T.trloan_end,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd')
       THEN T.PRICE --过户日期小于等于记账月——结利100%
       WHEN (T.trloan_end is null or to_char(T.trloan_end,'yyyy-MM-dd') > to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd')) and to_char(T.Early_Profit_Date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd')
       THEN T.PRICE*0.5 --过户日期为空或者大于等于记账月，且结利日期小于等于记账月——提前结利50%
       WHEN (T.trloan_end is null or to_char(T.trloan_end,'yyyy-MM-dd') > to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd')) and (T.Early_Profit_Date is null or to_char(T.Early_Profit_Date,'yyyy-MM-dd') > to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd'))
       THEN 0 END PRICE --过户日期为空或者大于等于记账月，且结利日期为空或者大于等于记账月——不结利
  FROM REPORT_MM_FEE_INFO T
)
select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",/*u."PAY",*/u."DIMISSION_DATE",
mmzjxz.mmzjf as 买卖中介服务费_已收_新增, mmzjjlxz.mmzjf as 买卖中介服务费_结利_新增, mmdbghxz.mmdbghf as 买卖代办过户费_已收_新增,mmdbghjlxz.mmdbghf as 买卖代办过户费_结利_新增,
mmdkxz.mmdkf as 买卖贷款服务费新增,mmpgxz.mmpgf as 买卖评估费提成新增,mmqtxz.mmqt as 买卖其他费用新增,
zlzjxz.zlzjf as 租赁中介服务费新增,zlqtxz.zlqt as 租赁其他费用新增,
dlzjxz.dlzjf as 代理中介服务费_已收_新增,dlzjjlxz.dlzjfjl as 代理中介服务费_已结_新增,dlzjjlxz2.dlzjfjl2 as 代理中介服务费_二次结利_新增,
mmzjjz.mmzjf as 买卖中介服务费_已收_结转,mmzjjljz.mmzjf as 买卖中介服务费_结利_结转, mmdbghjz.mmdbghf as 买卖代办过户费_已收_结转,mmdbghjljz.mmdbghf as 买卖代办过户费_结利_结转,
mmdkjz.mmdkf as 买卖贷款服务费结转,mmpgjz.mmpgf as 买卖评估费提成结转,mmqtjz.mmqt as 买卖其他费用结转,
zlzjjz.zlzjf as 租赁中介服务费结转,zlqtjz.zlqt as 租赁其他费用结转,
dlzjjz.dlzjf as 代理中介服务费_已收_结转,dlzjjljz.dlzjfjl as 代理中介服务费_已结_结转,dlzjjljz2.dlzjfjl2 as 代理中介服务费_二次结利_结转,

dzmmzjxz.mmzjf as 店长买卖中介服务费_已收_新增, dzmmzjjlxz.mmzjf as 店长买卖中介服务费_结利_新增, dzmmdbghxz.mmdbghf as 店长买卖代办过户费_已收_新增,dzmmdbghjlxz.mmdbghf as 店长买卖代办过户费_结利_新增,
dzmmdkxz.mmdkf as 店长买卖贷款服务费新增,dzmmpgxz.mmpgf as 店长买卖评估费提成新增,dzmmqtxz.mmqt as 店长买卖其他费用新增,
dzzlzjxz.zlzjf as 店长租赁中介服务费新增,dzzlqtxz.zlqt as 店长租赁其他费用新增,
dzdlzjxz.dlzjf as 店长代理中介服务费_已收_新增,
dzdlzjjlxz.dlzjfjl as 店长代理中介服务费_结利_新增,
dzdlzjjlxz2.dlzjfjl2 as 店长代理中介费_二次结利_新增,
dzmmzjjz.mmzjf as 店长买卖中介服务费_已收_结转,dzmmzjjljz.mmzjf as 店长买卖中介服务费_结利_结转, dzmmdbghjz.mmdbghf as 店长买卖代办过户费_已收_结转,dzmmdbghjljz.mmdbghf as 店长买卖代办过户费_结利_结转,
dzmmdkjz.mmdkf as 店长买卖贷款服务费结转,dzmmpgjz.mmpgf as 店长买卖评估费提成结转,dzmmqtjz.mmqt as 店长买卖其他费用结转,
dzzlzjjz.zlzjf as 店长租赁中介服务费结转,dzzlqtjz.zlqt as 店长租赁其他费用结转,
dzdlzjjz.dlzjf as 店长代理中介服务费_已收_结转,
dzdlzjjljz.dlzjfjl as 店长代理中介服务费_结利_结转,
dzdlzjjljz2.dlzjfjl2 as 店长代理中介费_二次结利_结转
from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房事业部%' or usr.username ='不算个人业绩' or usr.nameall = '联动营业部' or usr.deptname = '金融权证') and ((usr.status = '离职' and (to_date(to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd'),'yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM') <= to_char(VIEW_DATE.GET_DATE,'yyyy-MM') ))) u
 --买卖中介服务费(已收)新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.store_user_id) mmzjxz
  on u.user_id = mmzjxz.store_user_id
 --买卖中介服务费(结利)新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmzjf from JL mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd')  group by mmfee.store_user_id) mmzjjlxz
  on u.user_id = mmzjjlxz.store_user_id
   --买卖代办过户费(已收)新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.store_user_id) mmdbghxz
  on u.user_id = mmdbghxz.store_user_id
 --买卖代办过户费(结利)新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmdbghf from JL mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd')  group by mmfee.store_user_id) mmdbghjlxz
  on u.user_id = mmdbghjlxz.store_user_id
 --买卖贷款服务费新增
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.store_user_id) mmdkxz
 on u.user_id = mmdkxz.store_user_id
 --买卖评估费新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费提成' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.store_user_id) mmpgxz
 on u.user_id = mmpgxz.store_user_id
 --买卖其他费用新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.store_user_id) mmqtxz
 on u.user_id = mmqtxz.store_user_id
 --租赁中介服务费新增
 left join
 (select zlfee.store_user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.store_user_id) zlzjxz
 on u.user_id = zlzjxz.store_user_id
 --租赁其他费用新增
  left join
 (select zlfee.store_user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.store_user_id) zlqtxz
 on u.user_id = zlqtxz.store_user_id
 --代理中介服务费(已收)新增
  left join
 (select dlfee.store_user_id,sum(dlfee.price) dlzjf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.store_user_id) dlzjxz
 on u.user_id = dlzjxz.store_user_id
   --代理中介服务费(已结)新增
  left join
 (select dlfee.store_user_id,sum(dlfee.price) dlzjfjl from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.store_user_id) dlzjjlxz
 on u.user_id = dlzjjlxz.store_user_id
  --代理中介服务费（二次结利）新增
   left join
 (select dlfee.store_user_id,sum(dlfee.price) dlzjfjl2 from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.store_user_id) dlzjjlxz2
 on u.user_id = dlzjjlxz2.store_user_id
  --买卖中介服务费(已收)结转
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.store_user_id) mmzjjz
  on u.user_id = mmzjjz.store_user_id
  --买卖中介服务费(结利)结转
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmzjf from JL mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd')  and mmfee.price >= 0 group by mmfee.store_user_id) mmzjjljz
  on u.user_id = mmzjjljz.store_user_id
    --买卖代办过户费(已收)结转
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.store_user_id) mmdbghjz
  on u.user_id = mmdbghjz.store_user_id
  --买卖代办过户费(结利)结转
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmdbghf from JL mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd')  and mmfee.price >= 0 group by mmfee.store_user_id) mmdbghjljz
  on u.user_id = mmdbghjljz.store_user_id
 --买卖贷款服务费结转
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.store_user_id) mmdkjz
 on u.user_id = mmdkjz.store_user_id
 --买卖评估费结转
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费提成' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.store_user_id) mmpgjz
 on u.user_id = mmpgjz.store_user_id
 --买卖其他费用结转
  left join
 (select mmfee.store_user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.store_user_id) mmqtjz
 on u.user_id = mmqtjz.store_user_id
 --租赁中介服务费结转
 left join
 (select zlfee.store_user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.store_user_id) zlzjjz
 on u.user_id = zlzjjz.store_user_id
 --租赁其他费用结转
  left join
 (select zlfee.store_user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.store_user_id) zlqtjz
 on u.user_id = zlqtjz.store_user_id
  --代理中介服务费(已收)结转
  left join
 (select dlfee.store_user_id,sum(dlfee.price) dlzjf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.store_user_id) dlzjjz
 on u.user_id = dlzjjz.store_user_id
   --代理中介服务费(结利)结转
  left join
 (select dlfee.store_user_id,sum(dlfee.price) dlzjfjl from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.store_user_id) dlzjjljz
 on u.user_id = dlzjjljz.store_user_id
  --代理中介服务费(二次结利)结转
   left join
 (select dlfee.store_user_id,sum(dlfee.price) dlzjfjl2 from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.store_user_id) dlzjjljz2
 on u.user_id = dlzjjljz2.store_user_id

 --店长个人业绩
 --店长买卖中介服务费(已收)新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) dzmmzjxz
  on u.user_id = dzmmzjxz.user_id
 --店长买卖中介服务费(结利)新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmzjf from JL mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) dzmmzjjlxz
  on u.user_id = dzmmzjjlxz.user_id
   --店长买卖代办过户费(已收)新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) dzmmdbghxz
  on u.user_id = dzmmdbghxz.user_id
 --店长买卖代办过户费(结利)新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmdbghf from JL mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) dzmmdbghjlxz
  on u.user_id = dzmmdbghjlxz.user_id
 --店长买卖贷款服务费新增
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) dzmmdkxz
 on u.user_id = dzmmdkxz.user_id
 --店长买卖评估费新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费提成' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) dzmmpgxz
 on u.user_id = dzmmpgxz.user_id
 --店长买卖其他费用新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by mmfee.user_id) dzmmqtxz
 on u.user_id = dzmmqtxz.user_id
 --店长租赁中介服务费新增
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.user_id) dzzlzjxz
 on u.user_id = dzzlzjxz.user_id
 --店长租赁其他费用新增
  left join
 (select zlfee.user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by zlfee.user_id) dzzlqtxz
 on u.user_id = dzzlqtxz.user_id
 --店长代理中介服务费(已收)新增
  left join
 (select dlfee.user_id,sum(dlfee.price) dlzjf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.user_id) dzdlzjxz
 on u.user_id = dzdlzjxz.user_id
  --店长代理中介服务费(结利)新增
  left join
 (select dlfee.user_id,sum(dlfee.price) dlzjfjl from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.user_id) dzdlzjjlxz
 on u.user_id = dzdlzjjlxz.user_id
  --店长代理中介服务费(二次结利)新增
   left join
 (select dlfee.user_id,sum(dlfee.price) dlzjfjl2 from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') group by dlfee.user_id) dzdlzjjlxz2
 on u.user_id = dzdlzjjlxz2.user_id
  --店长买卖中介服务费(已收)结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) dzmmzjjz
  on u.user_id = dzmmzjjz.user_id
  --店长买卖中介服务费(结利)结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmzjf from JL mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) dzmmzjjljz
  on u.user_id = dzmmzjjljz.user_id
    --店长买卖代办过户费(已收)结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) dzmmdbghjz
  on u.user_id = dzmmdbghjz.user_id
  --店长买卖代办过户费(结利)结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdbghf from JL mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) dzmmdbghjljz
  on u.user_id = dzmmdbghjljz.user_id
 --店长买卖贷款服务费结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) dzmmdkjz
 on u.user_id = dzmmdkjz.user_id
 --店长买卖评估费结转
 left join
 (select mmfee.user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费提成' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) dzmmpgjz
 on u.user_id = dzmmpgjz.user_id
 --店长买卖其他费用结转
  left join
 (select mmfee.user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and mmfee.price >= 0 group by mmfee.user_id) dzmmqtjz
 on u.user_id = dzmmqtjz.user_id
 --店长租赁中介服务费结转
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.user_id) dzzlzjjz
 on u.user_id = dzzlzjjz.user_id
 --店长租赁其他费用结转
  left join
 (select zlfee.user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and zlfee.price >= 0 group by zlfee.user_id) dzzlqtjz
 on u.user_id = dzzlqtjz.user_id
  --店长代理中介服务费(已收)结转
  left join
 (select dlfee.user_id,sum(dlfee.price) dlzjf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.user_id) dzdlzjjz
 on u.user_id = dzdlzjjz.user_id
   --店长代理中介服务费(结利)结转
  left join
 (select dlfee.user_id,sum(dlfee.price) dlzjfjl from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.user_id) dzdlzjjljz
 on u.user_id = dzdlzjjljz.user_id
    --店长代理中介服务费(二次结利)结转
   left join
 (select dlfee.user_id,sum(dlfee.price) dlzjfjl2 from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.contract_online_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_DATE,'yyyy-MM'),'-01') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_DATE),'yyyy-MM-dd') and dlfee.price >= 0 group by dlfee.user_id) dzdlzjjljz2
 on u.user_id = dzdlzjjljz2.user_id
 where (u.job_name = '店经理'
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
    or  dlzjjlxz.dlzjfjl   != 0
    or  mmzjjz.mmzjf       != 0
    or  mmzjjljz.mmzjf     != 0
    or  mmdbghjz.mmdbghf   != 0
    or  mmdbghjljz.mmdbghf != 0
    or  mmdkjz.mmdkf       != 0
    or  mmpgjz.mmpgf       != 0
    or  mmqtjz.mmqt        != 0
    or  zlzjjz.zlzjf       != 0
    or  zlqtjz.zlqt        != 0
    or  dlzjjz.dlzjf       != 0
    or  dlzjjljz.dlzjfjl   != 0)
--and   VIEW_DATE.SET_DATE('2018-10') = TO_DATE('2018-10','yyyy-MM')
 order by u.nameall,u.deptname;
