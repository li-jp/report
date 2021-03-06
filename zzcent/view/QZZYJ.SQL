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
(NVL(T.买卖中介服务费_已收_新增,0)+NVL(T.买卖代办过户费_已收_新增,0)+NVL(T.买卖贷款服务费新增,0)+NVL(T.买卖评估费提成新增,0)+NVL(T.买卖其他费用新增,0)+NVL(T.买卖中介服务费_已收_结转,0)+NVL(T.买卖代办过户费_已收_结转,0)+NVL(T.买卖贷款服务费结转,0)+NVL(T.买卖评估费提成结转,0)+NVL(T.买卖其他费用结转,0)) AS MMYJ,
(NVL(T.租赁中介服务费新增,0)+NVL(T.租赁其他费用新增,0)+NVL(T.租赁中介服务费结转,0)+NVL(T.租赁其他费用结转,0)) AS ZLYJ,
(NVL(T.代理中介服务费_已收_新增,0)+NVL(T.代理中介服务费_已收_结转,0)) AS DLYJ,
--(NVL(T.代理中介服务费_已结_新增,0)+NVL(T.代理中介服务费_已结_结转,0)+NVL(T.代理中介服务费_二次结利_新增,0)+NVL(T.代理中介服务费_二次结利_结转,0)) AS DLYJ,
W.NUM
FROM   QZYJ T , WULIDIAN_NUM W
WHERE  T.USER_ID = W.USER_ID
AND    W.INPUT_DATE =
        (SELECT MAX(T1.INPUT_DATE)
           FROM   WULIDIAN_NUM T1
           WHERE  T1.USER_ID = T.USER_ID
           AND    TO_CHAR(T1.INPUT_DATE, 'yyyy-MM-dd') <=
                  TO_CHAR(LAST_DAY(VIEW_DATE.GET_DATE), 'yyyy-MM-dd'))
 AND    W.ID =
         (SELECT MAX(T2.ID)
           FROM   WULIDIAN_NUM T2
           WHERE  T2.USER_ID = T.USER_ID
           AND    TO_CHAR(T2.INPUT_DATE, 'yyyy-MM-dd') <=
                  TO_CHAR(LAST_DAY(VIEW_DATE.GET_DATE), 'yyyy-MM-dd'))
--AND VIEW_DATE.SET_DATE('2018-11') = TO_DATE('2018-11','yyyy-MM');
