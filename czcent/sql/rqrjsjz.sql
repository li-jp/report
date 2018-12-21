--合同值
(SELECT SUM(PRICE) HT_PRICE , '买卖' TYPE FROM
(SELECT SUM(RECVB.RECEIVABLE) PRICE
FROM BIZ_MM_CONTRACT T1,SYS_DEPARTMENT D1, BIZ_CONTRACT_RECEIVABLE RECVB
WHERE T1.STATUS = '已审核' 
AND   T1.IS_REC = 0
AND   RECVB.STATUS = '有效'
AND   RECVB.IS_REC = 0
AND   T1.DEAL_DEPT_ID = D1.ID
AND   T1.ID = RECVB.CONTRACT_ID
AND   RECVB.FEE_TYPE = '中介服务费'
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'
UNION all
SELECT SUM(RECVB.RECEIVABLE) PRICE
FROM BIZ_MM_CONTRACT T1,SYS_DEPARTMENT D1, BIZ_CONTRACT_RECEIVABLE RECVB
WHERE T1.STATUS = '已审核'
AND   T1.IS_REC = 0
AND   RECVB.STATUS = '有效'
AND   RECVB.IS_REC = 0
AND   T1.DEAL_DEPT_ID = D1.ID
AND   T1.ID = RECVB.CONTRACT_ID
AND   RECVB.FEE_TYPE = '贷款服务费' 
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'
UNION all
SELECT SUM(DETAIL.PRICE) PRICE
FROM BIZ_MM_CONTRACT T1,SYS_DEPARTMENT D1, NEW_FIN_PROFIT_DETAIL DETAIL, BIZ_CONTRACT_FEE FEE 
WHERE T1.STATUS = '已审核'
AND   T1.IS_REC = 0
AND   DETAIL.STATUS = '已分成'
AND   DETAIL.IS_REC = 0
AND   T1.DEAL_DEPT_ID = D1.ID
AND   T1.ID = FEE.CONTRACT_ID
AND   DETAIL.FEE_ID = FEE.ID
AND   DETAIL.REASON = '评估费'
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'))
UNION all
(SELECT SUM(PRICE), '租赁' TYPE FROM
(SELECT SUM(RECVB.RECEIVABLE) PRICE
FROM   BIZ_ZL_CONTRACT T2, SYS_DEPARTMENT D2, BIZ_CONTRACT_RECEIVABLE RECVB
WHERE  T2.STATUS = '已审核'
AND    T2.IS_REC = 0
AND    RECVB.STATUS = '有效'
AND    RECVB.IS_REC = 0
AND    T2.DEAL_DEPT_ID = D2.ID
AND    T2.ID = RECVB.CONTRACT_ID
AND    RECVB.FEE_TYPE = '中介服务费'
AND    D2.NAME LIKE '%${text}%'
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'
UNION all
SELECT SUM(RECVB.RECEIVABLE) PRICE
FROM   BIZ_ZL_CONTRACT T2, SYS_DEPARTMENT D2, BIZ_CONTRACT_RECEIVABLE RECVB
WHERE  T2.STATUS = '已审核'
AND    T2.IS_REC = 0
AND    RECVB.STATUS = '有效'
AND    RECVB.IS_REC = 0
AND    T2.DEAL_DEPT_ID = D2.ID
AND    T2.ID = RECVB.CONTRACT_ID
AND    RECVB.FEE_TYPE = '其他费用'
AND    D2.NAME LIKE '%${text}%'
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'));


--评估费提成
SELECT SUM(DETAIL.PRICE) PRICE, '买卖' TYPE
FROM BIZ_MM_CONTRACT T1,SYS_DEPARTMENT D1, NEW_FIN_PROFIT_DETAIL DETAIL, BIZ_CONTRACT_FEE FEE 
WHERE T1.STATUS = '已审核'
AND   T1.IS_REC = 0
AND   DETAIL.STATUS = '已分成'
AND   DETAIL.IS_REC = 0
AND   T1.DEAL_DEPT_ID = D1.ID
AND   T1.ID = FEE.CONTRACT_ID
AND   DETAIL.FEE_ID = FEE.ID
AND   DETAIL.REASON = '评估费'
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'
UNION all
SELECT SUM(DETAIL.PRICE) PRICE, '租赁' TYPE
FROM BIZ_ZL_CONTRACT T2,SYS_DEPARTMENT D1, NEW_FIN_PROFIT_DETAIL DETAIL, BIZ_CONTRACT_FEE FEE 
WHERE T2.STATUS = '已审核'
AND   T2.IS_REC = 0
AND   DETAIL.STATUS = '已分成'
AND   DETAIL.IS_REC = 0
AND   T2.DEAL_DEPT_ID = D1.ID
AND   T2.ID = FEE.CONTRACT_ID
AND   DETAIL.FEE_ID = FEE.ID
AND   DETAIL.REASON = '评估费'
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}';


--实收金额
select u.deptname, (NVL(zlzjxz.zlzjf,0)+NVL(zlqtxz.zlqt,0)+NVL(zlzjjz.zlzjf,0)+NVL(zlqtjz.zlqt,0)) AS 实收金额, '租赁' AS TYPE
from 
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%片区%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date('${MONTH_END}','yyyy-MM-dd')-usr.Dimission_Date) <=60) or usr.status = '在职') and usr.deptname like '%${text}%') u 
  --租赁中介服务费新增
 left join 
 (select zlfee.user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by zlfee.user_id) zlzjxz
 on u.user_id = zlzjxz.user_id
 --租赁其他费用新增
  left join 
 (select zlfee.user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by zlfee.user_id) zlqtxz
 on u.user_id = zlqtxz.user_id
  --租赁中介服务费结转
 left join 
 (select zlfee.user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price >= 0 group by zlfee.user_id) zlzjjz
 on u.user_id = zlzjjz.user_id
 --租赁其他费用结转
  left join 
 (select zlfee.user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price >= 0 group by zlfee.user_id) zlqtjz
 on u.user_id = zlqtjz.user_id
 UNION all
 select u.deptname, (NVL(mmzjxz.mmzjf,0)+NVL(mmdkxz.mmdkf,0)+NVL(mmpgxz.mmpgf,0)+NVL(mmqtxz.mmqt,0)+NVL(mmzjjz.mmzjf,0)+NVL(mmdkjz.mmdkf,0)+NVL(mmpgjz.mmpgf,0)+NVL(mmqtjz.mmqt,0)) AS 实收金额, '买卖' TYPE
from 
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%片区%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date('${MONTH_END}','yyyy-MM-dd')-usr.Dimission_Date) <=60) or usr.status = '在职') and usr.deptname like '%${text}%') u 
 --买卖中介服务费新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmzjxz
  on u.user_id = mmzjxz.user_id
 --买卖贷款服务费新增
 left join 
  (select mmfee.user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmdkxz
 on u.user_id = mmdkxz.user_id
 --买卖评估费新增
 left join 
 (select mmfee.user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmpgxz
 on u.user_id = mmpgxz.user_id
 --买卖其他费用新增
 left join 
 (select mmfee.user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmqtxz
 on u.user_id = mmqtxz.user_id
  --买卖中介服务费结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmzjjz
  on u.user_id = mmzjjz.user_id
 --买卖贷款服务费结转
 left join 
  (select mmfee.user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmdkjz
 on u.user_id = mmdkjz.user_id
 --买卖评估费结转
 left join 
 (select mmfee.user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmpgjz
 on u.user_id = mmpgjz.user_id
 --买卖其他费用结转
  left join 
 (select mmfee.user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmqtjz
 on u.user_id = mmqtjz.user_id;
 
 
--新增套数
SELECT * FROM
((SELECT COUNT(T1.ID) , '买卖' TYPE
FROM   BIZ_MM_CONTRACT T1, SYS_DEPARTMENT D1 
WHERE  T1.STATUS = '已审核'
AND    T1.IS_REC = 0
AND    T1.DEAL_DEPT_ID = D1.ID
AND    D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}')
UNION all
(SELECT COUNT(T2.ID), '租赁' TYPE
FROM   BIZ_ZL_CONTRACT T2, SYS_DEPARTMENT D2 
WHERE  T2.STATUS = '已审核'
AND    T2.IS_REC = 0
AND    T2.DEAL_DEPT_ID = D2.ID
AND    D2.NAME LIKE '%${text}%'
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}')) T
order by T.TYPE;