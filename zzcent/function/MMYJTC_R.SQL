CREATE OR REPLACE FUNCTION MMYJTC_R(YJ IN NUMBER, LV IN VARCHAR2, D IN DATE DEFAULT LAST_DAY(VIEW_DATE.GET_DATE))
  RETURN NUMBER IS
  R      NUMBER;
  RESULT NUMBER;
BEGIN
  IF LV = '见习'
  THEN
    RESULT := 0.10;
  ELSE
    SELECT T.RATIO
    INTO   R
    FROM   JX_RATIO T
    WHERE  T.TYPE = 1
    AND    T.LOWER <= YJ
    AND    T.UPPER > YJ
    AND    T.INPUT_TIME = (SELECT MAX(T1.INPUT_TIME)
                           FROM   JX_RATIO T1
                           WHERE  T1.TYPE = T.TYPE
                           AND    T1.LOWER = T.LOWER
                           AND    T1.UPPER = T.UPPER
                           AND    T1.INPUT_TIME <= D);
    RESULT := R;
  END IF;

  RETURN RESULT;
END MMYJTC_R;
