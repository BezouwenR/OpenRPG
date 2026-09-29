**FREE

// Test 91: PSDS with MONITOR/ON-ERROR
// Tests that the PSDS is brought up to date before an ON-ERROR handler
// runs. The status at positions 11-15 is ZONED(5:0) on IBM i: declared
// PACKED, its bytes are not packed decimal data (MCH1202).

DCL-DS PgmSts PSDS QUALIFIED;
  ProcName   CHAR(10) POS(1);
  StatusCode ZONED(5:0) POS(11);
END-DS;

DCL-S x INT(10);
DCL-S zero INT(10) INZ(0);

// Procedure name should be populated
IF %TRIM(PgmSts.ProcName) <> '';
  DSPLY 'PROCNAME SET';
ELSE;
  DSPLY 'PROCNAME EMPTY';
ENDIF;

// Status starts at 0
IF PgmSts.StatusCode = 0;
  DSPLY 'STATUS INIT OK';
ELSE;
  DSPLY 'STATUS INIT BAD';
ENDIF;

// MONITOR block — verifies PSDS syncs before ON-ERROR
MONITOR;
  x = 42;
  DSPLY 'MONITOR OK';
ON-ERROR;
  DSPLY 'ERROR HANDLER';
ENDMON;

// In the handler of a real error, the PSDS holds its status.
MONITOR;
  x = 42 / zero;
ON-ERROR;
  DSPLY ('HANDLER STATUS ' + %CHAR(PgmSts.StatusCode));
ENDMON;

*INLR = *ON;
