CREATE OR REPLACE FUNCTION ZLYJTC_R(ZLYJ IN NUMBER) RETURN NUMBER IS
  RESULT NUMBER;
BEGIN
IF ZLYJ > 0
  THEN
    RESULT := 0.35;
  ELSE
    RESULT := 0;
  END IF;
  RETURN(RESULT);
END ZLYJTC_R;
