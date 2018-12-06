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
(NVL(T.买卖中介服务费新增,0)+ NVL(T.买卖卖方中介费新增,0)+ NVL(买卖贷款服务费新增,0)+ NVL(T.买卖评估费收入新增,0)+ NVL(T.买卖其他费用新增,0)+
NVL(T.买卖中介服务费结转,0)+NVL(T.买卖卖方中介费结转,0)+ NVL(T.买卖贷款服务费结转,0)+ NVL(T.买卖评估费收入结转,0)+ NVL(T.买卖其他费用结转,0)) AS MMYJ,
(NVL(T.租赁中介服务费新增,0)+NVL(T.租赁卖方中介费新增,0) + NVL(T.租赁中介服务费结转,0)+NVL(T.租赁卖方中介费结转,0)) AS ZLYJ,
W.NUM
FROM   QZYJ T, WULIDIAN_NUM W
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
--AND VIEW_DATE.SET_DATE('2018-12') = TO_DATE('2018-12','yyyy-MM');
