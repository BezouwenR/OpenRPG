**FREE
// A program's parameter needs a length.
DCL-PR pgm EXTPGM('PGM1');
  s CHAR;
END-PR;
DCL-S t CHAR;
pgm(t);
*INLR = *ON;
RETURN;
