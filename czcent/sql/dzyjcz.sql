select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",/*u."PAY",*/u."DIMISSION_DATE",
mmzjfwfxz.mmzjfwf as 买卖中介服务费新增, mmmfzjfxz.mmmfzjf as 买卖卖方中介费新增, mmdkfwfxz.mmdkfwf as 买卖贷款服务费新增, mmpgfsrxz.mmpgfsr as 买卖评估费收入新增, mmqtfyxz.mmqtfy as 买卖其他费用新增,zlzjfwfxz.zlzjfwf as 租赁中介服务费新增,zlmfzjfxz.zlmfzjf as 租赁卖方中介费新增,
mmzjfwfjz.mmzjfwf as 买卖中介服务费结转, mmmfzjfjz.mmmfzjf as 买卖卖方中介费结转, mmdkfwfjz.mmdkfwf as 买卖贷款服务费结转, mmpgfsrjz.mmpgfsr as 买卖评估费收入结转, mmqtfyjz.mmqtfy as 买卖其他费用结转,zlzjfwfjz.zlzjfwf as 租赁中介服务费结转,zlmfzjfjz.zlmfzjf as 租赁卖方中介费结转
from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%片区%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date('${MONTH_END}','yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM-dd') <= '${MONTH_START}' ))) u
 --买卖中介服务费新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmzjfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.store_user_id) mmzjfwfxz
  on u.user_id = mmzjfwfxz.store_user_id
 --买卖卖方中介费新增
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmmfzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '卖方中介费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.store_user_id) mmmfzjfxz
 on u.user_id = mmmfzjfxz.store_user_id
  --买卖贷款服务费新增
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmdkfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.store_user_id) mmdkfwfxz
 on u.user_id = mmdkfwfxz.store_user_id
 --买卖评估费收入新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmpgfsr from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.store_user_id) mmpgfsrxz
 on u.user_id = mmpgfsrxz.store_user_id
 --买卖其他费用新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmqtfy from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.store_user_id) mmqtfyxz
 on u.user_id = mmqtfyxz.store_user_id
 --租赁中介服务费新增
 left join
 (select zlfee.store_user_id,sum(zlfee.price) zlzjfwf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by zlfee.store_user_id) zlzjfwfxz
 on u.user_id = zlzjfwfxz.store_user_id
  --租赁卖方中介费新增
 left join
 (select zlfee.store_user_id,sum(zlfee.price) zlmfzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '卖方中介费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by zlfee.store_user_id) zlmfzjfxz
 on u.user_id = zlmfzjfxz.store_user_id
  --买卖中介服务费结转
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmzjfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.store_user_id) mmzjfwfjz
  on u.user_id = mmzjfwfjz.store_user_id
  --买卖卖方中介费结转
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmmfzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '卖方中介费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.store_user_id) mmmfzjfjz
  on u.user_id = mmmfzjfjz.store_user_id
 --买卖贷款服务费结转
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmdkfwf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.store_user_id) mmdkfwfjz
 on u.user_id = mmdkfwfjz.store_user_id
 --买卖评估费收入结转
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmpgfsr from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.store_user_id) mmpgfsrjz
 on u.user_id = mmpgfsrjz.store_user_id
 --买卖其他费用结转
  left join
 (select mmfee.store_user_id,sum(mmfee.price) mmqtfy from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.store_user_id) mmqtfyjz
 on u.user_id = mmqtfyjz.store_user_id
 --租赁中介服务费结转
 left join
 (select zlfee.store_user_id,sum(zlfee.price) zlzjfwf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price >= 0 group by zlfee.store_user_id) zlzjfwfjz
 on u.user_id = zlzjfwfjz.store_user_id
 --租赁卖方中介费结转
 left join
 (select zlfee.store_user_id,sum(zlfee.price) zlmfzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '卖方中介费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price >= 0 group by zlfee.store_user_id) zlmfzjfjz
 on u.user_id = zlmfzjfjz.store_user_id
 where u.deptname like '%${text}%'
 ${if(len(pro_name)==0,"",
	"and (u.username= '"+pro_name+
	"' or u.deptname ='"+ pro_name+
	"' or u.daquname ='"+ pro_name+
	"')")
	}
 and   (u.job_name = '店经理' 
        or  mmzjfwfxz.mmzjfwf != 0
        or  mmmfzjfxz.mmmfzjf != 0
        or  mmdkfwfxz.mmdkfwf != 0
        or  mmpgfsrxz.mmpgfsr != 0
        or  mmqtfyxz.mmqtfy   != 0
        or  zlzjfwfxz.zlzjfwf != 0
        or  zlmfzjfxz.zlmfzjf != 0
        or  mmzjfwfjz.mmzjfwf != 0
        or  mmmfzjfjz.mmmfzjf != 0
        or  mmdkfwfjz.mmdkfwf != 0
        or  mmpgfsrjz.mmpgfsr != 0
        or  mmqtfyjz.mmqtfy   != 0
        or  zlzjfwfjz.zlzjfwf != 0
        or  zlmfzjfjz.zlmfzjf != 0)
 order by u.nameall,u.deptname