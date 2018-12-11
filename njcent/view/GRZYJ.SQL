CREATE OR REPLACE VIEW GRZYJ AS
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
(NVL(T.买卖中介服务费新增,0)+NVL(T.买卖贷款服务费新增,0)+NVL(T.买卖其他费用新增,0)+NVL(T.买卖中介服务费结转,0)+NVL(T.买卖贷款服务费结转,0)+NVL(T.买卖评估费提成结转,0)) AS MMYJ,
(NVL(T.买卖评估费提成新增,0)+NVL(T.买卖评估费提成结转,0)) AS PGF,
(NVL(T.租赁中介服务费新增,0)+NVL(T.租赁其他费用新增,0)+NVL(T.租赁中介服务费结转,0)+NVL(T.租赁其他费用结转,0)) AS ZLYJ
FROM   GRYJ T;
