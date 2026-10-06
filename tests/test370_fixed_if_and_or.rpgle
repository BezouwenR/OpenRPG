     H* Several conditions in one /IF, in fixed-format source.
      /DEFINE LINUX
      /IF DEFINED(LINUX) AND NOT DEFINED(NOGUI)
     C                   EVAL      *INLR = *ON
     C     'linux gui'   DSPLY
      /ELSE
     C     'wrong'       DSPLY
      /ENDIF
      /IF DEFINED(A) OR (DEFINED(LINUX) AND DEFINED(*OPENRPG))
     C     'compound'    DSPLY
      /ENDIF
     C                   RETURN
