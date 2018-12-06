create or replace view new_fin_contract_view as
(
(select t.id,
'买卖' contract_type,
t.if_limit,
m.code,
t.address,
t.ky_id,
c.code customer_code,
t.build_area,
t.contract_code,
t.deal_date,
t.company_deposit,
t.deal_dept_id,
t.deal_user_id,
t.deal_price,-- 成交价

t.duty_user_id,
t.input_user_id,
t.handwriting_code,
t.house_type,
t.is_rec,

t.key_dept_id,
t.key_user_id,

t.fy_id,
t.fy_user_id,
t.fy_dept_id,

t.photo_dept_id,
t.photo_user_id,
t.remarks,
t.status,
--nvl(m.vat,m.SUPPLEMENTARY_TAX) tax,
m.matching support,
mr.receivable
from BIZ_MM_CONTRACT t
join biz_mmfy_customer c on t.ky_id = c.id and c.is_rec = 0
join biz_mmfy m on m.id = t.fy_id and t.is_rec = 0
join BIZ_CONTRACT_RECEIVABLE mr on mr.contract_id = t.id and mr.is_rec = 0 and mr.fee_type = '中介服务费'
)
union
(select t.id,
'租赁' contract_type,
'' if_limit,
z.code,
t.address,
t.ky_id,
c.code customer_code,
t.build_area,
t.contract_code,
t.deal_date,
t.deposit company_deposit,--押金

t.deal_dept_id,
t.deal_user_id,
t.price deal_price,--单价
--t.deal_price,-- 成交租金

t.duty_user_id,
t.input_user_id,
t.handwriting_code,
t.house_type,
t.is_rec,
t.key_dept_id,
t.key_user_id,
t.fy_id,
t.fy_user_id,
t.fy_dept_id,
t.pic_dept_id photo_dept_id,
t.pic_user_id photo_user_id,

t.remarks,
t.status,

--t.input_date,

--t.pay_type,


--nvl(z.vat,z.SUPPLEMENTARY_TAX) tax,
z.supporting support,
zr.receivable
from biz_zl_contract t
join biz_zlfy_customer c on t.ky_id = c.id and c.is_rec = 0
join biz_zlfy z on z.id = t.fy_id and t.is_rec = 0
join BIZ_CONTRACT_RECEIVABLE zr on zr.contract_id = t.id and zr.is_rec = 0 and zr.fee_type = '中介服务费'
)
union
(select t.id,
'高租' contract_type,
'' if_limit,
z.code,
t.address,
t.ky_id,
c.code customer_code,
t.build_area,
t.contract_code,
t.deal_date,
t.deposit company_deposit,--押金

t.deal_dept_id,
t.deal_user_id,
t.price deal_price,--单价
--t.deal_price,-- 成交租金

t.duty_user_id,
t.input_user_id,
t.handwriting_code,
t.house_type,
t.is_rec,
t.key_dept_id,
t.key_user_id,
t.fy_id,
t.fy_user_id,
t.fy_dept_id,
t.pic_dept_id photo_dept_id,
t.pic_user_id photo_user_id,

t.remarks,
t.status,

--t.input_date,

--t.pay_type,


--nvl(z.vat,z.SUPPLEMENTARY_TAX) tax,
z.supporting support,
zr.receivable
from biz_upzl_contract t
join biz_zlfy_customer c on t.ky_id = c.id and c.is_rec = 0
join biz_upzlfy z on z.id = t.fy_id and t.is_rec = 0
join BIZ_CONTRACT_RECEIVABLE zr on zr.contract_id = t.id and zr.is_rec = 0 and zr.fee_type = '中介服务费'
)
);
