**FREE
// A subfield named like an operation code needs DCL-SUBF; without it the
// line reads as that operation and the data structure is left open
// (IBM: RNF3556). DCL-SUBF read INT(10) is the declaration.
DCL-DS rec QUALIFIED;
  read INT(10);
END-DS;
*INLR = *ON;
