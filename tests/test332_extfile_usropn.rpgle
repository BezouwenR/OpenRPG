     H DFTACTGRP(*NO)
      * EXTFILE names the file a program-described file opens: a literal,
      * or a variable read when the file is opened. USROPN files are
      * opened and closed by OPEN and CLOSE; %OPEN tells whether one is.
     FOUTF      O    F   20        DISK    EXTFILE('testfl332.txt') USROPN
     FINF       IF   F   20        DISK    EXTFILE(FNAME) USROPN
     FINIT      IF   F   20        DISK    EXTFILE(INITNAME)
     DFNAME            S             64A
     DINITNAME         S             64A   INZ('testfl332.txt')
     DTEXT             S             20A
     IINF       AA
     I                             A    1   20  REC
     IINIT      AB
     I                             A    1   20  REC2
      /free
       IF NOT %OPEN(OUTF);
         DSPLY 'OUTF closed';
       ENDIF;
       OPEN OUTF;
       TEXT = 'FIRST RECORD';
       EXCEPT LINE;
       TEXT = 'SECOND RECORD';
       EXCEPT LINE;
       CLOSE OUTF;

       MONITOR;
         READ INF;
       ON-ERROR;
         DSPLY ('READ before OPEN: ' + %CHAR(%STATUS));
       ENDMON;
       FNAME = 'testfl332.txt';
       OPEN INF;
       READ INF;
       DSPLY REC;
       OPEN(E) INF;
       DSPLY ('OPEN again: ' + %CHAR(%STATUS));
       CLOSE INF;
       OPEN INF;
       READ INF;
       DSPLY REC;
       READ INF;
       DSPLY REC;
       READ INIT;
       DSPLY REC2;
       CLOSE *ALL;
       IF NOT %OPEN(INIT);
         DSPLY 'CLOSE *ALL closed INIT';
       ENDIF;
       *INLR = *ON;
      /end-free
     OOUTF      E            LINE
     O                       TEXT                20
