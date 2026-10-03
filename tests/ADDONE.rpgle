**FREE
// The program tests 175, 177, 197 and 198 call. Built with rpgc -shared,
// it is ADDONE.so (.dylib, .dll), named after this file, and found when
// it is called. DCL-PI *N gives the program its parameters; a caller
// passes each by reference.
DCL-PI *N;
  n INT(10);
  msg CHAR(10);
END-PI;
n = n + 1;
msg = 'called';
RETURN;
