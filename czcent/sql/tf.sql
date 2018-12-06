select u.*,mmzjxz.mmzjf as 买卖中介服务费新增,mmzjxz.contract_code as 买卖中介服务费新增合同编号, mmzjxz.handwriting_code as 买卖中介服务费新增手写编号, mmzjxz.deal_date as 买卖中介服务费新增成单时间, mmmfzjxz.mmmfzjf as 买卖卖方中介费新增,mmmfzjxz.contract_code as 买卖卖方中介费新增合同编号, mmmfzjxz.handwriting_code as 买卖卖方中介费新增手写编号, mmmfzjxz.deal_date as 买卖卖方中介费新增成单时间, mmdkxz.mmdkf as 买卖贷款服务费新增, mmdkxz.contract_code as 买卖贷款服务费新增合同编号, mmdkxz.handwriting_code as 买卖贷款服务费新增手写编号, mmdkxz.deal_date as 买卖贷款服务费新增成单时间, mmpgxz.mmpgf as 买卖评估费提成新增, mmpgxz.contract_code as 买卖评估费提成新增合同编号 , mmpgxz.handwriting_code as 买卖评估费提成新增手写编号, mmpgxz.deal_date as 买卖评估费提成新增成单时间, mmqtxz.mmqt as 买卖其他费用新增, mmqtxz.contract_code as 买卖其他费用新增合同编号, mmqtxz.handwriting_code as 买卖其他费用新增手写编号, mmqtxz.deal_date as 买卖其他费用新增成单时间, zlzjxz.zlzjf as 租赁中介服务费新增, zlzjxz.contract_code as 租赁中介服务费新增合同编号, zlzjxz.handwriting_code as 租赁中介服务费新增手写编号, zlzjxz.deal_date as 租赁中介服务费新增成单时间,zlmfzjxz.zlmfzjf as 租赁卖方中介费新增, zlmfzjxz.contract_code as 租赁卖方中介费新增合同编号, zlmfzjxz.handwriting_code as 租赁卖方中介费新增手写编号, zlmfzjxz.deal_date as 租赁卖方中介费新增成单时间, zlqtxz.zlqt as 租赁其他费用新增, zlqtxz.contract_code as 租赁其他费用新增合同编号, zlqtxz.handwriting_code as 租赁其他费用新增手写编号, zlqtxz.deal_date as 租赁其他费用新增成单时间, mmzjjz.mmzjf as 买卖中介服务费结转, mmzjjz.contract_code as 买卖中介服务费结转合同编号, mmzjjz.handwriting_code as 买卖中介服务费结转手写编号, mmzjjz.deal_date as 买卖中介服务费结转成单时间,mmmfzjjz.mmmfzjf as 买卖卖方中介费结转,mmmfzjjz.contract_code as 买卖卖方中介费结转合同编号, mmmfzjjz.handwriting_code as 买卖卖方中介费结转手写编号, mmmfzjjz.deal_date as 买卖卖方中介费结转成单时间, mmdkjz.mmdkf as 买卖贷款服务费结转,  mmdkjz.contract_code as 买卖贷款服务费结转合同编号, mmdkjz.handwriting_code as 买卖贷款服务费结转手写编号, mmdkjz.deal_date as 买卖贷款服务费结转成单时间, mmpgjz.mmpgf as 买卖评估费提成结转,mmpgjz.contract_code as 买卖评估费提成结转合同编号, mmpgjz.handwriting_code as 买卖评估费提成结转手写编号, mmpgjz.deal_date as 买卖评估费提成结转成单时间, mmqtjz.mmqt as 买卖其他费用结转,mmqtjz.contract_code as 买卖其他费用结转合同编号, mmqtjz.handwriting_code as 买卖其他费用结转手写编号, mmqtjz.deal_date as 买卖其他费用结转成单时间, zlzjjz.zlzjf as 租赁中介服务费结转, zlzjjz.contract_code as 租赁中介服务费结转合同编号, zlzjjz.handwriting_code as 租赁中介服务费结转手写编号, zlzjjz.deal_date as 租赁中介服务费结转成单时间,zlmfzjjz.zlmfzjf as 租赁卖方中介费结转, zlmfzjjz.contract_code as 租赁卖方中介费结转合同编号, zlmfzjjz.handwriting_code as 租赁卖方中介费结转手写编号, zlmfzjjz.deal_date as 租赁卖方中介费结转成单时间, zlqtjz.zlqt as 租赁其他费用结转 ,zlqtjz.contract_code as 租赁其他费用结转合同编号, zlqtjz.handwriting_code as 租赁其他费用结转手写编号, zlqtjz.deal_date as 租赁其他费用结转成单时间 
from 
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房事业部%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date('${MONTH_END}','yyyy-MM-dd')-usr.Dimission_Date) <=35) or usr.status = '在职')) u 
 --买卖中介服务费新增
 left join
 (select mmfee.user_id, mmfee.price mmzjf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmzjxz
  on u.user_id = mmzjxz.user_id
   --买卖卖方中介费新增
 left join
 (select mmfee.user_id, mmfee.price mmmfzjf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '卖方中介费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmmfzjxz
  on u.user_id = mmmfzjxz.user_id
 --买卖贷款服务费新增
 left join 
  (select mmfee.user_id, mmfee.price mmdkf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmdkxz
 on u.user_id = mmdkxz.user_id
 --买卖评估费新增
 left join 
 (select mmfee.user_id, mmfee.price mmpgf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmpgxz
 on u.user_id = mmpgxz.user_id
 --买卖其他费用新增
 left join 
 (select mmfee.user_id, mmfee.price mmqt, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmqtxz
 on u.user_id = mmqtxz.user_id
 --租赁中介服务费新增
 left join 
 (select zlfee.user_id, zlfee.price zlzjf, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id, zlfee.price , zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlzjxz
 on u.user_id = zlzjxz.user_id
  --租赁卖方中介费新增
 left join 
 (select zlfee.user_id, zlfee.price zlmfzjf, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '卖方中介费' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id, zlfee.price , zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlmfzjxz
 on u.user_id = zlmfzjxz.user_id
 --租赁其他费用新增
  left join 
 (select zlfee.user_id, zlfee.price zlqt, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.review_date,'yyyy-MM-dd') <= '${MONTH_END}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id, zlfee.price, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlqtxz
 on u.user_id = zlqtxz.user_id
  --买卖中介服务费结转
 left join
  (select mmfee.user_id, mmfee.price mmzjf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '中介服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmzjjz
  on u.user_id = mmzjjz.user_id
   --买卖卖方中介费结转
 left join
 (select mmfee.user_id, mmfee.price mmmfzjf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '卖方中介费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmmfzjjz
  on u.user_id = mmmfzjjz.user_id
 --买卖贷款服务费结转
 left join 
  (select mmfee.user_id, mmfee.price mmdkf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '贷款服务费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmdkjz
 on u.user_id = mmdkjz.user_id
 --买卖评估费结转
 left join 
 (select mmfee.user_id, mmfee.price mmpgf, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '评估费' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmpgjz
 on u.user_id = mmpgjz.user_id
 --买卖其他费用结转
  left join 
 (select mmfee.user_id, mmfee.price mmqt, mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date from report_mm_fee_info mmfee  where mmfee.fee_name = '其他费用' and to_char(mmfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(mmfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and mmfee.price <= 0 group by mmfee.user_id, mmfee.price , mmfee.contract_code, mmfee.handwriting_code, mmfee.deal_date) mmqtjz
 on u.user_id = mmqtjz.user_id
 --租赁中介服务费结转
 left join 
 (select zlfee.user_id,zlfee.price zlzjf, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '中介服务费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id,zlfee.price , zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlzjjz
 on u.user_id = zlzjjz.user_id
   --租赁卖方中介费结转
 left join 
 (select zlfee.user_id, zlfee.price zlmfzjf, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '卖方中介费' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id, zlfee.price , zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlmfzjjz
 on u.user_id = zlmfzjjz.user_id
 --租赁其他费用结转
  left join 
 (select zlfee.user_id,zlfee.price zlqt, zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date from report_zl_fee_info zlfee  where zlfee.fee_name = '其他费用' and to_char(zlfee.review_date,'yyyy-MM-dd') < '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') >= '${MONTH_START}' and to_char(zlfee.input_date,'yyyy-MM-dd') <= '${MONTH_END}' and zlfee.price <= 0 group by zlfee.user_id,zlfee.price , zlfee.contract_code, zlfee.handwriting_code, zlfee.deal_date) zlqtjz
 on u.user_id = zlqtjz.user_id
 where u.deptname like '%${text}%'
  ${if(len(pro_name)==0,"",
	"and (u.username= '"+pro_name+
	"' or u.deptname ='"+ pro_name+
	"' or u.daquname ='"+ pro_name+
	"')")
	}
 --and   (u.user_id = '${id}' or u.dept_id = '${id}' or u.pianqu_id = '${id}')
 order by u.nameall,u.deptname
 