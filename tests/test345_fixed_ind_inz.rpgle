     H DFTACTGRP(*NO)
      * INZ(*ON) on a fixed-form indicator (N) D-spec.
     DFLAG             S               N   INZ(*ON)
      /free
       IF FLAG;
         DSPLY 'fixed on';
       ENDIF;
       *INLR = *ON;
      /end-free
