' math.bas
' Assemblied with PBC
' Copyright © 2018年 jadestudio. All rights reserved.

TYPE SHORT: END TYPE
TYPE INTEGER: END TYPE
TYPE LONG: END TYPE
TYPE SINGLE: END TYPE
TYPE DOUBLE: END TYPE
TYPE STRING: END TYPE
TYPE BOOLEAN: END TYPE

DIM test = 56
IF NOT(test > 0) AND test <> 23 AND NOT(1 =2) THEN
    PRINT "HEHE"
END IF

FOR A=1 TO 2 STEP 3
EXIT FOR
NEXT A

DO
EXIT DO
LOOP UNTIL TRUE

'TYPE TIME
'    HOUR AS INTEGER
'    MINUTE AS INTEGER
'    SECOND AS INTEGER
'END TYPE

'DECLARE FUNCTION ABS(num AS DOUBLE) AS DOUBLE
'DECLARE SUB SETTIME(time AS TIME)

' ABS
'FUNCTION ABS(num AS DOUBLE) AS DOUBLE
'    IF (num < 0 AND num <> 0 AND ) THEN
'        ABS = -num
'    ELSE
'        ABS = num
'    END IF
'END FUNCTION

'SUB SETTIME(time AS TIME)
'    FOR I=1 TO 5
'        PRINT "1"
'    NEXT
'END SUB
