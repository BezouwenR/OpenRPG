     H* /MESSAGE in fixed-format source.
      /MESSAGE 'fixed warning'
      /IF DEFINED(NOPE)
      /MESSAGE *ERROR 'skipped'
      /ENDIF
     C     'fixed ok'    DSPLY
     C                   EVAL      *INLR = *ON
