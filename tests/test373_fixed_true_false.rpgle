     H* *TRUE and *FALSE in fixed-format source: INZ on a D-spec, and a
     H* C-spec factor.
     DFLAG             S               N   INZ(*TRUE)
     DOTHER            S               N   INZ(*FALSE)
     C                   IF        FLAG = *TRUE AND OTHER = *FALSE
     C     'fixed ok'    DSPLY
     C                   ENDIF
     C                   EVAL      *INLR = *TRUE
     C                   RETURN
