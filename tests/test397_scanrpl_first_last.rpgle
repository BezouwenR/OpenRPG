**FREE
// %SCANRPL with *FIRST or *LAST, an OpenRPG extension: only the first or
// the last occurrence is replaced, in the whole source or in the portion a
// start and length give.
DCL-S s VARCHAR(40) INZ('{x} and {x} and {x}');
DCL-S r VARCHAR(50);
r = %SCANRPL('{x}' : 'one' : s : *FIRST);
DSPLY r;
r = %SCANRPL('{x}' : 'last' : s : *LAST);
DSPLY r;
r = %SCANRPL('{x}' : 'two' : s : 5 : *FIRST);
DSPLY r;
r = %SCANRPL('{x}' : 'mid' : s : 1 : 12 : *LAST);
DSPLY r;
r = %SCANRPL('{y}' : 'none' : s : *FIRST);
DSPLY r;
*INLR = *ON;
RETURN;
