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
UNION
SELECT SUM(RECVB.RECEIVABLE) PRICE
FROM BIZ_MM_CONTRACT T1,SYS_DEPARTMENT D1, BIZ_CONTRACT_RECEIVABLE RECVB
WHERE T1.STATUS = '已审核'
AND   T1.IS_REC = 0
AND   RECVB.STATUS = '有效'
AND   RECVB.IS_REC = 0
AND   T1.DEAL_DEPT_ID = D1.ID
AND   T1.ID = RECVB.CONTRACT_ID
AND   RECVB.FEE_TYPE = '卖方中介费' 
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'
UNION
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
UNION
SELECT SUM(DETAIL.PRICE) PRICE
FROM BIZ_MM_CONTRACT T1,SYS_DEPARTMENT D1, NEW_FIN_PROFIT_DETAIL DETAIL, BIZ_CONTRACT_FEE FEE 
WHERE T1.STATUS = '已审核'
AND   T1.IS_REC = 0
AND   DETAIL.STATUS = '已分成'
AND   DETAIL.IS_REC = 0
AND   T1.DEAL_DEPT_ID = D1.ID
AND   T1.ID = FEE.CONTRACT_ID
AND   DETAIL.FEE_ID = FEE.ID
AND   DETAIL.REASON = '代办过户费'
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'
UNION
SELECT SUM(DETAIL.PRICE) PRICE
FROM BIZ_MM_CONTRACT T1,SYS_DEPARTMENT D1, NEW_FIN_PROFIT_DETAIL DETAIL, BIZ_CONTRACT_FEE FEE 
WHERE T1.STATUS = '已审核'
AND   T1.IS_REC = 0
AND   DETAIL.STATUS = '已分成'
AND   DETAIL.IS_REC = 0
AND   T1.DEAL_DEPT_ID = D1.ID
AND   T1.ID = FEE.CONTRACT_ID
AND   DETAIL.FEE_ID = FEE.ID
AND   DETAIL.REASON = '垫资服务费'
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'
UNION
SELECT SUM(DETAIL.PRICE) PRICE
FROM BIZ_MM_CONTRACT T1,SYS_DEPARTMENT D1, NEW_FIN_PROFIT_DETAIL DETAIL, BIZ_CONTRACT_FEE FEE 
WHERE T1.STATUS = '已审核'
AND   T1.IS_REC = 0
AND   DETAIL.STATUS = '已分成'
AND   DETAIL.IS_REC = 0
AND   T1.DEAL_DEPT_ID = D1.ID
AND   T1.ID = FEE.CONTRACT_ID
AND   DETAIL.FEE_ID = FEE.ID
AND   DETAIL.REASON = '其他费用'
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'
))
UNION
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
));


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
AND   DETAIL.REASON = '评估费收入'
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T1.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}'
UNION
SELECT SUM(DETAIL.PRICE) PRICE, '租赁' TYPE
FROM BIZ_ZL_CONTRACT T2,SYS_DEPARTMENT D1, NEW_FIN_PROFIT_DETAIL DETAIL, BIZ_CONTRACT_FEE FEE 
WHERE T2.STATUS = '已审核'
AND   T2.IS_REC = 0
AND   DETAIL.STATUS = '已分成'
AND   DETAIL.IS_REC = 0
AND   T2.DEAL_DEPT_ID = D1.ID
AND   T2.ID = FEE.CONTRACT_ID
AND   DETAIL.FEE_ID = FEE.ID
AND   DETAIL.REASON = '评估费收入'
AND   D1.NAME LIKE '%${text}%'
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}';


--实收金额
select u.deptname, (NVL(zlzjfwfxz.zlzjfwf,0)+NVL(zlzjfwfjz.zlzjfwf,0)) AS 实收金额, '租赁' AS TYPE
from 
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%分公司%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date('${MONTH_END}','yyyy-MM-dd')-usr.Dimission_Date) <=60) or usr.status = '在职') and usr.deptname like '%${text}%') u 
  --租赁中介服务费新增
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjfwf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by zlfee.user_id) zlzjfwfxz
 on u.user_id = zlzjfwfxz.user_id
   --租赁中介服务费结转
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjfwf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price >= 0 group by zlfee.user_id) zlzjfwfjz
 on u.user_id = zlzjfwfjz.user_id
 UNION
 select u.deptname, ( NVL(mmzjfwfxz.mmzjfwf,0) + NVL(mmmfzjfxz.mmmfzjf,0) + NVL(mmdkfwfxz.mmdkfwf,0) + NVL(mmpgfsrxz.mmpgfsr,0) + NVL(mmdbghfxz.mmdbghf,0) +NVL(mmdzfwfxz.mmdzfwf,0) + NVL(mmqtfyxz.mmqtfy,0) +NVL(mmzjfwfjz.mmzjfwf,0) + NVL(mmmfzjfjz.mmmfzjf,0) + NVL(mmdkfwfjz.mmdkfwf,0) + NVL(mmpgfsrjz.mmpgfsr,0) + NVL(mmdbghfjz.mmdbghf,0) +NVL(mmdzfwfjz.mmdzfwf,0) + NVL(mmqtfyjz.mmqtfy,0) ) AS 实收金额, '买卖' TYPE
from 
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房事业部%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date('${MONTH_END}','yyyy-MM-dd')-usr.Dimission_Date) <=60) or usr.status = '在职') and usr.deptname like '%${text}%') u 
 --买卖中介服务费新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmzjfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmzjfwfxz
  on u.user_id = mmzjfwfxz.user_id
 --买卖卖方中介费新增
 left join
  (select mmfee.user_id,sum(mmfee.price) mmmfzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '卖方中介费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmmfzjfxz
 on u.user_id = mmmfzjfxz.user_id
  --买卖贷款服务费新增
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdkfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmdkfwfxz
 on u.user_id = mmdkfwfxz.user_id
 --买卖评估费收入新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmpgfsr from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费收入' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmpgfsrxz
 on u.user_id = mmpgfsrxz.user_id
  --买卖代办过户费新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmdbghfxz
 on u.user_id = mmdbghfxz.user_id
   --买卖垫资服务费新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmdzfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '垫资服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmdzfwfxz
 on u.user_id = mmdzfwfxz.user_id
 --买卖其他费用新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmqtfy from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmqtfyxz
 on u.user_id = mmqtfyxz.user_id
  --买卖中介服务费结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmzjfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmzjfwfjz
  on u.user_id = mmzjfwfjz.user_id
  --买卖卖方中介费结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmmfzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '卖方中介费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmmfzjfjz
  on u.user_id = mmmfzjfjz.user_id
 --买卖贷款服务费结转
 left join
  (select mmfee.user_id,sum(mmfee.price) mmdkfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmdkfwfjz
 on u.user_id = mmdkfwfjz.user_id
 --买卖评估费收入结转
 left join
 (select mmfee.user_id,sum(mmfee.price) mmpgfsr from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费收入' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmpgfsrjz
 on u.user_id = mmpgfsrjz.user_id
  --买卖代办过户费结转
 left join
 (select mmfee.user_id,sum(mmfee.price) mmdbghf from report_mm_fee_info mmfee  where mmfee.fee_name = '代办过户费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmdbghfjz
 on u.user_id = mmdbghfjz.user_id
   --买卖垫资服务费结转
 left join
 (select mmfee.user_id,sum(mmfee.price) mmdzfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '垫资服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmdzfwfjz
 on u.user_id = mmdzfwfjz.user_id
 --买卖其他费用结转
  left join
 (select mmfee.user_id,sum(mmfee.price) mmqtfy from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmqtfyjz
 on u.user_id = mmqtfyjz.user_id;
 

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
UNION
(SELECT COUNT(T2.ID), '租赁' TYPE
FROM   BIZ_ZL_CONTRACT T2, SYS_DEPARTMENT D2 
WHERE  T2.STATUS = '已审核'
AND    T2.IS_REC = 0
AND    T2.DEAL_DEPT_ID = D2.ID
AND    D2.NAME LIKE '%${text}%'
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') >= '${MONTH_START}' 
AND    TO_CHAR(T2.REVIEW_DATE,'YYYY-MM-DD') <= '${MONTH_END}')) T
order by T.TYPE;