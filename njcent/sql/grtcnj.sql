select *
from grtc t
where VIEW_DATE.SET_DATE('${D}') = TO_DATE('${D}','yyyy-MM')
and (t.deptname like '%${text}%' or t.daquname like '%${text}%' or t.username like '%${text}%')
  ${if(len(pro_name)==0,"",
	"and (t.username= '"+pro_name+
	"' or t.deptname ='"+ pro_name+
	"' or t.daquname ='"+ pro_name+
	"')")
	}
order by T.DAQUNAME,T.DEPTNAME