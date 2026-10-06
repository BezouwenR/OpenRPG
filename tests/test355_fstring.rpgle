**FREE
// Interpolated strings, an OpenRPG extension: f'...{expr}...' is the
// concatenation of its text and %CHAR of each expression. {{ and }} are
// braces, and a quote is doubled inside the braces as anywhere in a literal.
DCL-S apples INT(10) INZ(4);
DCL-S bananas PACKED(5:2) INZ(3.5);
DCL-S name CHAR(10) INZ('Ada');
DCL-S vname VARCHAR(20) INZ('Grace');
DCL-S today DATE INZ(D'2026-10-06');
DCL-S flag IND INZ(*ON);
DCL-S msg VARCHAR(50);
msg = f'I have {apples} apples and {bananas} bananas';
DSPLY msg;
DSPLY f'[{name}] [{%TRIMR(name)}] [{vname}]';
DSPLY f'{apples * 2 + 1} = twice plus one';
DSPLY f'on {today}, flag {flag}';
DSPLY f'braces: {{literal}} and it''s {%UPPER(''quoted'')}';
DSPLY f'no fields';
msg = 'prefix ' + f'{apples}' + ' suffix';
DSPLY msg;
*INLR = *ON;
RETURN;
