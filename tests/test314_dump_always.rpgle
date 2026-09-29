**FREE
// DUMP(A) writes a dump whatever DEBUG says. IBM i writes it to a spooled
// file (QPPGMDMP); rpgc prints it.
DCL-S count INT(10) INZ(7);

DUMP(A);
DSPLY 'AFTER DUMP';

*INLR = *ON;
