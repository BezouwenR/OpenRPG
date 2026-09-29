**FREE
// SND-MSG *ESCAPE goes to the caller by default: the procedure that sends
// it ends at once -- its own MONITOR does not see the message -- and its
// caller gets the error. %TARGET(*SELF) sends it to the procedure itself,
// where its own MONITOR handles it. The PSDS names the message.
CTL-OPT DFTACTGRP(*NO);

DCL-DS pgm PSDS QUALIFIED;
  ExcType CHAR(3) POS(40);
  ExcNbr  CHAR(4) POS(43);
END-DS;
DCL-S line VARCHAR(52);

MONITOR;
  failCaller();
  DSPLY 'WRONG: failCaller returned';
ON-ERROR;
  line = 'CALLER status ' + %CHAR(%STATUS) + ' ' + pgm.ExcType + pgm.ExcNbr;
  DSPLY line;
ENDMON;

failSelf();
DSPLY 'DONE';
*INLR = *ON;

DCL-PROC failCaller;
  MONITOR;
    SND-MSG *ESCAPE 'to the caller';
    DSPLY 'WRONG: after the escape';
  ON-ERROR;
    DSPLY 'WRONG: its own MONITOR';
  ENDMON;
  DSPLY 'WRONG: failCaller continued';
END-PROC;

DCL-PROC failSelf;
  MONITOR;
    SND-MSG *ESCAPE 'to myself' %TARGET(*SELF);
    DSPLY 'WRONG: after the escape';
  ON-ERROR;
    line = 'SELF status ' + %CHAR(%STATUS) + ' ' + pgm.ExcType + pgm.ExcNbr;
    DSPLY line;
  ENDMON;
END-PROC;
