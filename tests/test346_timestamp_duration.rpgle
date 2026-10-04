**FREE
// A timestamp plus or minus a duration, in every unit: across a day, a
// month and a year end, to the last day of a shorter month, and a leap day.
// A date and a time minus a duration too.
DCL-S ts TIMESTAMP INZ(Z'2024-12-31-23.59.59.000000');
DCL-S d DATE INZ(D'2024-03-01');
DCL-S t TIME INZ(T'00.30.00');
ts = ts + %SECONDS(1);
DSPLY %CHAR(ts);
ts = ts + %DAYS(1);
DSPLY %CHAR(ts);
ts = ts - %HOURS(1);
DSPLY %CHAR(ts);
ts = ts - %MSECONDS(1);
DSPLY %CHAR(ts);
ts = ts + %MINUTES(90);
DSPLY %CHAR(ts);
ts = Z'2024-01-31-12.00.00.000000' + %MONTHS(1);
DSPLY %CHAR(ts);
ts = ts - %YEARS(1);
DSPLY %CHAR(ts);
ts = Z'2024-02-29-00.00.00.000000' + %YEARS(4);
DSPLY %CHAR(ts);
ts = Z'2024-03-01-00.00.00.000000' - %DAYS(400);
DSPLY %CHAR(ts);
d = d - %DAYS(1);
t = t - %HOURS(1);
DSPLY %CHAR(d);
DSPLY %CHAR(t);
*INLR = *ON;
RETURN;
