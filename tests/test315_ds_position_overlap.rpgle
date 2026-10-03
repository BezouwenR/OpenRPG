     H DFTACTGRP(*NO)
      * Subfields whose From/To positions fall inside an earlier character
      * subfield share its bytes, as if they had OVERLAY.
     DREC              DS                  QUALIFIED
     D  TEXT                   1      3A
     D  NUM                    1      3S 0
     DDATE             DS                  QUALIFIED
     D  FULL                   1      8A
     D  YY                     1      4S 0
     D  MM                     5      6A
     D  DD                     7      8S 0
      /free
       REC.NUM = 7;
       DSPLY ('[' + REC.TEXT + ']');
       REC.TEXT = '042';
       DSPLY %CHAR(REC.NUM);
       DATE.FULL = '20241231';
       DSPLY (%CHAR(DATE.YY) + '/' + DATE.MM + '/' + %CHAR(DATE.DD));
       DATE.DD = 5;
       DSPLY DATE.FULL;
       *INLR = *ON;
      /end-free
