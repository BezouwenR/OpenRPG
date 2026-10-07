**FREE
// %LOOKUP(%KDS(key {: n}) : ds(*) {: start {: count}}), an OpenRPG extension:
// the first element whose subfields equal the key data structure's
// subfields of the same name -- or its first n.
DCL-DS line QUALIFIED DIM(4);
  ord INT(10);
  seq INT(5);
  item CHAR(6);
END-DS;
DCL-DS key QUALIFIED;
  ord INT(10);
  seq INT(5);
END-DS;
line(1).ord = 7;
line(1).seq = 1;
line(1).item = 'BOLT';
line(2).ord = 7;
line(2).seq = 2;
line(2).item = 'NUT';
line(3).ord = 8;
line(3).seq = 1;
line(3).item = 'GEAR';
line(4).ord = 7;
line(4).seq = 2;
line(4).item = 'NUT2';
key.ord = 7;
key.seq = 2;
DSPLY %CHAR(%LOOKUP(%KDS(key) : line(*)));
DSPLY line(%LOOKUP(%KDS(key) : line(*))).item;
DSPLY %CHAR(%LOOKUP(%KDS(key) : line(*) : 3));
key.ord = 8;
DSPLY %CHAR(%LOOKUP(%KDS(key : 1) : line(*)));
key.seq = 9;
DSPLY %CHAR(%LOOKUP(%KDS(key) : line(*)));
*INLR = *ON;
RETURN;
