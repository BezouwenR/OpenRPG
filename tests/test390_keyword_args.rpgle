**FREE
// Keyword arguments, name => value, an OpenRPG extension: in any order,
// after positional ones, an *OMIT parameter left out passed as *OMIT and
// *NOPASS ones after the last given not passed.
DCL-PR greet VARCHAR(40);
  name VARCHAR(20) CONST;
  title VARCHAR(10) CONST OPTIONS(*OMIT);
  suffix VARCHAR(10) CONST OPTIONS(*NOPASS);
END-PR;
DCL-S total INT(10);
DSPLY greet(name => 'Ada');
DSPLY greet(title => 'Dr.' : name => 'Grace');
DSPLY greet('Alan' : suffix => 'PhD');
DSPLY greet(suffix => 'Jr.' : name => 'Bob' : title => 'Mr.');
addTo(total : amount => 5);
addTo(amount => 7 : target => total);
DSPLY %CHAR(total);
*INLR = *ON;
RETURN;

DCL-PROC greet;
  DCL-PI *N VARCHAR(40);
    name VARCHAR(20) CONST;
    title VARCHAR(10) CONST OPTIONS(*OMIT);
    suffix VARCHAR(10) CONST OPTIONS(*NOPASS);
  END-PI;
  DCL-S r VARCHAR(40);
  r = name;
  IF %ADDR(title) <> *NULL;
    r = title + ' ' + r;
  ENDIF;
  IF %PARMS >= 3;
    r += ', ' + suffix;
  ENDIF;
  RETURN r;
END-PROC;

DCL-PROC addTo;
  DCL-PI *N;
    target INT(10);
    amount INT(10) VALUE;
  END-PI;
  target += amount;
END-PROC;
