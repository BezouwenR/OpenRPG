**FREE
// OPTIONS(*UPPER) and OPTIONS(*LOWER), an OpenRPG extension: a CONST or VALUE
// character argument arrives upper- or lower-cased; the caller's field is
// unchanged. They combine with *TRIM.
DCL-PR code VARCHAR(20);
  c VARCHAR(10) CONST OPTIONS(*UPPER);
END-PR;
DCL-PR mail VARCHAR(30);
  m VARCHAR(30) VALUE OPTIONS(*LOWER : *TRIM);
END-PR;
DCL-S raw VARCHAR(10) INZ('abc-1');
DSPLY code(raw);
DSPLY raw;
DSPLY mail('  Ada@Example.COM  ');
*INLR = *ON;
RETURN;

DCL-PROC code;
  DCL-PI *N VARCHAR(20);
    c VARCHAR(10) CONST OPTIONS(*UPPER);
  END-PI;
  RETURN c;
END-PROC;

DCL-PROC mail;
  DCL-PI *N VARCHAR(30);
    m VARCHAR(30) VALUE OPTIONS(*LOWER : *TRIM);
  END-PI;
  RETURN '<' + m + '>';
END-PROC;
