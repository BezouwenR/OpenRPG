**FREE
// Test 93: Named data area. The name is quoted: unquoted, DTAARA(x) names a
// variable that holds the data area's name, as on IBM i.
//
// OUT needs the data area locked: IN *LOCK takes the lock, OUT *LOCK
// writes and keeps it, OUT alone writes and releases it, UNLOCK releases
// it. An error ends the program unless MONITOR or (E) handles it.
DCL-S MyConfig CHAR(50) DTAARA('RPGCTEST93');
DCL-S line VARCHAR(52);

MONITOR;
  MyConfig = 'NOT LOCKED';
  OUT MyConfig;
  DSPLY 'OUT WITHOUT LOCK WORKED';
ON-ERROR;
  DSPLY ('OUT without a lock: status ' + %CHAR(%STATUS));
ENDMON;

IN *LOCK MyConfig;
MyConfig = 'VERSION=1.0';
OUT *LOCK MyConfig;
MyConfig = 'VERSION=1.1';
OUT MyConfig;
MyConfig = '';
IN MyConfig;
line = 'READ BACK ' + %TRIM(MyConfig);
DSPLY line;

MONITOR;
  OUT MyConfig;
  DSPLY 'OUT AFTER RELEASE WORKED';
ON-ERROR;
  DSPLY ('OUT after release: status ' + %CHAR(%STATUS));
ENDMON;

OUT(E) MyConfig;
line = 'OUT(E) error ' + %CHAR(%ERROR) + ' status ' + %CHAR(%STATUS);
DSPLY line;

IN *LOCK MyConfig;
UNLOCK MyConfig;
UNLOCK MyConfig;
DSPLY 'UNLOCKED';

*INLR = *ON;
