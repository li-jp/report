
select ${col} from(
select --p.name as "片区",
--d.name as "店面",
--u.username as "姓名",
 ${if(FIND("片区",col)>0,'p.name as "片区",',"")}
 	
	${if(find("店面",col)>0,'d.name as "店面",',"")}
	
	${if(find("姓名",col)>0,'u.username as "姓名",',"")}
--u.dimission as "是否离职",
sum(mmfy.mmfy_num) as "买卖房源",
sum(zlfy.zlfy_num) as "租赁房源",
sum(mmky.mmky_num) as "买卖客源",
sum(zlky.zlky_num) as "租赁客源",
sum(mmdk.mmdk_num) as "买卖带看",
sum(mmkk.mmkk_num) as "买卖空看",
sum(mmfyhf.mmfyhf_num) as"买卖房源回访",
sum(mmkyhf.mmkyhf_num) as "买卖客源回访",
sum(zldk.zldk_num) as "租赁带看",
sum(zlkk.zlkk_num) as "租赁空看",
sum(zlfyhf.zlfyhf_num) as "租赁房源回访",
sum(zlkyhf.zlkyhf_num) as "租赁客源回访",
sum(mmht.mmth_num) as "买卖合同",
sum(zlht.zlth_num) as "租赁合同",
sum(thcz.thcz_num) as "通话次数"，
sum(xsht.xsht_num) as "限时合同",
${if(find("是否锁定",col)>0,'u.locked as "是否锁定",',"")}

1
from sys_user u 
left join sys_department d on u.dept_id = d.id
left join sys_department p on p.id = d.pianqu_id
left join  (select count(z.id) mmfy_num,z.duty_user_id from biz_mmfy z where z.is_rec =0
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.duty_user_id) mmfy on mmfy.duty_user_id = u.id
left join  (select count(z.id) zlfy_num,z.input_user_id from biz_zlfy z where z.is_rec =0 
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) zlfy on zlfy.input_user_id = u.id
left join  (select count(z.id) mmky_num,z.duty_user_id from biz_mmfy_customer z where z.is_rec =0 
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.duty_user_id) mmky on mmky.duty_user_id = u.id
left join  (select count(z.id) zlky_num,z.duty_user_id from biz_zlfy_customer z where z.is_rec =0 
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.duty_user_id) zlky on zlky.duty_user_id = u.id
left join  (select count(z.id) mmdk_num,z.input_user_id from biz_watch_link z where z.is_rec =0 and z.type='200300'
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) mmdk on mmdk.input_user_id = u.id
left join  (select count(z.id) mmkk_num,z.input_user_id from biz_watch_link z where z.is_rec =0 and z.type='200100' 
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) mmkk on mmkk.input_user_id = u.id
left join  (select count(z.id) mmfyhf_num,z.input_user_id from biz_visit_link z where z.is_rec =0 and z.type='100100' 
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) mmfyhf on mmfyhf.input_user_id = u.id
left join  (select count(z.id) mmkyhf_num,z.input_user_id from biz_visit_link z where z.is_rec =0 and z.type='300100'
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) mmkyhf on mmkyhf.input_user_id = u.id
left join  (select count(z.id) zldk_num,z.input_user_id from biz_watch_link z where z.is_rec =0 and z.type='600300'
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) zldk on zldk.input_user_id = u.id
left join  (select count(z.id) zlkk_num,z.input_user_id from biz_watch_link z where z.is_rec =0 and z.type='600100' 
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) zlkk on zlkk.input_user_id = u.id
left join  (select count(z.id) zlfyhf_num,z.input_user_id from biz_visit_link z where z.is_rec =0 and z.type='500100' 
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) zlfyhf on zlfyhf.input_user_id = u.id
left join  (select count(z.id) zlkyhf_num,z.input_user_id from biz_visit_link z where z.is_rec =0 and z.type='700100' 
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) zlkyhf on zlkyhf.input_user_id = u.id
left join  (select count(z.id) mmth_num,z.duty_user_id from biz_mm_contract z where z.is_rec =0
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}' 
group by z.duty_user_id) mmht on mmht.duty_user_id = u.id
left join  (select count(z.id) zlth_num,z.duty_user_id from biz_zl_contract z where z.is_rec =0 and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}' 
group by z.duty_user_id) zlht on zlht.duty_user_id = u.id
left join  (select count(distinct  z.callid) thcz_num,z.input_user_id from sys_call_hangup z

where
 to_char(z.starttime,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.starttime,'yyyy-MM-dd') <='${end_date}'
group by z.input_user_id) thcz on thcz.input_user_id = u.id
left join (select  count(z.id) xsht_num,z.input_user from BIZ_MMFY_ETLS_CONTRACT z where z.is_rec=0  and (z.status ='已审核' or z.status='待审核')
and to_char(z.input_date,'yyyy-MM-dd') >='${stat_date}'
and to_char(z.input_date,'yyyy-MM-dd') <='${end_date}' 
group by z.input_user) xsht on xsht.input_user = u.id
where u.is_rec =0
and d.is_rec =0
and p.is_rec=0
${if(locked==1,"","and locked=0")}
and (u.username like '%${name}%'
	or d.name like '%${name}%'
	or p.name like '%${name}%'
	)
${if(len(pro_name)==0,"",
	"and (u.username= '"+pro_name+
	"' or d.name ='"+ pro_name+
	"' or p.name ='"+ pro_name+
	"')")
	}
	group by ${if(FIND("片区",col)>0,"p.name,","")}
	${if(find("店面",col)>0,"d.name,","")}
	${if(find("姓名",col)>0,"u.username,","")}
	${if(find("是否锁定",col)>0,"u.locked,","")}
	
	1
order by  ${if(FIND("片区",col)>0,"p.name,","")}
	${if(find("店面",col)>0,"d.name,","")}
	${if(find("姓名",col)>0,"u.username,","")}
	${if(find("是否锁定",col)>0,"u.locked,","")}
	
	1
)
 