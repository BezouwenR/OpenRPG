**FREE
// FOR-EACH item IN array INDEX(i), an OpenRPG extension: i is the current
// element's position, from 1 -- so the loop can change array(i).
DCL-S names VARCHAR(10) DIM(*AUTO : 10);
DCL-S name VARCHAR(10);
DCL-S i INT(10);
DCL-S scores INT(10) DIM(3) INZ(%LIST(5 : 7 : 9));
DCL-S s INT(10);
names(*NEXT) = 'Ada';
names(*NEXT) = 'Grace';
names(*NEXT) = 'Alan';
FOR-EACH name IN names INDEX(i);
  DSPLY (%CHAR(i) + ': ' + name);
ENDFOR;
FOR-EACH s IN scores INDEX(i);
  scores(i) = s * 10;
ENDFOR;
DSPLY (%CHAR(scores(1)) + ' ' + %CHAR(scores(3)) + ' last i ' + %CHAR(i));
*INLR = *ON;
RETURN;
