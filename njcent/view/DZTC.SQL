create or replace view dztc as
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
T.DLYJ,
(T.MMYJ + T.ZLYJ + T.DLYJ) AS DMZYJ,
DMYJTC_R(T.MMYJ + T.ZLYJ + T.DLYJ) AS DMYJTC_R,
DMYJTC(T.MMYJ + T.ZLYJ + T.DLYJ) AS DMYJTC,
T.DZMMYJ,
T.DZZLYJ,
T.DZDLYJ,
(T.DZMMYJ + T.DZZLYJ + T.DZDLYJ) AS DZZYJ,
MMYJTC_R(T.DZMMYJ ) AS DZMMYJTC_R,
MMYJTC(T.DZMMYJ ) AS DZMMYJTC,
ZLYJTC_R(T.DZZLYJ ) AS DZZLYJTC_R,
ZLYJTC(T.DZZLYJ) AS DZZLYJTC,
DLYJTC_R(T.DZDLYJ) AS DZDLYJTC_R,
DLYJTC(T.DZDLYJ ) AS DZDLYJTC

from DZZYJ t
--where VIEW_DATE.SET_DATE('2018-10') = TO_DATE('2018-10','yyyy-MM');
