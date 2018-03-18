' math.bas
' Assemblied with PBC
' Copyright © 2018年 jadestudio. All rights reserved.

TYPE TIME
    HOUR AS INTEGER
    MINUTE AS INTEGER
    SECOND AS INTEGER
END TYPE

DECLARE FUNCTION ABS(nu AS DOUBLE) AS DOUBLE
DECLARE SUB STUN(a AS STRING, b AS INTEGER)

DIM array(5,5) AS INTEGER
array(1,1)=ABS(array(1,1))

DIM t1 AS TIME
DIM t2 AS TIME

IF t1 = t2 THEN
PRINT "YES"
END IF

DIM s1 = "HELLO WORD"
DIM b(2, 2)={{"A","B","C"},{"1","2","3"}}

IF s1 <> "HELLO WORD" THEN
    REM DO SOMETHING
END IF

STUN "test", 1

' ABS
FUNCTION ABS(num AS DOUBLE) AS DOUBLE
    IF (num < 0) THEN
        ABS = -num
    ELSE
        ABS = num
    END IF
END FUNCTION
