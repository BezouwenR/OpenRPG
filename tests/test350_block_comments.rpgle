**FREE
// Block comments, an OpenRPG extension: /* ... */ on one line or across
// several, after a statement, inside an expression; not inside a string.
/* A block comment
   across several lines, with a ; and 'quotes' and // inside
*/
DCL-S x INT(10) INZ(5);   /* after a declaration */
DCL-S s VARCHAR(20) INZ('a /* not */ b');
x = x /* inline */ + 1;
DSPLY %CHAR(x); /* after a statement's semicolon */
DSPLY s;
x = x / 2;
DSPLY %CHAR(x);
/**
 * A doc-style comment.
 **/
// a line comment with /* in it
*INLR = *ON;
RETURN;
