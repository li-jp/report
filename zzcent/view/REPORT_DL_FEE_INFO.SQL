create or replace view report_dl_fee_info as
select detail.price ,detail.user_id,detail.store_user_id,detail.area_user_id,detail.input_date,detail.proportion,fee.fee_name, dlht.review_date , detail.reason, dlht.contract_code, dlht.handwriting_code, dlht.deal_date,dlht.contract_online_date from new_fin_profit_detail detail left join  biz_contract_fee fee on detail.fee_id =fee.id left join biz_building_contract dlht on fee.contract_id =dlht.id
where detail.status = '已分成' and fee.contract_type = '新房' and dlht.status = '已审核'
and detail.is_rec =0 and detail.price!=0 and fee.is_rec =0 and dlht.is_rec =0;
