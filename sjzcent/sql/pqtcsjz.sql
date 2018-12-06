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
T.NUM,
T.MMYJ,
T.ZLYJ,
T.PGF,
(T.MMYJ + T.ZLYJ + T.PGF) AS PQZYJ,
(T.MMYJ + T.ZLYJ + T.PGF)/T.NUM AS WLDJYJ,--物理店均业绩
PQYJTC_R((T.MMYJ+T.ZLYJ + T.PGF),T.NUM) AS YJTC_R,
PQYJTC((T.MMYJ+T.ZLYJ + T.PGF),T.NUM) AS YJTC
from QZZYJ t
where VIEW_DATE.SET_DATE('${D}') = TO_DATE('${D}','yyyy-MM')
and t.deptname like '%${text}%'
 ${if(len(pro_name)==0,"",
	"and (t.username= '"+pro_name+
	"' or t.deptname ='"+ pro_name+
	"' or t.daquname ='"+ pro_name+
	"')")
	}
 and   (t.job_name = '营业经理' 
        or  T.MMYJ != 0
        or  T.ZLYJ != 0
        or  T.PGF != 0)
 order by t.DAQUNAME,t.deptname