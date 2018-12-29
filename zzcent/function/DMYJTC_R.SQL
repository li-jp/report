CREATE OR REPLACE FUNCTION DMYJTC_R(YJ IN NUMBER, LV IN VARCHAR2, RENSHU IN NUMBER)
  RETURN NUMBER IS
  R1     NUMBER;
  RS     NUMBER;
  RESULT NUMBER;
BEGIN
  /*若为见习店长，则分为4人店和4人以上店组两种情况*/
  IF LV = '见习'
  THEN
    IF RENSHU < 4
    THEN
      RS := 4;
    END IF;
  
    SELECT T.RATIO
    INTO   R1
    FROM   JX_RATIO T
    WHERE  T.TYPE = 2
    AND    T.LOWER <= YJ / RS
    AND    T.UPPER > YJ / RS
    AND    T.INPUT_TIME =
           (SELECT MAX(T1.INPUT_TIME)
             FROM   JX_RATIO T1
             WHERE  T1.TYPE = T.TYPE
             AND    T1.LOWER = T.LOWER
             AND    T1.UPPER = T.UPPER
             AND    TO_CHAR(T1.INPUT_TIME, 'yyyy-MM-dd') <=
                    TO_CHAR(LAST_DAY(VIEW_DATE.GET_DATE), 'yyyy-MM-dd'));
    RESULT := R1;
  ELSE
    /*若为转正店长，则分为6人店、7人店、8人及以上店面*/
    IF YJ >= 110000
    THEN
      /*若店组业绩大于110000，按照店组业绩进行提成*/
      SELECT T.RATIO
      INTO   R1
      FROM   JX_RATIO T
      WHERE  T.TYPE = 2
      AND    T.LOWER <= YJ
      AND    T.UPPER > YJ
      AND    T.INPUT_TIME =
             (SELECT MAX(T1.INPUT_TIME)
               FROM   JX_RATIO T1
               WHERE  T1.TYPE = T.TYPE
               AND    T1.LOWER = T.LOWER
               AND    T1.UPPER = T.UPPER
               AND    TO_CHAR(T1.INPUT_TIME, 'yyyy-MM-dd') <=
                      TO_CHAR(LAST_DAY(VIEW_DATE.GET_DATE), 'yyyy-MM-dd'));
      RESULT := R1;
    ELSE
      /*若店组业绩不足110000，按照人均业绩进行提成*/
      IF RENSHU < 6
      THEN
        RS := 6;
      ELSIF RENSHU = 7
      THEN
        RS := 7;
      ELSE
        RS := RENSHU;
      END IF;
    
      SELECT T.RATIO
      INTO   R1
      FROM   JX_RATIO T
      WHERE  T.TYPE = 2
      AND    T.LOWER <= YJ / RS
      AND    T.UPPER > YJ / RS
      AND    T.INPUT_TIME =
             (SELECT MAX(T1.INPUT_TIME)
               FROM   JX_RATIO T1
               WHERE  T1.TYPE = T.TYPE
               AND    T1.LOWER = T.LOWER
               AND    T1.UPPER = T.UPPER
               AND    TO_CHAR(T1.INPUT_TIME, 'yyyy-MM-dd') <=
                      TO_CHAR(LAST_DAY(VIEW_DATE.GET_DATE), 'yyyy-MM-dd'));
      RESULT := R1;
    END IF;
  END IF;
  RETURN(RESULT);
END DMYJTC_R;
