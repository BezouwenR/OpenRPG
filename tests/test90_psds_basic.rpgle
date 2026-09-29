**FREE

// Test 90: the Program Status Data Structure, at the positions IBM i gives
// its subfields. What depends on where the program runs (the names, the
// user, the job, the date) is checked for being set and consistent, not
// displayed. After an error the PSDS holds its status, the previous status
// and the exception ID.

DCL-DS PgmInfo PSDS QUALIFIED;
  ProcName  CHAR(10)   POS(1);
  Status    ZONED(5:0) POS(11);
  PrvStatus ZONED(5:0) POS(16);
  Parms     ZONED(3:0) POS(37);
  ExcType   CHAR(3)    POS(40);
  ExcNbr    CHAR(4)    POS(43);
  ExcData   CHAR(80)   POS(91);
  JobName   CHAR(10)   POS(244);
  UserName  CHAR(10)   POS(254);
  JobNum    ZONED(6:0) POS(264);
  RunDate   ZONED(6:0) POS(276);
  RunTime   ZONED(6:0) POS(282);
  PgmName   CHAR(10)   POS(334);
  ModName   CHAR(10)   POS(344);
  CurUser   CHAR(10)   POS(358);
END-DS;

DCL-S line VARCHAR(52);
DCL-S s VARCHAR(5) INZ('ABC');
DCL-S a INT(10) INZ(0);
DCL-S b INT(10);
DCL-S st INT(10) INZ(9);

line = 'STATUS ' + %CHAR(PgmInfo.Status) + ' ' + %CHAR(PgmInfo.PrvStatus) +
       ' PARMS ' + %CHAR(PgmInfo.Parms) + ' EXC [' + PgmInfo.ExcType +
       PgmInfo.ExcNbr + ']';
DSPLY line;

IF PgmInfo.ProcName <> *BLANKS AND PgmInfo.PgmName = PgmInfo.ProcName
   AND PgmInfo.ModName = PgmInfo.ProcName;
  DSPLY 'NAMES SET AND AGREE';
ELSE;
  DSPLY 'NAMES DIFFER';
ENDIF;

// The job's user (254) and the current user profile (358) are both set;
// they can differ -- a job can run on behalf of another profile.
line = 'JOB ' + %CHAR(PgmInfo.JobName <> *BLANKS) + ' USER ' +
       %CHAR(PgmInfo.UserName <> *BLANKS) + ' CURUSER ' +
       %CHAR(PgmInfo.CurUser <> *BLANKS) + ' JOBNUM ' + %CHAR(PgmInfo.JobNum > 0);
DSPLY line;

IF PgmInfo.RunDate > 0 AND PgmInfo.RunTime >= 0 AND PgmInfo.RunTime <= 235959;
  DSPLY 'DATE TIME OK';
ELSE;
  DSPLY 'DATE TIME BAD';
ENDIF;

MONITOR;
  // A variable start: a constant one past the string is refused when the
  // program is compiled (IBM: RNF0364).
  s = %SUBST(s : st : 1);
ON-ERROR;
  line = 'ERROR ' + %CHAR(PgmInfo.Status) + ' ' + %CHAR(PgmInfo.PrvStatus) +
         ' ' + PgmInfo.ExcType + PgmInfo.ExcNbr;
  DSPLY line;
  IF PgmInfo.ExcData <> *BLANKS;
    DSPLY 'EXCEPTION DATA SET';
  ENDIF;
ENDMON;

MONITOR;
  b = 10 / a;
ON-ERROR;
  line = 'ERROR ' + %CHAR(PgmInfo.Status) + ' ' + %CHAR(PgmInfo.PrvStatus);
  DSPLY line;
ENDMON;

*INLR = *ON;
