' math.bas
' Assemblied with PBC
' Copyright © 2018年 jadestudio. All rights reserved.

TYPE TIME
    HOUR AS INTEGER
    MINUTE AS INTEGER
    SECOND AS INTEGER
END TYPE

DECLARE FUNCTION ABS(num() AS DOUBLE ) AS DOUBLE

' ABS
FUNCTION ABS(num() AS DOUBLE) AS DOUBLE
    IF (num(1) < 0) THEN
        ABS = -num(1)
    ELSE
        ABS = num(1)
    END IF
END FUNCTION


DECLARE SUB STUN(a AS STRING, b AS INTEGER)

DIM t1 AS TIME
DIM t2 AS TIME

DIM C(-1 TO 1,2) AS INTEGER = {{222,222},{111,111},{2,6}}
ABS(C)

IF t1 = t2 THEN
    PRINT "YES"
END IF

DIM s1 = "HELLO WORD"
DIM b()={{"A","B","C"},{"1","2","3"}}

IF b(1,2) = "HEHE" THEN
END IF

IF s1 <> "HELLO WORD" THEN
    REM DO SOMETHING
END IF

STUN "test", 1
