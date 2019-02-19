t_mm_fee_info as
select detail.price ,detail.user_id,detail.store_user_id,detail.area_user_id,detail.input_date,detail.proportion,fee.fee_name, fee.receipt_number, fee.rachel_date, mmht.review_date, mmht.Early_Profit_Date, detail.reason, mmht.contract_code, mmht.handwriting_code, mmht.deal_date, loan.trloan_end
from new_fin_profit_detail detail
left join  biz_contract_fee fee on detail.fee_id =fee.id
left join biz_mm_contract mmht on fee.contract_id =mmht.id
left join biz_trloan loan on loan.contract_id = mmht.id and loan.status = '有效' and loan.is_rec = 0
where detail.status = '已分成' and fee.contract_type = '买卖' and mmht.status = '已审核'
and detail.is_rec =0 and detail.price!=0 and fee.is_rec =0 and mmht.is_rec =0;