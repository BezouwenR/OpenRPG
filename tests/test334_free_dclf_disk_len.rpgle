     H DFTACTGRP(*NO)
      * A free-form DCL-F among fixed-form specs declares a program-described
      * file with DISK(record-length); its layout is in the fixed I- and
      * O-specs. Free-form declarations outside /FREE are positions 8-80.
       DCL-F OUTF DISK(20) USAGE(*OUTPUT) EXTFILE('testfl334.txt') USROPN;
       DCL-F INF DISK(20) USAGE(*INPUT) EXTFILE('testfl334.txt') USROPN;
     DNAME             S             15A
       DCL-S AGE PACKED(3:0);
     IINF       AA
     I                             A    1   15  INNAME
     I                             S   16   18 0INAGE
      /free
       OPEN OUTF;
       NAME = 'Alice';
       AGE = 30;
       EXCEPT REC;
       NAME = 'Bob';
       AGE = 7;
       EXCEPT REC;
       CLOSE OUTF;
       OPEN INF;
       READ INF;
       DSPLY (%TRIM(INNAME) + ' ' + %CHAR(INAGE));
       READ INF;
       DSPLY (%TRIM(INNAME) + ' ' + %CHAR(INAGE));
       CLOSE INF;
       *INLR = *ON;
      /end-free
     OOUTF      E            REC
     O                       NAME                15
     O                       AGE                 18
