select T.USER_ID,
T.USERNAME,
T.JOB_NAME,
T.STATUS,
T.INDUCTION_TIME,
T.STAR_LEVEL,
T.DEPT_ID,
T.DEPTNAME,
T.DAQUNAME,
T.DIMISSION_DATE,
T.MMYJ,
T.ZLYJ,
DMYJTC_R(T.MMYJ+T.ZLYJ) AS DMYJTC_R,
DMYJTC(T.MMYJ+T.ZLYJ) AS DMYJTC
from DZZYJ t
where VIEW_DATE.SET_DATE('${D}') = TO_DATE('${D}','yyyy-MM')
 and t.deptname like '%${text}%'
 ${if(len(pro_name)==0,"",
	"and (t.username= '"+pro_name+
	"' or t.deptname ='"+ pro_name+
	"' or t.daquname ='"+ pro_name+
	"')")
	}
 and   (t.job_name = '店经理' 
        or  T.MMYJ != 0
        or  T.ZLYJ != 0)
 order by t.DAQUNAME,t.deptname