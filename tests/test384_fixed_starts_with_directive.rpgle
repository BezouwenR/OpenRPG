      /DEFINE GREET
      /IF NOT DEFINED(NOPE)
      /DEFINE ALSO
      /ENDIF
      * Fixed-format source whose first lines are compiler directives: they
      * are written the same way in either format, so the spec lines after
      * them decide that this is fixed-format.
     DMSG              S             10A   INZ('hello')
      /IF DEFINED(GREET)
     C     MSG           DSPLY
      /ENDIF
      /IF DEFINED(ALSO)
     C     'also'        DSPLY
      /ENDIF
     C                   EVAL      *INLR = *ON
