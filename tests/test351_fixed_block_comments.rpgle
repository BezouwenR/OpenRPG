     H* Block comments in fixed-format source: in a /free block, and in the
     H* free-form area (positions 8-80) between fixed spec lines.
     DX                S             10I 0 INZ(1)
      /free
        /* a block comment
           in a free block */
        x = x + 1; /* trailing */
        DSPLY %CHAR(x);
      /end-free
       /* a block comment in positions 8-80,
          between fixed spec lines */
     C                   EVAL      X = X + 10
     C     X             DSPLY
     C                   RETURN
