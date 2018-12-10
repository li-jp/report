select *
from QZTC t
--where VIEW_DATE.SET_DATE('2018-12') = TO_DATE('2018-12','yyyy-MM')
where VIEW_DATE.SET_DATE('${D}') = TO_DATE('${D}','yyyy-MM')
and (t.deptname like '%${text}%' or t.daquname like '%${text}%' or t.username like '%${text}%')
and   (t.job_name = '营业经理' 
        or  T.MMYJ != 0
        or  T.ZLYJ != 0)
${if(len(pro_name)==0,"",
	"and (t.username= '"+pro_name+
	"' or t.deptname ='"+ pro_name+
	"' or t.daquname ='"+ pro_name+
	"')")
	} 
order by t.DAQUNAME,t.deptname