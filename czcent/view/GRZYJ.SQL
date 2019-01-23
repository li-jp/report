CREATE OR REPLACE VIEW GRZYJ AS
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
(NVL(T.买卖中介服务费新增,0)+ NVL(T.买卖卖方中介费新增,0)+ NVL(买卖贷款服务费新增,0)+ NVL(T.买卖评估费收入新增,0)+ NVL(T.买卖其他费用新增,0)+
NVL(T.买卖中介服务费结转,0)+NVL(T.买卖卖方中介费结转,0)+ NVL(T.买卖贷款服务费结转,0)+ NVL(T.买卖评估费收入结转,0)+ NVL(T.买卖其他费用结转,0)) AS MMYJ,
(NVL(T.租赁中介服务费新增,0) + NVL(T.租赁卖方中介费新增,0) + NVL(T.租赁中介服务费结转,0) + NVL(T.租赁卖方中介费结转,0)) AS ZLYJ,
(NVL(T.代理中介服务费新增,0) + NVL(T.代理中介服务费结转,0)) AS DLYJ
FROM   GRYJ T
 --where   VIEW_DATE.SET_DATE('2018-11') = TO_DATE('2018-11','yyyy-MM');
