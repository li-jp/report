select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",/*u."PAY",*/u."DIMISSION_DATE",
mmzjfwfxz.mmzjfwf as 买卖中介服务费新增, mmmfzjfxz.mmmfzjf as 买卖卖方中介费新增, mmdkfwfxz.mmdkfwf as 买卖贷款服务费新增, mmpgfsrxz.mmpgfsr as 买卖评估费收入新增,mmqtfyxz.mmqtfy as 买卖其他费用新增,zlzjfwfxz.zlzjfwf as 租赁中介服务费新增,zlmfzjfxz.zlmfzjf as 租赁卖方中介费新增,
mmzjfwfjz.mmzjfwf as 买卖中介服务费结转, mmmfzjfjz.mmmfzjf as 买卖卖方中介费结转, mmdkfwfjz.mmdkfwf as 买卖贷款服务费结转, mmpgfsrjz.mmpgfsr as 买卖评估费收入结转,mmqtfyjz.mmqtfy as 买卖其他费用结转,zlzjfwfjz.zlzjfwf as 租赁中介服务费结转,zlmfzjfjz.zlmfzjf as 租赁卖方中介费结转
from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%片区%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date('${MONTH_END}','yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM-dd') <= '${MONTH_START}' ))) u
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
 (select mmfee.user_id,sum(mmfee.price) mmpgfsr from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmpgfsrxz
 on u.user_id = mmpgfsrxz.user_id
 --买卖其他费用新增
 left join
 (select mmfee.user_id,sum(mmfee.price) mmqtfy from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.user_id) mmqtfyxz
 on u.user_id = mmqtfyxz.user_id
 --租赁中介服务费新增
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjfwf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by zlfee.user_id) zlzjfwfxz
 on u.user_id = zlzjfwfxz.user_id
 --租赁卖方中介费新增
  left join
 (select zlfee.user_id,sum(zlfee.price) zlmfzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '卖方中介费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by zlfee.user_id) zlmfzjfxz
 on u.user_id = zlmfzjfxz.user_id
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
 (select mmfee.user_id,sum(mmfee.price) mmpgfsr from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmpgfsrjz
 on u.user_id = mmpgfsrjz.user_id
 --买卖其他费用结转
  left join
 (select mmfee.user_id,sum(mmfee.price) mmqtfy from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.user_id) mmqtfyjz
 on u.user_id = mmqtfyjz.user_id
 --租赁中介服务费结转
 left join
 (select zlfee.user_id,sum(zlfee.price) zlzjfwf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price >= 0 group by zlfee.user_id) zlzjfwfjz
 on u.user_id = zlzjfwfjz.user_id
 --租赁卖方中介费结转
  left join
 (select zlfee.user_id,sum(zlfee.price) zlmfzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '卖方中介费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price >= 0 group by zlfee.user_id) zlmfzjfjz
 on u.user_id = zlmfzjfjz.user_id
 where u.deptname like '%${text}%'
   ${if(len(pro_name)==0,"",
	"and (u.username= '"+pro_name+
	"' or u.deptname ='"+ pro_name+
	"' or u.daquname ='"+ pro_name+
	"')")
	}
 order by u.DAQUNAME,u.deptname,u.USERNAME