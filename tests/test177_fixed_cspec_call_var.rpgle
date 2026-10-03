     H DFTACTGRP(*NO)
      * CALL with the program's name in a variable: found when the CALL runs.
     Dn                S             10I 0
     Dmsg              S             10A
     Dpgmvar           S             10A   INZ('ADDONE')
     DTMPDSP           S             52A
     C                   EVAL      n = 9
     C                   CALL      pgmvar
     C                   PARM                    n
     C                   PARM                    msg
     C                   EVAL      TMPDSP = %CHAR(n) + ' ' + msg
     C     TMPDSP        DSPLY
     C                   RETURN
