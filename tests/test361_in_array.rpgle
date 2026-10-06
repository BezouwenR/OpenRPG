**FREE
// x IN array: the right operand of IN may be an array, fixed-size or
// varying, as well as %LIST or %RANGE.
DCL-S codes CHAR(1) DIM(3);
DCL-S nums INT(10) DIM(*VAR : 5);
DCL-S code CHAR(1) INZ('B');

codes(1) = 'A';
codes(2) = 'B';
codes(3) = 'C';
%ELEM(nums) = 2;
nums(1) = 10;
nums(2) = 20;
IF code IN codes;
  DSPLY 'B in codes';
ENDIF;
IF 'Z' IN codes;
  DSPLY 'wrong';
ELSE;
  DSPLY 'Z not in codes';
ENDIF;
IF 20 IN nums;
  DSPLY '20 in nums';
ENDIF;
IF 30 IN nums;
  DSPLY 'wrong';
ELSE;
  DSPLY '30 not in nums';
ENDIF;
*INLR = *ON;
RETURN;
