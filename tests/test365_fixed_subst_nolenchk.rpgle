     H OPTION(*NOLENCHK)
      * OPTION(*NOLENCHK) on an H-spec: a %SUBST length past the end gives
      * the rest of the data.
     DS                S             10A   VARYING INZ('200 OK')
     DT                S             10A
     C                   EVAL      T = %SUBST(S:5:20)
     C     T             DSPLY
     C                   RETURN
