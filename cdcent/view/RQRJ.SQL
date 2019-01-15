create or replace view rqrj as
select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",u."DIMISSION_DATE",
NVL(mmzj.mmzjf,0) as 买卖到帐中介服务费,
NVL(mmdk.mmdkf,0) as 买卖到帐贷款服务费,
NVL(mmpg.mmpgf,0) as 买卖到帐评估费提成,
NVL(mmqt.mmqt,0) as 买卖到帐其他费用,
NVL(mmdz.mmdz,0) as 买卖到帐垫资服务费,
NVL(mmdbghf.mmdbghf,0) as 买卖到帐代办过户费,
NVL(mmmfzjf.mmmfzjf,0) as 买卖到帐卖方中介费,
NVL(mmpgfsr.mmpgfsr,0) as 买卖到帐评估费收入,
(NVL(mmzj.mmzjf,0)+NVL(mmdk.mmdkf,0)+NVL(mmpg.mmpgf,0)+NVL(mmqt.mmqt,0)+NVL(mmdz.mmdz,0)+NVL(mmdbghf.mmdbghf,0)+NVL(mmmfzjf.mmmfzjf,0)+NVL(mmpgfsr.mmpgfsr,0)) as 买卖到账值,

NVL(zlzj.zlzjf,0) as 租赁到帐中介服务费,
NVL(zlmfzjf.zlmfzjf,0) as 租赁到帐卖方中介费,
NVL(zlqt.zlqt,0) as 租赁到帐其他费用,
(NVL(zlzj.zlzjf,0)+NVL(zlmfzjf.zlmfzjf,0)+NVL(zlqt.zlqt,0)) AS 租赁到账值,

/*NVL(dlzjf.dlzjf,0) as 代理到帐中介服务费,*/
NVL(MMHTZJ.MMHTZJ,0) AS 买卖合同中介服务费,
NVL(MMHTDK.MMHTDK,0) AS 买卖合同贷款服务费,
NVL(MMHTPGFTC.MMHTPGFTC,0) AS 买卖合同评估费提成,
NVL(MMHTPGFSR.MMHTPGFSR,0) AS 买卖合同评估费收入,
NVL(MMHTDBGHF.MMHTDBGHF,0) as 买卖合同代办过户费,
NVL(MMHTQTFY.MMHTQTFY,0)   AS 买卖合同其他费用,
NVL(MMHTMFZJF.MMHTMFZJF,0) AS 买卖合同卖方中介费,
(NVL(MMHTZJ.MMHTZJ,0)+NVL(MMHTDK.MMHTDK,0)+NVL(MMHTPGFTC.MMHTPGFTC,0)+NVL(MMHTPGFSR.MMHTPGFSR,0)+NVL(MMHTDBGHF.MMHTDBGHF,0)+NVL(MMHTQTFY.MMHTQTFY,0)+NVL(MMHTMFZJF.MMHTMFZJF,0)) as 买卖合同值,

NVL(ZLHTZJFWF.ZLHTZJFWF,0) AS 租赁合同中介服务费,
NVL(ZLHTMFZJF.ZLHTMFZJF,0) AS 租赁合同卖方中介费,
(NVL(ZLHTZJFWF.ZLHTZJFWF,0)+NVL(ZLHTMFZJF.ZLHTMFZJF,0)) as 租赁合同值,

/*NVL(DLHTZJFWF.DLHTZJFWF,0) AS 代理合同中介服务费,*/

NVL(MMHT.MMHT,0) AS 买卖新增套数,
NVL(ZLHT.ZLHT,0) AS 租赁新增套数/*,
NVL(DLHT.DLHT,0) AS 代理新增套数*/
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
 /*--代理到帐中介服务费
  left join
 (select dlfee.user_id,sum(dlfee.price) dlzjf from report_dl_fee_info dlfee  where dlfee.fee_name = '中介服务费' and to_char(dlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') group by dlfee.user_id) dlzjf
 on u.user_id = dlzjf.user_id*/

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
  /*--代理合同中介服务费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) DLHTZJFWF FROM BIZ_BUILDING_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='中介服务费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) DLHTZJFWF
 ON U.USER_ID = DLHTZJFWF.DUTY_USER_ID*/
  --买卖新增套数
   left join
  (select T.DUTY_USER_ID, COUNT(T.ID) MMHT FROM BIZ_MM_CONTRACT T WHERE T.IS_REC = 0 AND T.STATUS = '已审核'  and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHT
 ON U.USER_ID = MMHT.DUTY_USER_ID
  --租赁新增套数
   left join
  (select T.DUTY_USER_ID, COUNT(T.ID) ZLHT FROM BIZ_ZL_CONTRACT T WHERE T.IS_REC = 0 AND T.STATUS = '已审核'  and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) ZLHT
 ON U.USER_ID = ZLHT.DUTY_USER_ID
  /*--代理新增套数
   left join
  (select T.DUTY_USER_ID, COUNT(T.ID) DLHT FROM BIZ_BUILDING_CONTRACT T WHERE T.IS_REC = 0 AND T.STATUS = '已审核'  and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) DLHT
 ON U.USER_ID = DLHT.DUTY_USER_ID*/

 --where   VIEW_DATE.SET_START_DATE('2018-10-01') = TO_DATE('2018-10-01','yyyy-MM-dd')
 --and     VIEW_DATE.SET_end_DATE('2019-10-01') = TO_DATE('2019-10-01','yyyy-MM-dd')
 order by u.DAQUNAME,u.deptname,u.USERNAME;
