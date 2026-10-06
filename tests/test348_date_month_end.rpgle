**FREE
// A date plus or minus months or years keeps its day, cut back to the last
// day of a shorter month: Jan 31 + 1 month is Feb 28 or 29, as on IBM i.
DCL-S d DATE;
d = D'2024-01-31' + %MONTHS(1);
DSPLY %CHAR(d);
d = D'2023-01-31' + %MONTHS(1);
DSPLY %CHAR(d);
d = D'2024-02-29' + %YEARS(1);
DSPLY %CHAR(d);
d = D'2024-03-31' - %MONTHS(1);
DSPLY %CHAR(d);
d = D'2024-05-31' + %MONTHS(-14);
DSPLY %CHAR(d);
d = D'2024-12-31' + %DAYS(1);
DSPLY %CHAR(d);
d = D'2024-03-10' + %DAYS(1);
DSPLY %CHAR(d);
*INLR = *ON;
RETURN;
