**FREE
// A { in an interpolated string must be closed.
DCL-S x INT(10);
DCL-S m VARCHAR(20);
m = f'a {x';
*INLR = *ON;
RETURN;
