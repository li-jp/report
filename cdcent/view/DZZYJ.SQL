CREATE OR REPLACE VIEW DZZYJ AS
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
T.IF_NEWOROLD,
(NVL(T.买卖中介服务费新增,0)+ NVL(T.买卖卖方中介费新增,0)+ NVL(买卖贷款服务费新增,0)+ NVL(T.买卖评估费收入新增,0)+ NVL(T.买卖代办过户费新增,0)+NVL(T.买卖垫资服务费新增,0)+ NVL(T.买卖其他费用新增,0)+
NVL(T.买卖中介服务费结转,0)+NVL(T.买卖卖方中介费结转,0)+ NVL(T.买卖贷款服务费结转,0)+ NVL(T.买卖评估费收入结转,0)+ NVL(T.买卖代办过户费结转,0)+NVL(T.买卖垫资服务费结转,0)+ NVL(T.买卖其他费用结转,0)) AS MMYJ,
(NVL(T.租赁中介服务费新增,0) + NVL(T.租赁中介服务费结转,0)) AS ZLYJ,
(NVL(T.店长买卖中介服务费新增,0)+ NVL(T.店长买卖卖方中介费新增,0)+ NVL(T.店长买卖贷款服务费新增,0)+ NVL(T.店长买卖评估费收入新增,0)+ NVL(T.店长买卖代办过户费新增,0)+NVL(T.店长买卖垫资服务费新增,0)+ NVL(T.店长买卖其他费用新增,0)+
NVL(T.店长买卖中介服务费结转,0)+ NVL(T.店长买卖卖方中介费结转,0)+ NVL(T.店长买卖贷款服务费结转,0)+ NVL(T.店长买卖评估费收入结转,0)+ NVL(T.店长买卖代办过户费结转,0)+NVL(T.店长买卖垫资服务费结转,0)+ NVL(T.店长买卖其他费用结转,0)) AS DZMMYJ
FROM   DZYJ T;
