**FREE
// CTL-OPT DEBUG(*YES): DUMP writes a dump. IBM i writes it to a spooled
// file (QPPGMDMP); rpgc prints it.
CTL-OPT DEBUG(*YES);
DCL-S count INT(10) INZ(5);
DCL-S name CHAR(10) INZ('HELLO');

DUMP;
DSPLY 'AFTER DUMP';

*INLR = *ON;
