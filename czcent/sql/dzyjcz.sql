select *
from dzyj u
 where VIEW_DATE.SET_DATE('${D}') = TO_DATE('${D}','yyyy-MM') 
 and (u.deptname like '%${text}%' OR U.DAQUNAME LIKE '%${text}%' OR U.USERNAME LIKE '%${text}%')
 ${if(len(pro_name)==0,"",
	"and (u.username= '"+pro_name+
	"' or u.deptname ='"+ pro_name+
	"' or u.daquname ='"+ pro_name+
	"')")
	}