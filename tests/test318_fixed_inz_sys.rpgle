     H DFTACTGRP(*NO)
      * INZ(*SYS) on a fixed-form D-spec: the current date, time, timestamp.
     DTODAY            S               D   INZ(*SYS)
     DNOW              S               T   INZ(*SYS)
     DSTAMP            S               Z   INZ(*SYS)
     DDAYS             S             10I 0
      /free
       DAYS = %DIFF(%DATE() : TODAY : *DAYS);
       DSPLY %CHAR(DAYS);
       IF %DATE(STAMP) = TODAY AND TODAY > D'2026-01-01';
         DSPLY 'date set';
       ENDIF;
       IF %DIFF(%TIME() : NOW : *SECONDS) < 60;
         DSPLY 'time set';
       ENDIF;
       *INLR = *ON;
      /end-free
