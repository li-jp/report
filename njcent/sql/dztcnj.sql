							  
select *
from dztc t
where VIEW_DATE.SET_DATE('${D}') = TO_DATE('${D}','yyyy-MM')
 and (t.deptname like '%${text}%' or T.DAQUNAME LIKE '%${text}%' OR T.USERNAME LIKE '%${text}%')
 ${if(len(pro_name)==0,"",
	"and (t.username= '"+pro_name+
	"' or t.deptname ='"+ pro_name+
	"' or t.daquname ='"+ pro_name+
	"')")
	}
 and   (t.job_name = '店经理' 
        or  T.MMYJ != 0
        or  T.ZLYJ != 0
        or  T.DLYJ != 0
        or  T.DZZLYJ != 0
        or  T.DZMMYJ != 0
        or  T.DZDLYJ != 0)
 order by t.DAQUNAME,t.deptname