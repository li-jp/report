CREATE OR REPLACE VIEW DZZYJ AS
SELECT T.USER_ID,
T.USERNAME,
JOB_NAME,
STATUS,
INDUCTION_TIME ,
STAR_LEVEL ,
DEPT_ID ,
DEPTNAME ,
DAQUNAME ,
DIMISSION_DATE ,
GL(T.USER_ID,LAST_DAY(VIEW_DATE.GET_DATE)) AS GL ,
(NVL(T.买卖中介服务费新增,0)+NVL(T.买卖贷款服务费新增,0)+NVL(T.买卖其他费用新增,0)+NVL(T.买卖中介服务费结转,0)+NVL(T.买卖贷款服务费结转,0)+NVL(T.买卖其他费用结转,0)) AS MMYJ,
(NVL(T.租赁中介服务费新增,0)+NVL(T.租赁中介服务费结转,0)) AS ZLYJ,
(NVL(T.代理中介服务费新增,0)+NVL(T.代理中介服务费结转,0)) AS DLYJ,
(NVL(T.店长买卖中介服务费新增,0)+NVL(T.店长买卖贷款服务费新增,0)+NVL(T.店长买卖其他费用新增,0)+NVL(T.店长买卖中介服务费结转,0)+NVL(T.店长买卖贷款服务费结转,0)+NVL(T.店长买卖其他费用结转,0)) AS DZMMYJ,
(NVL(T.店长租赁中介服务费新增,0)+NVL(T.店长租赁中介服务费结转,0)) AS DZZLYJ,
(NVL(T.店长代理中介服务费新增,0)+NVL(T.店长代理中介服务费结转,0)) AS DZDLYJ
FROM   DZYJ T;