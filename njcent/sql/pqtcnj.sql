							  
select *
from qztc t
where VIEW_DATE.SET_DATE('${D}') = TO_DATE('${D}','yyyy-MM')
and (t.deptname like '%${text}%' or t.daquname like '%${text}%' or t.username like '%${text}%')
 ${if(len(pro_name)==0,"",
	"and (t.username= '"+pro_name+
	"' or t.deptname ='"+ pro_name+
	"' or t.daquname ='"+ pro_name+
	"')")
	}
 and   (t.job_name = '营业经理' 
        or  T.MMYJ != 0
        or  T.ZLYJ != 0
        or  T.DLYJ != 0
        or  T.QZMMYJ != 0
        or  T.QZZLYJ != 0
        or  T.QZDLYJ != 0)
 order by t.DAQUNAME,t.deptname