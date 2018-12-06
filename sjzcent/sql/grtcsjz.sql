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
T.GL,
GLTC_R(MMYJ+PGF+ZLYJ,T.GL) AS GLTC_R,
GLTC(MMYJ+PGF+ZLYJ,MMYJ,T.GL) AS GLTC,
T.MMYJ,
MMYJTC_R(T.MMYJ) AS MMYJTC_R,
MMYJTC(T.MMYJ) AS MMYJTC,
T.PGF,
PGFTC_R(T.PGF) AS PGFTC_R,
PGFTC(T.PGF) AS PGFTC,
T.ZLYJ,
ZLYJTC_R(T.ZLYJ) AS ZLYJTC_R,
ZLYJTC(T.ZLYJ) AS ZLYJTC
from GRZYJ t
where VIEW_DATE.SET_DATE('${D}') = TO_DATE('${D}','yyyy-MM')
and t.deptname like '%${text}%'
  ${if(len(pro_name)==0,"",
	"and (t.username= '"+pro_name+
	"' or t.deptname ='"+ pro_name+
	"' or t.daquname ='"+ pro_name+
	"')")
	}
order by T.DAQUNAME,T.DEPTNAME