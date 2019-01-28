create or replace view report_zl_fee_info as
select fee.review_date fee_review_date, detail.price ,detail.user_id,detail.store_user_id,detail.area_user_id,detail.input_date,detail.proportion,fee.fee_name,fee.receipt_number, zlht.review_date , detail.reason, zlht.contract_code, zlht.handwriting_code, zlht.deal_date
from new_fin_profit_detail detail
left join  biz_contract_fee fee on detail.fee_id =fee.id
left join biz_zl_contract zlht on fee.contract_id =zlht.id
where detail.status = '已分成' and fee.contract_type = '租赁' and zlht.status = '已审核'
and detail.is_rec =0 and detail.price!=0 and fee.is_rec =0 and zlht.is_rec =0;
