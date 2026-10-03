     H DFTACTGRP(*NO)
      * A data structure with no name: its subfields are reached by name.
     D                 DS
     D  A                      1      2A   INZ('AB')
     D  B                      3      4A   INZ('CD')
      /free
       DSPLY (A + B);
       *INLR = *ON;
      /end-free
