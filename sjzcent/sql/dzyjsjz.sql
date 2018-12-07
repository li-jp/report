select u.*,mmzjxz.mmzjf as 买卖中介服务费新增,mmdkxz.mmdkf as 买卖贷款服务费新增,mmpgxz.mmpgf as 买卖评估费提成新增,mmqtxz.mmqt as 买卖其他费用新增,zlzjxz.zlzjf as 租赁中介服务费新增,zlqtxz.zlqt as 租赁其他费用新增,mmzjjz.mmzjf as 买卖中介服务费结转,mmdkjz.mmdkf as 买卖贷款服务费结转,mmpgjz.mmpgf as 买卖评估费提成结转,mmqtjz.mmqt as 买卖其他费用结转,zlzjjz.zlzjf as 租赁中介服务费结转,zlqtjz.zlqt as 租赁其他费用结转 
from 
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房事业部%' or usr.username ='不算个人业绩'） and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date('${MONTH_END}','yyyy-MM-dd')-usr.Dimission_Date) <=35) or usr.status = '在职')) u 
 --买卖中介服务费新增
 left join
 (select mmfee.store_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.store_user_id) mmzjxz
  on u.user_id = mmzjxz.store_user_id
 --买卖贷款服务费新增
 left join 
  (select mmfee.store_user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.store_user_id) mmdkxz
 on u.user_id = mmdkxz.store_user_id
 --买卖评估费新增
 left join 
 (select mmfee.store_user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.store_user_id) mmpgxz
 on u.user_id = mmpgxz.store_user_id
 --买卖其他费用新增
  left join 
 (select mmfee.store_user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by mmfee.store_user_id) mmqtxz
 on u.user_id = mmqtxz.store_user_id
 --租赁中介服务费新增
 left join 
 (select zlfee.store_user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by zlfee.store_user_id) zlzjxz
 on u.user_id = zlzjxz.store_user_id
 --租赁其他费用新增
  left join 
 (select zlfee.store_user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' group by zlfee.store_user_id) zlqtxz
 on u.user_id = zlqtxz.store_user_id
  --买卖中介服务费结转
 left join
  (select mmfee.store_user_id,sum(mmfee.price) mmzjf from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.store_user_id) mmzjjz
  on u.user_id = mmzjjz.store_user_id
 --买卖贷款服务费结转
 left join 
  (select mmfee.store_user_id,sum(mmfee.price) mmdkf from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.store_user_id) mmdkjz
 on u.user_id = mmdkjz.store_user_id
 --买卖评估费结转
 left join 
 (select mmfee.store_user_id,sum(mmfee.price) mmpgf from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.store_user_id) mmpgjz
 on u.user_id = mmpgjz.store_user_id
 --买卖其他费用结转
  left join 
 (select mmfee.store_user_id,sum(mmfee.price) mmqt from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price >= 0 group by mmfee.store_user_id) mmqtjz
 on u.user_id = mmqtjz.store_user_id
 --租赁中介服务费结转
 left join 
 (select zlfee.store_user_id,sum(zlfee.price) zlzjf from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price >= 0  group by zlfee.store_user_id) zlzjjz
 on u.user_id = zlzjjz.store_user_id
 --租赁其他费用结转
  left join 
 (select zlfee.store_user_id,sum(zlfee.price) zlqt from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price >= 0  group by zlfee.store_user_id) zlqtjz
 on u.user_id = zlqtjz.store_user_id
 where (u.deptname like '%${text}%' OR U.DAQUNAME LIKE '%${text}%' OR U.USERNAME LIKE '%${text}%')
 ${if(len(pro_name)==0,"",
	"and (u.username= '"+pro_name+
	"' or u.deptname ='"+ pro_name+
	"' or u.daquname ='"+ pro_name+
	"')")
	}
 and   (u.job_name = '店经理' 
        or  mmzjxz.mmzjf != 0
        or  mmdkxz.mmdkf != 0
        or  mmpgxz.mmpgf != 0
        or  mmqtxz.mmqt  != 0
        or  zlzjxz.zlzjf != 0
        or  zlqtxz.zlqt  != 0
        or  mmzjjz.mmzjf != 0
        or  mmdkjz.mmdkf != 0
        or  mmpgjz.mmpgf != 0
        or  mmqtjz.mmqt  != 0
        or  zlzjjz.zlzjf != 0
        or  zlqtjz.zlqt  != 0)
 --and   (u.user_id like '%${id}%' or u.dept_id like '%${id}%' or u.pianqu_id like '%${id}%')
 order by u.nameall,u.deptname