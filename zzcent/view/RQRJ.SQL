create or replace view rqrj as
select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",u."DIMISSION_DATE",
mmzj.mmzjf as 买卖到帐中介服务费,
mmdk.mmdkf as 买卖到帐贷款服务费,
mmpg.mmpgf as 买卖到帐评估费提成,
mmqt.mmqt as 买卖到帐其他费用,
mmdz.mmdz as 买卖到帐垫资服务费,
mmdbghf.mmdbghf as 买卖到帐代办过户费,
mmmfzjf.mmmfzjf as 买卖到帐卖方中介费,
mmpgfsr.mmpgfsr as 买卖到帐评估费收入,
zlzj.zlzjf as 租赁到帐中介服务费,
zlmfzjf.zlmfzjf as 租赁到帐卖方中介费,
zlqt.zlqt as 租赁到帐其他费用,
dlzjf.dlzjf as 代理到帐中介服务费,
MMHTZJ.MMHTZJ AS 买卖合同中介服务费,
MMHTDK.MMHTDK AS 买卖合同贷款服务费,
MMHTPGFTC.MMHTPGFTC AS 买卖合同评估费提成,
MMHTPGFSR.MMHTPGFSR AS 买卖合同评估费收入,
MMHTDBGHF.MMHTDBGHF as 买卖合同代办过户费,
MMHTQTFY.MMHTQTFY   AS 买卖合同其他费用,
MMHTMFZJF.MMHTMFZJF AS 买卖合同卖方中介费,
ZLHTZJFWF.ZLHTZJFWF AS 租赁合同中介服务费,
ZLHTMFZJF.ZLHTMFZJF AS 租赁合同卖方中介费,
DLHTZJFWF.DLHTZJFWF AS 代理合同中介服务费,
MMHT.MMHT AS 买卖新增套数,
ZLHT.ZLHT AS 租赁新增套数,
DLHT.DLHT AS 代理新增套数
from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房事业部%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date(to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd'),'yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM') <= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') ))) u
 --买卖到账中介服务费
 left join
 (select mmfee.user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by mmfee.user_id) mmzj
  on u.user_id = mmzj.user_id
 --买卖到账贷款服务费
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by mmfee.user_id) mmdk
 on u.user_id = mmdk.user_id
 --买卖到账评估费提成
 left join
 (select mmfee.user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by mmfee.user_id) mmpg
 on u.user_id = mmpg.user_id
 --买卖到账其他费用
 left join
 (select mmfee.user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by mmfee.user_id) mmqt
 on u.user_id = mmqt.user_id
  --买卖到账垫资服务费
 left join
 (select mmfee.user_id,sum(mmfee.price) mmdz from report_mm_fee_info mmfee  where mmfee.fee_name = '垫资服务费' and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by mmfee.user_id) mmdz
 on u.user_id = mmdz.user_id
  --买卖到帐代办过户费
 left join
 (select mmfee.user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by mmfee.user_id) mmdbghf
  on u.user_id = mmdbghf.user_id
   --买卖到帐卖方中介费
 left join
  (select mmfee.user_id,sum(mmfee.price) mmmfzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '卖方中介费' and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by mmfee.user_id) mmmfzjf
 on u.user_id = mmmfzjf.user_id
  --买卖到帐评估费收入
 left join
 (select mmfee.user_id,sum(mmfee.price) mmpgfsr from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费收入' and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by mmfee.user_id) mmpgfsr
 on u.user_id = mmpgfsr.user_id
 --租赁到账中介服务费
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by zlfee.user_id) zlzj
 on u.user_id = zlzj.user_id
  --租赁到帐卖方中介费
 left join
 (select zlfee.user_id,sum(zlfee.price) zlmfzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '卖方中介费' and to_char(zlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by zlfee.user_id) zlmfzjf
 on u.user_id = zlmfzjf.user_id
 --租赁到账其他费用
  left join
 (select zlfee.user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by zlfee.user_id) zlqt
 on u.user_id = zlqt.user_id
 --代理到帐中介服务费
  left join
 (select dlfee.user_id,sum(dlfee.price) dlzjf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by dlfee.user_id) dlzjf
 on u.user_id = dlzjf.user_id
 
 --买卖合同中介服务费
  left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTZJ FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='中介服务费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTZJ  
 ON U.USER_ID = MMHTZJ.DUTY_USER_ID
 --买卖合同贷款服务费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTDK FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='贷款服务费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTDK  
 ON U.USER_ID = MMHTDK.DUTY_USER_ID
  --买卖合同评估费提成
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTPGFTC FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='评估费提成' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTPGFTC  
 ON U.USER_ID = MMHTPGFTC.DUTY_USER_ID
  --买卖合同评估费收入
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTPGFSR FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='评估费收入' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTPGFSR  
 ON U.USER_ID = MMHTPGFSR.DUTY_USER_ID
  --买卖合同代办过户费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTDBGHF FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='代办过户费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTDBGHF  
 ON U.USER_ID = MMHTDBGHF.DUTY_USER_ID
  --买卖合同其他费用
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTQTFY FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='其他费用' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTQTFY  
 ON U.USER_ID = MMHTQTFY.DUTY_USER_ID
  --买卖合同卖方中介费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTMFZJF FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='卖方中介费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTMFZJF  
 ON U.USER_ID = MMHTMFZJF.DUTY_USER_ID
  --租赁合同中介服务费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) ZLHTZJFWF FROM BIZ_ZL_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='中介服务费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) ZLHTZJFWF  
 ON U.USER_ID = ZLHTZJFWF.DUTY_USER_ID
  --租赁合同卖方中介费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) ZLHTMFZJF FROM BIZ_ZL_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='卖方中介费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) ZLHTMFZJF  
 ON U.USER_ID = ZLHTMFZJF.DUTY_USER_ID
  --代理合同中介服务费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) DLHTZJFWF FROM BIZ_BUILDING_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='中介服务费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) DLHTZJFWF  
 ON U.USER_ID = DLHTZJFWF.DUTY_USER_ID
  --买卖新增套数
   left join
  (select T.DUTY_USER_ID, COUNT(T.ID) MMHT FROM BIZ_MM_CONTRACT T WHERE T.IS_REC = 0 AND T.STATUS = '已审核'  and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHT  
 ON U.USER_ID = MMHT.DUTY_USER_ID
  --租赁新增套数
   left join
  (select T.DUTY_USER_ID, COUNT(T.ID) ZLHT FROM BIZ_ZL_CONTRACT T WHERE T.IS_REC = 0 AND T.STATUS = '已审核'  and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) ZLHT  
 ON U.USER_ID = ZLHT.DUTY_USER_ID
  --代理新增套数
   left join
  (select T.DUTY_USER_ID, COUNT(T.ID) DLHT FROM BIZ_BUILDING_CONTRACT T WHERE T.IS_REC = 0 AND T.STATUS = '已审核'  and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) DLHT  
 ON U.USER_ID = DLHT.DUTY_USER_ID
 --where   VIEW_DATE.SET_START_DATE('2018-10-01') = TO_DATE('2018-10-01','yyyy-MM-dd')
 --and     VIEW_DATE.SET_END_DATE('2019-10-01') = TO_DATE('2019-10-01','yyyy-MM-dd')
 order by u.DAQUNAME,u.deptname,u.USERNAME;
