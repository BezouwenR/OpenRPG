**FREE
// DUMP writes a dump only when the program is compiled with CTL-OPT
// DEBUG(*YES), or when it is DUMP(A) (tests 313, 314). Without either, as
// here, it does nothing -- on IBM i too.
DCL-S count INT(10) INZ(5);
DCL-S name CHAR(10) INZ('HELLO');
DCL-S rate PACKED(7:2) INZ(3.14);

count = count + 1;

DUMP;

DSPLY ('AFTER DUMP ' + %CHAR(count));

*INLR = *ON;
