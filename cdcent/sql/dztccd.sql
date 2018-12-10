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
T.IF_NEWOROLD,
T.MMYJ,
T.ZLYJ,
DMYJTC_R(T.MMYJ+T.ZLYJ,T.IF_NEWOROLD) AS DMYJTC_R,
DMYJTC(T.MMYJ+T.ZLYJ,T.IF_NEWOROLD) AS DMYJTC,
T.DZMMYJ,
MMYJTC(T.DZMMYJ) AS DZMMYJTC,
MMYJTC_R(T.DZMMYJ) AS DZMMYJTC_R
from DZZYJ t
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
        or  T.DZMMYJ != 0)
 order by t.DAQUNAME,t.deptname