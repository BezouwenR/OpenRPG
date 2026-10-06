      * %SUBST as the target of a fixed-format EVAL.
     DS                S             10A   INZ('abcdefghij')
     C                   EVAL      %SUBST(S:3:2) = 'ZZ'
     C     S             DSPLY
     C                   EVAL      *INLR = *ON
