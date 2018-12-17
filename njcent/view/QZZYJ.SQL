CREATE OR REPLACE VIEW QZZYJ AS
SELECT T.USER_ID,
T.USERNAME,
T.JOB_NAME,
T.STATUS,
T.INDUCTION_TIME ,
T.STAR_LEVEL ,
T.DEPT_ID ,
T.DEPTNAME ,
T.DAQUNAME ,
T.DIMISSION_DATE ,
GL(T.USER_ID,LAST_DAY(VIEW_DATE.GET_DATE)) AS GL ,
(NVL(T.买卖中介服务费新增,0)+NVL(T.买卖贷款服务费新增,0)+NVL(T.买卖其他费用新增,0)+NVL(T.买卖中介服务费结转,0)+NVL(T.买卖贷款服务费结转,0)+NVL(T.买卖其他费用结转,0)) AS MMYJ,
(NVL(T.租赁中介服务费新增,0)+NVL(T.租赁中介服务费结转,0)) AS ZLYJ,
(NVL(T.代理代理服务费新增,0)+NVL(T.代理代理服务费结转,0)) AS DLYJ,
(NVL(T.区长买卖中介服务费新增,0)+NVL(T.区长买卖贷款服务费新增,0)+NVL(T.区长买卖其他费用新增,0)+NVL(T.区长买卖中介服务费结转,0)+NVL(T.区长买卖贷款服务费结转,0)+NVL(T.区长买卖其他费用结转,0)) AS QZMMYJ,
(NVL(T.区长租赁中介服务费新增,0)+NVL(T.区长租赁中介服务费结转,0)) AS QZZLYJ,
(NVL(T.区长代理代理服务费新增,0)+NVL(T.区长代理代理服务费结转,0)) AS QZDLYJ
FROM   QZYJ T
--AND VIEW_DATE.SET_DATE('2018-11') = TO_DATE('2018-11','yyyy-MM');