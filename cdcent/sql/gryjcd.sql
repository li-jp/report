select *
from gryj u
 where VIEW_DATE.SET_DATE('${D}') = TO_DATE('${D}','yyyy-MM')
 and (u.deptname like '%${text}%' or u.daquname like '%${text}%' or u.username like '%${text}%')
   ${if(len(pro_name)==0,"",
	"and (u.username= '"+pro_name+
	"' or u.deptname ='"+ pro_name+
	"' or u.daquname ='"+ pro_name+
	"')")
	}