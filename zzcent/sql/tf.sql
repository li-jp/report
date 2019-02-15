WITH JL AS (
  SELECT T.user_id, T.store_user_id, T.area_user_id, T.input_date, T.proportion, T.fee_name, T.rachel_date, T.review_date,T.Early_Profit_Date, T.reason, T.contract_code, T.handwriting_code, T.deal_date, T.trloan_end,
  CASE WHEN to_char(T.trloan_end,'yyyy-MM-dd') <= '${MONTH_END}'
       THEN T.PRICE --过户日期小于等于记账月——结利100%
       WHEN (T.trloan_end is null or to_char(T.trloan_end,'yyyy-MM-dd') > '${MONTH_END}') and to_char(T.Early_Profit_Date,'yyyy-MM-dd') <= '${MONTH_END}'
       THEN T.PRICE*0.5 --过户日期为空或者大于等于记账月，且结利日期小于等于记账月——提前结利50%
       WHEN (T.trloan_end is null or to_char(T.trloan_end,'yyyy-MM-dd') > '${MONTH_END}') and (T.Early_Profit_Date is null or to_char(T.Early_Profit_Date,'yyyy-MM-dd') > '${MONTH_END}')
       THEN 0 END PRICE --过户日期为空或者大于等于记账月，且结利日期为空或者大于等于记账月——不结利
  FROM REPORT_MM_FEE_INFO T
)

select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",/*u."PAY",*/u."DIMISSION_DATE",
mmzjxz.mmzjf as 买卖中介服务费_已收_新增, mmzjxz.contract_code as 买卖中介服务费新增合同编号, mmzjxz.handwriting_code as 买卖中介服务费新增手写编号, mmzjxz.deal_date as 买卖中介服务费新增成单时间, 
mmzjjlxz.mmzjf as 买卖中介服务费_结利_新增, 
mmdbghxz.mmdbghf as 买卖代办过户费_已收_新增, mmdbghxz.contract_code as 买卖代办过户费新增合同编号, mmdbghxz.handwriting_code as 买卖代办过户费新增手写编号, mmdbghxz.deal_date as 买卖代办过户费新增成单时间, 
mmdbghjlxz.mmdbghf as 买卖代办过户费_结利_新增,
mmdkxz.mmdkf as 买卖贷款服务费新增, mmdkxz.contract_code as 买卖贷款服务费新增合同编号, mmdkxz.handwriting_code as 买卖贷款服务费新增手写编号, mmdkxz.deal_date as 买卖贷款服务费新增成单时间, 
mmpgxz.mmpgf as 买卖评估费提成新增, mmpgxz.contract_code as 买卖评估费提成新增合同编号, mmpgxz.handwriting_code as 买卖评估费提成新增手写编号, mmpgxz.deal_date as 买卖评估费提成新增成单时间, 
mmqtxz.mmqt as 买卖其他费用新增, mmqtxz.contract_code as 买卖其他费用新增合同编号, mmqtxz.handwriting_code as 买卖其他费用新增手写编号, mmqtxz.deal_date as 买卖其他费用新增成单时间, 
zlzjxz.zlzjf as 租赁中介服务费新增, zlzjxz.contract_code as 租赁中介服务费新增合同编号, zlzjxz.handwriting_code as 租赁中介服务费新增手写编号, zlzjxz.deal_date as 租赁中介服务费新增成单时间, 
zlqtxz.zlqt as 租赁其他费用新增, zlqtxz.contract_code as 租赁其他费用新增合同编号, zlqtxz.handwriting_code as 租赁其他费用新增手写编号, zlqtxz.deal_date as 租赁其他费用新增成单时间, 
dlzjxz.dlzjf as 代理中介服务费_已收_新增, dlzjxz.contract_code as 代理中介服务费新增合同编号, dlzjxz.handwriting_code as 代理中介服务费新增手写编号, dlzjxz.deal_date as 代理中介服务费新增成单时间, 
dlzjjlxz.dlzjfjl as 代理中介服务费_已结_新增,
dlzjjlxz2.dlzjfjl2 as 代理中介服务费_二次结利_新增,
mmzjjz.mmzjf as 买卖中介服务费_已收_结转, mmzjjz.contract_code as 买卖中介服务费结转合同编号, mmzjjz.handwriting_code as 买卖中介服务费结转手写编号, mmzjjz.deal_date as 买卖中介服务费结转成单时间, 
mmzjjljz.mmzjf as 买卖中介服务费_结利_结转, 
mmdbghjz.mmdbghf as 买卖代办过户费_已收_结转, mmdbghjz.contract_code as 买卖代办过户费结转合同编号, mmdbghjz.handwriting_code as 买卖代办过户费结转手写编号, mmdbghjz.deal_date as 买卖代办过户费结转成单时间, 
mmdbghjljz.mmdbghf as 买卖代办过户费_结利_结转,
mmdkjz.mmdkf as 买卖贷款服务费结转, mmdkjz.contract_code as 买卖贷款服务费结转合同编号, mmdkjz.handwriting_code as 买卖贷款服务费结转手写编号, mmdkjz.deal_date as 买卖贷款服务费结转成单时间, 
mmpgjz.mmpgf as 买卖评估费提成结转, mmpgjz.contract_code as 买卖评估费提成结转合同编号, mmpgjz.handwriting_code as 买卖评估费提成结转手写编号, mmpgjz.deal_date as 买卖评估费提成结转成单时间, 
mmqtjz.mmqt as 买卖其他费用结转, mmqtjz.contract_code as 买卖其他费用结转合同编号, mmqtjz.handwriting_code as 买卖其他费用结转手写编号, mmqtjz.deal_date as 买卖其他费用结转成单时间, 
zlzjjz.zlzjf as 租赁中介服务费结转, zlzjjz.contract_code as 租赁中介服务费结转合同编号, zlzjjz.handwriting_code as 租赁中介服务费结转手写编号, zlzjjz.deal_date as 租赁中介服务费结转成单时间, 
zlqtjz.zlqt as 租赁其他费用结转, zlqtjz.contract_code as 租赁其他费用结转合同编号, zlqtjz.handwriting_code as 租赁其他费用结转手写编号, zlqtjz.deal_date as 租赁其他费用结转成单时间, 
dlzjjz.dlzjf as 代理中介服务费_已收_结转, dlzjjz.contract_code as 代理中介服务费结转合同编号, dlzjjz.handwriting_code as 代理中介服务费结转手写编号, dlzjjz.deal_date as 代理中介服务费结转成单时间, 
dlzjjljz.dlzjfjl as 代理中介服务费_已结_结转,
dlzjjljz2.dlzjfjl2 as 代理中介服务费_二次结利_结转
from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房事业部%' or usr.username ='不算个人业绩' or usr.nameall = '联动营业部' or usr.deptname = '金融权证') and ((usr.status = '离职' and (to_date('${MONTH_END}','yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM') <= '${MONTH_END}' ))) u
 --买卖中介服务费(已收)新增
 left join
 (select mmfee.user_id, mmfee.price mmzjf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmzjxz
  on u.user_id = mmzjxz.user_id
 --买卖中介服务费(结利)新增
 left join
 (select mmfee.user_id, mmfee.price mmzjf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from JL mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0  group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmzjjlxz
  on u.user_id = mmzjjlxz.user_id
   --买卖代办过户费(已收)新增
 left join
 (select mmfee.user_id, mmfee.price mmdbghf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmdbghxz
  on u.user_id = mmdbghxz.user_id
 --买卖代办过户费(结利)新增
 left join
 (select mmfee.user_id, mmfee.price mmdbghf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from JL mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0  group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmdbghjlxz
  on u.user_id = mmdbghjlxz.user_id
 --买卖贷款服务费新增
 left join
  (select mmfee.user_id, mmfee.price mmdkf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmdkxz
 on u.user_id = mmdkxz.user_id
 --买卖评估费新增
 left join
 (select mmfee.user_id, mmfee.price mmpgf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费提成' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmpgxz
 on u.user_id = mmpgxz.user_id
 --买卖其他费用新增
 left join
 (select mmfee.user_id, mmfee.price mmqt, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmqtxz
 on u.user_id = mmqtxz.user_id
 --租赁中介服务费新增
 left join
 (select zlfee.user_id, zlfee.price zlzjf, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id, zlfee.price, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlzjxz
 on u.user_id = zlzjxz.user_id
 --租赁其他费用新增
  left join
 (select zlfee.user_id, zlfee.price zlqt, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id, zlfee.price, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlqtxz
 on u.user_id = zlqtxz.user_id
 --代理中介服务费(已收)新增
  left join
 (select dlfee.user_id, dlfee.price dlzjf, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(dlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(dlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(dlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and dlfee.price <= 0 group by dlfee.user_id, dlfee.price, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date) dlzjxz
 on u.user_id = dlzjxz.user_id
  --代理中介服务费(已结)新增
  left join
 (select dlfee.user_id, dlfee.price dlzjfjl, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(dlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(dlfee.contract_online_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(dlfee.contract_online_date,'yyyy-MM-dd') <= '${MONTH_END}' and dlfee.price <= 0 group by dlfee.user_id, dlfee.price, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date) dlzjjlxz
 on u.user_id = dlzjjlxz.user_id
 --代理中介服务费（二次结利）新增
   left join
 (select dlfee.user_id, dlfee.price dlzjfjl2, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(dlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(dlfee.contract_online_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(dlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(dlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and dlfee.price <= 0 group by dlfee.user_id, dlfee.price, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date) dlzjjlxz2
 on u.user_id = dlzjjlxz2.user_id
  --买卖中介服务费(已收)结转
 left join
  (select mmfee.user_id, mmfee.price mmzjf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmzjjz
  on u.user_id = mmzjjz.user_id
  --买卖中介服务费(结利)结转
 left join
  (select mmfee.user_id, mmfee.price mmzjf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from JL mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and  mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmzjjljz
  on u.user_id = mmzjjljz.user_id
    --买卖代办过户费(已收)结转
 left join
  (select mmfee.user_id, mmfee.price mmdbghf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmdbghjz
  on u.user_id = mmdbghjz.user_id
  --买卖代办过户费(结利)结转
 left join
  (select mmfee.user_id, mmfee.price mmdbghf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from JL mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmdbghjljz
  on u.user_id = mmdbghjljz.user_id
 --买卖贷款服务费结转
 left join
  (select mmfee.user_id, mmfee.price mmdkf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmdkjz
 on u.user_id = mmdkjz.user_id
 --买卖评估费结转
 left join
 (select mmfee.user_id, mmfee.price mmpgf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费提成' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmpgjz
 on u.user_id = mmpgjz.user_id
 --买卖其他费用结转
  left join
 (select mmfee.user_id, mmfee.price mmqt, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmqtjz
 on u.user_id = mmqtjz.user_id
 --租赁中介服务费结转
 left join
 (select zlfee.user_id, zlfee.price zlzjf, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id, zlfee.price, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlzjjz
 on u.user_id = zlzjjz.user_id
 --租赁其他费用结转
  left join
 (select zlfee.user_id, zlfee.price zlqt, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id, zlfee.price, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlqtjz
 on u.user_id = zlqtjz.user_id
 --代理中介服务费(已收)结转
  left join
 (select dlfee.user_id, dlfee.price dlzjf, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(dlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(dlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and dlfee.price <= 0 group by dlfee.user_id, dlfee.price, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date) dlzjjz
 on u.user_id = dlzjjz.user_id
  --代理中介服务费(结利)结转
  left join
 (select dlfee.user_id, dlfee.price dlzjfjl, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(dlfee.contract_online_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(dlfee.contract_online_date,'yyyy-MM-dd') <= '${MONTH_END}' and dlfee.price <= 0 group by dlfee.user_id, dlfee.price, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date) dlzjjljz
 on u.user_id = dlzjjljz.user_id
 --代理中介服务费(二次结利)结转
   left join
 (select dlfee.user_id, dlfee.price dlzjfjl2, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(dlfee.contract_online_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(dlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(dlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and dlfee.price <= 0 group by dlfee.user_id, dlfee.price, dlfee.contract_code, dlfee.handwriting_code, dlfee.deal_date) dlzjjljz2
 on u.user_id = dlzjjljz2.user_id
 where u.deptname like '%${text}%'
  ${if(len(pro_name)==0,"",
	"and (u.username= '"+pro_name+
	"' or u.deptname ='"+ pro_name+
	"' or u.daquname ='"+ pro_name+
	"')")
	}
 and   (mmzjxz.mmzjf        != 0
	or  mmzjjlxz.mmzjf      != 0
	or  mmdbghxz.mmdbghf    != 0
	or  mmdbghjlxz.mmdbghf  != 0
	or  mmdkxz.mmdkf        != 0
	or  mmpgxz.mmpgf        != 0
	or  mmqtxz.mmqt         != 0
	or  zlzjxz.zlzjf        != 0
	or  zlqtxz.zlqt         != 0
	or  dlzjxz.dlzjf        != 0
	or  dlzjjlxz.dlzjfjl    != 0
	or  dlzjjlxz2.dlzjfjl2  != 0
	or  mmzjjz.mmzjf        != 0
	or  mmzjjljz.mmzjf      != 0
	or  mmdbghjz.mmdbghf    != 0
	or  mmdbghjljz.mmdbghf  != 0
	or  mmdkjz.mmdkf        != 0
	or  mmpgjz.mmpgf        != 0
	or  mmqtjz.mmqt         != 0
	or  zlzjjz.zlzjf        != 0
	or  zlqtjz.zlqt         != 0
	or  dlzjjz.dlzjf        != 0
	or  dlzjjljz.dlzjfjl    != 0
	or  dlzjjljz2.dlzjfjl2  != 0)
 --and   (u.user_id = '${id}' or u.dept_id = '${id}' or u.pianqu_id = '${id}')
 --order by u.DAQUNAME,u.deptname,u.USERNAME;
