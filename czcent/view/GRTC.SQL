create or replace view grtc as
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
MMYJTC_R(T.MMYJ) AS MMYJTC_R,
MMYJTC(T.MMYJ) AS MMYJTC,
T.ZLYJ,
ZLYJTC_R(T.ZLYJ) AS ZLYJTC_R,
ZLYJTC(T.ZLYJ) AS ZLYJTC,
T.DLYJ
from GRZYJ t;
