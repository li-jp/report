select * from QZYJ t
where VIEW_DATE.SET_DATE(TO_CHAR(sysdate,'yyyy-MM')) = TO_DATE(TO_CHAR(sysdate,'yyyy-MM'),'yyyy-MM')