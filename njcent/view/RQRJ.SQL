create or replace view rqrj as
select u."USER_ID",u."USERNAME",u."JOB_NAME",u."STATUS",u."INDUCTION_TIME",u."STAR_LEVEL",u."DEPT_ID",u."DEPTNAME",u."NAMEALL",u."DAQUNAME",u."PIANQU_ID",u."DIMISSION_DATE",
NVL(mmzjxz.mmzjf,0) as 买卖到帐中介服务费新增,
NVL(mmdkxz.mmdkf,0) as 买卖到帐贷款服务费新增,
NVL(mmpgxz.mmpgf,0) as 买卖到帐评估费提成新增,
NVL(mmqtxz.mmqt,0) as 买卖到帐其他费用新增,
NVL(mmdzxz.mmdz,0) as 买卖到帐垫资服务费新增,
NVL(mmdbghfxz.mmdbghf,0) as 买卖到帐代办过户费新增,
NVL(mmmfzjfxz.mmmfzjf,0) as 买卖到帐卖方中介费新增,
NVL(mmpgfsrxz.mmpgfsr,0) as 买卖到帐评估费收入新增,
(NVL(mmzjxz.mmzjf,0)+NVL(mmdkxz.mmdkf,0)+NVL(mmpgxz.mmpgf,0)+NVL(mmqtxz.mmqt,0)+NVL(mmdzxz.mmdz,0)+NVL(mmdbghfxz.mmdbghf,0)+NVL(mmmfzjfxz.mmmfzjf,0)+NVL(mmpgfsrxz.mmpgfsr,0)) as 买卖到账值新增,

NVL(zlzjxz.zlzjf,0) as 租赁到帐中介服务费新增,
NVL(zlmfzjfxz.zlmfzjf,0) as 租赁到帐卖方中介费新增,
NVL(zlqtxz.zlqt,0) as 租赁到帐其他费用新增,
(NVL(zlzjxz.zlzjf,0)+NVL(zlmfzjfxz.zlmfzjf,0)+NVL(zlqtxz.zlqt,0)) AS 租赁到账值新增,

/*NVL(dlzjfxz.dlzjf,0) as 代理到帐中介服务费新增,*/

NVL(mmzjjz.mmzjf,0) as 买卖到帐中介服务费结转,
NVL(mmdkjz.mmdkf,0) as 买卖到帐贷款服务费结转,
NVL(mmpgjz.mmpgf,0) as 买卖到帐评估费提成结转,
NVL(mmqtjz.mmqt,0) as 买卖到帐其他费用结转,
NVL(mmdzjz.mmdz,0) as 买卖到帐垫资服务费结转,
NVL(mmdbghfjz.mmdbghf,0) as 买卖到帐代办过户费结转,
NVL(mmmfzjfjz.mmmfzjf,0) as 买卖到帐卖方中介费结转,
NVL(mmpgfsrjz.mmpgfsr,0) as 买卖到帐评估费收入结转,
(NVL(mmzjjz.mmzjf,0)+NVL(mmdkjz.mmdkf,0)+NVL(mmpgjz.mmpgf,0)+NVL(mmqtjz.mmqt,0)+NVL(mmdzjz.mmdz,0)+NVL(mmdbghfjz.mmdbghf,0)+NVL(mmmfzjfjz.mmmfzjf,0)+NVL(mmpgfsrjz.mmpgfsr,0)) as 买卖到账值结转,

NVL(zlzjjz.zlzjf,0) as 租赁到帐中介服务费结转,
NVL(zlmfzjfjz.zlmfzjf,0) as 租赁到帐卖方中介费结转,
NVL(zlqtjz.zlqt,0) as 租赁到帐其他费用结转,
(NVL(zlzjjz.zlzjf,0)+NVL(zlmfzjfjz.zlmfzjf,0)+NVL(zlqtjz.zlqt,0)) AS 租赁到账值结转,

/*NVL(dlzjfjz.dlzjf,0) as 代理到帐中介服务费结转,*/
(NVL(mmzjxz.mmzjf,0)+NVL(mmdkxz.mmdkf,0)+NVL(mmpgxz.mmpgf,0)+NVL(mmqtxz.mmqt,0)+NVL(mmdzxz.mmdz,0)+NVL(mmdbghfxz.mmdbghf,0)+NVL(mmmfzjfxz.mmmfzjf,0)+NVL(mmpgfsrxz.mmpgfsr,0)
+NVL(mmzjjz.mmzjf,0)+NVL(mmdkjz.mmdkf,0)+NVL(mmpgjz.mmpgf,0)+NVL(mmqtjz.mmqt,0)+NVL(mmdzjz.mmdz,0)+NVL(mmdbghfjz.mmdbghf,0)+NVL(mmmfzjfjz.mmmfzjf,0)+NVL(mmpgfsrjz.mmpgfsr,0)) as 买卖到账值,
(NVL(zlzjxz.zlzjf,0)+NVL(zlmfzjfxz.zlmfzjf,0)+NVL(zlqtxz.zlqt,0)
+NVL(zlzjjz.zlzjf,0)+NVL(zlmfzjfjz.zlmfzjf,0)+NVL(zlqtjz.zlqt,0)) as 租赁到账值,
/*(NVL(dlzjfxz.dlzjf,0)
+NVL(dlzjfjz.dlzjf,0)) as 代理到账值,*/
(NVL(mmzjxz.mmzjf,0)+NVL(mmdkxz.mmdkf,0)+NVL(mmpgxz.mmpgf,0)+NVL(mmqtxz.mmqt,0)+NVL(mmdzxz.mmdz,0)+NVL(mmdbghfxz.mmdbghf,0)+NVL(mmmfzjfxz.mmmfzjf,0)+NVL(mmpgfsrxz.mmpgfsr,0)
+NVL(mmzjjz.mmzjf,0)+NVL(mmdkjz.mmdkf,0)+NVL(mmpgjz.mmpgf,0)+NVL(mmqtjz.mmqt,0)+NVL(mmdzjz.mmdz,0)+NVL(mmdbghfjz.mmdbghf,0)+NVL(mmmfzjfjz.mmmfzjf,0)+NVL(mmpgfsrjz.mmpgfsr,0)
+NVL(zlzjxz.zlzjf,0)+NVL(zlmfzjfxz.zlmfzjf,0)+NVL(zlqtxz.zlqt,0)
+NVL(zlzjjz.zlzjf,0)+NVL(zlmfzjfjz.zlmfzjf,0)+NVL(zlqtjz.zlqt,0)
/*+NVL(dlzjfxz.dlzjf,0)
+NVL(dlzjfjz.dlzjf,0)*/ ) as 到账值合计,

NVL(MMHTZJ.MMHTZJ,0) AS 买卖合同中介服务费,
NVL(MMHTDK.MMHTDK,0) AS 买卖合同贷款服务费,
NVL(MMHTPGFTC.MMHTPGFTC,0) AS 买卖合同评估费提成,
NVL(MMHTPGFSR.MMHTPGFSR,0) AS 买卖合同评估费收入,
NVL(MMHTDBGHF.MMHTDBGHF,0) as 买卖合同代办过户费,
NVL(MMHTQTFY.MMHTQTFY,0)   AS 买卖合同其他费用,
NVL(MMHTMFZJF.MMHTMFZJF,0) AS 买卖合同卖方中介费,
(NVL(MMHTZJ.MMHTZJ,0)+NVL(MMHTDK.MMHTDK,0)+NVL(MMHTPGFTC.MMHTPGFTC,0)+NVL(MMHTPGFSR.MMHTPGFSR,0)+NVL(MMHTDBGHF.MMHTDBGHF,0)+NVL(MMHTQTFY.MMHTQTFY,0)+NVL(MMHTMFZJF.MMHTMFZJF,0)) as 买卖合同值,

NVL(ZLHTZJFWF.ZLHTZJFWF,0) AS 租赁合同中介服务费,
NVL(ZLHTMFZJF.ZLHTMFZJF,0) AS 租赁合同卖方中介费,
(NVL(ZLHTZJFWF.ZLHTZJFWF,0)+NVL(ZLHTMFZJF.ZLHTMFZJF,0)) as 租赁合同值,

/*NVL(DLHTZJFWF.DLHTZJFWF,0) AS 代理合同中介服务费,*/

(NVL(MMHTZJ.MMHTZJ,0)+NVL(MMHTDK.MMHTDK,0)+NVL(MMHTPGFTC.MMHTPGFTC,0)+NVL(MMHTPGFSR.MMHTPGFSR,0)+NVL(MMHTDBGHF.MMHTDBGHF,0)+NVL(MMHTQTFY.MMHTQTFY,0)+NVL(MMHTMFZJF.MMHTMFZJF,0)
+NVL(ZLHTZJFWF.ZLHTZJFWF,0)+NVL(ZLHTMFZJF.ZLHTMFZJF,0)
/*+NVL(DLHTZJFWF.DLHTZJFWF,0)*/) as 合同值合计,

NVL(MMHT.MMHT,0) AS 买卖新增套数,
NVL(ZLHT.ZLHT,0) AS 租赁新增套数/*,
NVL(DLHT.DLHT,0) AS 代理新增套数*/
from
 (select usr.* from report_user_dept_info usr where (usr.nameall like '%二手房事业部%' or usr.username ='不算个人业绩') and usr.deptname <>'金融权证' and ((usr.status = '离职' and (to_date(to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd'),'yyyy-MM-dd')-to_date(to_char(usr.Dimission_Date,'yyyy-MM-dd'),'yyyy-MM-dd') <=35)) or (usr.status = '在职' and to_char(usr.induction_time,'yyyy-MM') <= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') ))) u
 --买卖到账中介服务费新增
 left join
 (select
	mmfee.user_id,
	sum(mmfee.price) mmzjf
from report_mm_fee_info mmfee
	where mmfee.fee_name = '中介服务费'
	and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
	and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
	and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
	and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
	group by mmfee.user_id) mmzjxz
 on u.user_id = mmzjxz.user_id

 --买卖到账贷款服务费新增
 left join
  (select
	mmfee.user_id,sum(mmfee.price) mmdkf
from report_mm_fee_info mmfee
	where mmfee.fee_name = '贷款服务费'
	and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
	and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
	and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
	and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
	group by mmfee.user_id) mmdkxz
 on u.user_id = mmdkxz.user_id

 --买卖到账评估费提成新增
 left join
 (select
	mmfee.user_id,
	sum(mmfee.price) mmpgf
from report_mm_fee_info mmfee
	where mmfee.fee_name = '评估费'
	and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
	and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
	and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
	and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
	group by mmfee.user_id) mmpgxz
 on u.user_id = mmpgxz.user_id

 --买卖到账其他费用新增
 left join
 (select
mmfee.user_id,
sum(mmfee.price) mmqt
 from report_mm_fee_info mmfee
 where mmfee.fee_name = '其他费用'
and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
group by mmfee.user_id) mmqtxz
 on u.user_id = mmqtxz.user_id

  --买卖到账垫资服务费新增
 left join
 (select
mmfee.user_id,
sum(mmfee.price) mmdz
 from report_mm_fee_info mmfee
 where mmfee.fee_name = '垫资服务费'
and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
 group by mmfee.user_id) mmdzxz
 on u.user_id = mmdzxz.user_id

  --买卖到帐代办过户费新增
 left join
 (select
mmfee.user_id,
sum(mmfee.price) mmdbghf
 from report_mm_fee_info mmfee
where mmfee.fee_name = '代办过户费'
and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
 and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
group by mmfee.user_id) mmdbghfxz
  on u.user_id = mmdbghfxz.user_id

   --买卖到帐卖方中介费新增
 left join
  (select
mmfee.user_id,
sum(mmfee.price) mmmfzjf
from report_mm_fee_info mmfee
where mmfee.fee_name = '卖方中介费'
and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
group by mmfee.user_id) mmmfzjfxz
 on u.user_id = mmmfzjfxz.user_id

  --买卖到帐评估费收入新增
 left join
 (select
mmfee.user_id,
sum(mmfee.price) mmpgfsr
 from report_mm_fee_info mmfee
where mmfee.fee_name = '评估费收入'
and to_char(mmfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
group by mmfee.user_id) mmpgfsrxz
 on u.user_id = mmpgfsrxz.user_id

 --租赁到账中介服务费新增
 left join
 (select
zlfee.user_id,
sum(zlfee.price) zlzjf
from report_zl_fee_info zlfee
where zlfee.fee_name = '中介服务费'
and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
and to_char(zlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
group by zlfee.user_id) zlzjxz
 on u.user_id = zlzjxz.user_id

  --租赁到帐卖方中介费新增
 left join
 (select
zlfee.user_id,
sum(zlfee.price) zlmfzjf
 from report_zl_fee_info zlfee
where zlfee.fee_name = '卖方中介费'
and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
and to_char(zlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
group by zlfee.user_id) zlmfzjfxz
 on u.user_id = zlmfzjfxz.user_id

 --租赁到账其他费用新增
  left join
 (select
zlfee.user_id,
sum(zlfee.price) zlqt
from report_zl_fee_info zlfee
 where zlfee.fee_name = '其他费用'
and to_char(zlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(zlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')
and to_char(zlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
 and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
group by zlfee.user_id) zlqtxz
 on u.user_id = zlqtxz.user_id

 /*--代理到帐中介服务费新增
  left join
 (select
 dlfee.user_id,
sum(dlfee.price) dlzjf
from report_dl_fee_info dlfee
where dlfee.fee_name = '中介服务费'
and to_char(dlfee.review_date,'yyyy-MM-dd') >= concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(dlfee.review_date,'yyyy-MM-dd') <= to_char(last_day(VIEW_DATE.GET_START_DATE),'yyyy-MM-dd')

and to_char(dlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
group by dlfee.user_id) dlzjfxz
 on u.user_id = dlzjfxz.user_id*/

--买卖到账中介服务费结转
 left join
 (select
  mmfee.user_id,
  sum(mmfee.price) mmzjf
from report_mm_fee_info mmfee
  where mmfee.fee_name = '中介服务费'
  and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
  and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
  and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
  and mmfee.price >= 0
  group by mmfee.user_id) mmzjjz
 on u.user_id = mmzjjz.user_id

 --买卖到账贷款服务费结转
 left join
  (select
  mmfee.user_id,sum(mmfee.price) mmdkf
from report_mm_fee_info mmfee
  where mmfee.fee_name = '贷款服务费'
  and to_char(mmfee.review_date,'yyyy-MM-dd')< concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
  and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
  and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
  and mmfee.price >= 0
  group by mmfee.user_id) mmdkjz
 on u.user_id = mmdkjz.user_id

 --买卖到账评估费提成结转
 left join
 (select
  mmfee.user_id,
  sum(mmfee.price) mmpgf
from report_mm_fee_info mmfee
  where mmfee.fee_name = '评估费'
  and to_char(mmfee.review_date,'yyyy-MM-dd')< concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
  and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
  and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
  and mmfee.price >= 0
  group by mmfee.user_id) mmpgjz
 on u.user_id = mmpgjz.user_id

 --买卖到账其他费用结转
 left join
 (select
mmfee.user_id,
sum(mmfee.price) mmqt
 from report_mm_fee_info mmfee
 where mmfee.fee_name = '其他费用'
and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
and mmfee.price >= 0
group by mmfee.user_id) mmqtjz
 on u.user_id = mmqtjz.user_id

  --买卖到账垫资服务费结转
 left join
 (select
mmfee.user_id,
sum(mmfee.price) mmdz
 from report_mm_fee_info mmfee
 where mmfee.fee_name = '垫资服务费'
and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
and mmfee.price >= 0
 group by mmfee.user_id) mmdzjz
 on u.user_id = mmdzjz.user_id

  --买卖到帐代办过户费结转
 left join
 (select
mmfee.user_id,
sum(mmfee.price) mmdbghf
 from report_mm_fee_info mmfee
where mmfee.fee_name = '代办过户费'
and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
 and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
 and mmfee.price >= 0
group by mmfee.user_id) mmdbghfjz
  on u.user_id = mmdbghfjz.user_id

   --买卖到帐卖方中介费结转
 left join
  (select
mmfee.user_id,
sum(mmfee.price) mmmfzjf
from report_mm_fee_info mmfee
where mmfee.fee_name = '卖方中介费'
and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
and mmfee.price >= 0
group by mmfee.user_id) mmmfzjfjz
 on u.user_id = mmmfzjfjz.user_id

  --买卖到帐评估费收入结转
 left join
 (select
mmfee.user_id,
sum(mmfee.price) mmpgfsr
 from report_mm_fee_info mmfee
where mmfee.fee_name = '评估费收入'
and to_char(mmfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(mmfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(mmfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
and mmfee.price >= 0
group by mmfee.user_id) mmpgfsrjz
 on u.user_id = mmpgfsrjz.user_id

 --租赁到账中介服务费结转
 left join
 (select
zlfee.user_id,
sum(zlfee.price) zlzjf
from report_zl_fee_info zlfee
where zlfee.fee_name = '中介服务费'
and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(zlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
and zlfee.price >= 0
group by zlfee.user_id) zlzjjz
 on u.user_id = zlzjjz.user_id

  --租赁到帐卖方中介费结转
 left join
 (select
zlfee.user_id,
sum(zlfee.price) zlmfzjf
 from report_zl_fee_info zlfee
where zlfee.fee_name = '卖方中介费'
and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(zlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
and zlfee.price >= 0
group by zlfee.user_id) zlmfzjfjz
 on u.user_id = zlmfzjfjz.user_id

 --租赁到账其他费用结转
  left join
 (select
zlfee.user_id,
sum(zlfee.price) zlqt
from report_zl_fee_info zlfee
 where zlfee.fee_name = '其他费用'
and to_char(zlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(zlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
 and to_char(zlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
 and zlfee.price >= 0
group by zlfee.user_id) zlqtjz
 on u.user_id = zlqtjz.user_id

 /*--代理到帐中介服务费结转
  left join
 (select
 dlfee.user_id,
sum(dlfee.price) dlzjf
from report_dl_fee_info dlfee
where dlfee.fee_name = '中介服务费'
and to_char(dlfee.review_date,'yyyy-MM-dd') < concat(to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM'),'-01')
and to_char(dlfee.input_date,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd')
and to_char(dlfee.input_date,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd')
and dlfee.price >= 0
group by dlfee.user_id) dlzjfjz
 on u.user_id = dlzjfjz.user_id*/

 --买卖合同中介服务费
  left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTZJ FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='中介服务费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTZJ
 ON U.USER_ID = MMHTZJ.DUTY_USER_ID
 --买卖合同贷款服务费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTDK FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='贷款服务费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTDK
 ON U.USER_ID = MMHTDK.DUTY_USER_ID
  --买卖合同评估费提成
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTPGFTC FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='评估费提成' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTPGFTC
 ON U.USER_ID = MMHTPGFTC.DUTY_USER_ID
  --买卖合同评估费收入
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTPGFSR FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='评估费收入' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTPGFSR
 ON U.USER_ID = MMHTPGFSR.DUTY_USER_ID
  --买卖合同代办过户费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTDBGHF FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='代办过户费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTDBGHF
 ON U.USER_ID = MMHTDBGHF.DUTY_USER_ID
  --买卖合同其他费用
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTQTFY FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='其他费用' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTQTFY
 ON U.USER_ID = MMHTQTFY.DUTY_USER_ID
  --买卖合同卖方中介费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) MMHTMFZJF FROM BIZ_MM_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='卖方中介费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHTMFZJF
 ON U.USER_ID = MMHTMFZJF.DUTY_USER_ID
  --租赁合同中介服务费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) ZLHTZJFWF FROM BIZ_ZL_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='中介服务费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) ZLHTZJFWF
 ON U.USER_ID = ZLHTZJFWF.DUTY_USER_ID
  --租赁合同卖方中介费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) ZLHTMFZJF FROM BIZ_ZL_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='卖方中介费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) ZLHTMFZJF
 ON U.USER_ID = ZLHTMFZJF.DUTY_USER_ID
  /*--代理合同中介服务费
   left join
  (select T.DUTY_USER_ID, SUM(R.RECEIVABLE) DLHTZJFWF FROM BIZ_BUILDING_CONTRACT T LEFT JOIN BIZ_CONTRACT_RECEIVABLE R ON R.CONTRACT_ID = T.ID AND R.FEE_TYPE ='中介服务费' AND T.IS_REC = 0 AND T.STATUS = '已审核' AND R.STATUS = '有效' AND R.IS_REC = 0 and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) DLHTZJFWF
 ON U.USER_ID = DLHTZJFWF.DUTY_USER_ID*/
  --买卖新增套数
   left join
  (select T.DUTY_USER_ID, COUNT(T.ID) MMHT FROM BIZ_MM_CONTRACT T WHERE T.IS_REC = 0 AND T.STATUS = '已审核'  and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) MMHT
 ON U.USER_ID = MMHT.DUTY_USER_ID
  --租赁新增套数
   left join
  (select T.DUTY_USER_ID, COUNT(T.ID) ZLHT FROM BIZ_ZL_CONTRACT T WHERE T.IS_REC = 0 AND T.STATUS = '已审核'  and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) ZLHT
 ON U.USER_ID = ZLHT.DUTY_USER_ID
  /*--代理新增套数
   left join
  (select T.DUTY_USER_ID, COUNT(T.ID) DLHT FROM BIZ_BUILDING_CONTRACT T WHERE T.IS_REC = 0 AND T.STATUS = '已审核'  and to_char(T.REVIEW_DATE,'yyyy-MM-dd') >= to_char(VIEW_DATE.GET_START_DATE,'yyyy-MM-dd') and to_char(T.REVIEW_DATE,'yyyy-MM-dd') <= to_char(VIEW_DATE.GET_END_DATE,'yyyy-MM-dd') GROUP BY T.DUTY_USER_ID ) DLHT
 ON U.USER_ID = DLHT.DUTY_USER_ID*/

 --where   VIEW_DATE.SET_START_DATE('2019-01-01') = TO_DATE('2019-01-01','yyyy-MM-dd')
 --and     VIEW_DATE.SET_END_DATE('2019-01-31') = TO_DATE('2019-01-31','yyyy-MM-dd')

 order by u.DAQUNAME,u.deptname,u.USERNAME;
