SELECT U.ID USER_ID, U.USERNAME, JOB.NAME JOB_NAME, U.STATUS, U.STAR_LEVEL, D.ID DEPT_ID, D.NAME DEPTNAME, D.NAMEALL, P.NAME DAQUNAME, P.ID PIANQU_ID, 
DLDK.DLDK_NUM,
DLHF.DLHF_NUM,
DLKH.DLKH_NUM,
DLHT.DLHT_NUM

FROM   SYS_USER U
LEFT   JOIN SYS_DEPARTMENT D
ON     U.DEPT_ID = D.ID
LEFT   JOIN SYS_PIANQU P
ON     P.ID = D.PIANQU_ID
LEFT   JOIN SYS_JOB JOB
ON     U.JOB_ID = JOB.ID

LEFT   JOIN (SELECT COUNT(W.ID) DLDK_NUM, W.INPUT_USER_ID
             FROM   BIZ_WATCH_LINK W
             WHERE  W.IS_REC = 0
             AND    W.TYPE = '1000300'
             AND    TO_CHAR(W.INPUT_DATE, 'yyyy-MM-dd') >= '${stat_date}'
             AND    TO_CHAR(W.INPUT_DATE, 'yyyy-MM-dd') <= '${end_date}'
             GROUP  BY W.INPUT_USER_ID) DLDK
ON     DLDK.INPUT_USER_ID = U.ID

LEFT   JOIN (SELECT COUNT(V.ID) DLHF_NUM, V.INPUT_USER_ID
             FROM   BIZ_WATCH_LINK V
             WHERE  V.IS_REC = 0
             AND    V.TYPE = '1100300'
             AND    TO_CHAR(V.INPUT_DATE, 'yyyy-MM-dd') >= '${stat_date}'
             AND    TO_CHAR(V.INPUT_DATE, 'yyyy-MM-dd') <= '${end_date}'
             GROUP  BY V.INPUT_USER_ID) DLHF
ON     DLHF.INPUT_USER_ID = U.ID

LEFT   JOIN (SELECT COUNT(C.ID) DLKH_NUM, C.INPUT_USER_ID 
FROM   BIZ_BUILDING_CUSTOMER C
WHERE     C.IS_REC = 0
AND    TO_CHAR(C.INPUT_DATE, 'yyyy-MM-dd') >= '${stat_date}'
AND    TO_CHAR(C.INPUT_DATE, 'yyyy-MM-dd') <= '${end_date}'
GROUP BY C.INPUT_USER_ID) DLKH
ON     DLKH.INPUT_USER_ID = U.ID

LEFT   JOIN  (SELECT COUNT(Z.ID) DLHT_NUM, Z.INPUT_USER_ID
FROM   BIZ_BUILDING_CONTRACT Z
WHERE     Z.IS_REC = 0
AND    TO_CHAR(Z.INPUT_DATE, 'yyyy-MM-dd') >= '${stat_date}'
AND    TO_CHAR(Z.INPUT_DATE, 'yyyy-MM-dd') <= '${end_date}'
GROUP BY Z.INPUT_USER_ID) DLHT
ON    DLHT.INPUT_USER_ID = U.ID

where d.nameall like '%二手房事业部%' 
and u.is_rec = 0
and d.is_rec = 0
and p.is_rec = 0
and (u.username like '%${name}%'
  or d.name like '%${name}%'
  or p.name like '%${name}%'
  )
${if(len(pro_name)==0,"",
	"and (u.username= '"+pro_name+
	"' or d.name ='"+ pro_name+
	"' or p.name ='"+ pro_name+
	"')")
	}

GROUP  BY U.ID, U.USERNAME, JOB.NAME, U.STATUS, U.STAR_LEVEL, D.ID, D.NAME, D.NAMEALL, P.NAME, P.ID, DLDK.DLDK_NUM, DLHF.DLHF_NUM, DLKH.DLKH_NUM, DLHT.DLHT_NUM
