     H DFTACTGRP(*NO)
      * 20I and 20U D-specs are eight-byte integers, INZ included.
     DBIG              S             20I 0 INZ(9000000000)
     DU                S             20U 0
      /free
       BIG = BIG + 1;
       DSPLY %CHAR(BIG);
       U = 18000000000000000000;
       DSPLY %CHAR(U);
       *INLR = *ON;
      /end-free
