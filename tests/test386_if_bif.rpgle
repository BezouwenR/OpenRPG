**FREE
// %IF(condition : value if true : value if false), an OpenRPG extension
// in the form IBM suggested for the conditional-operator request: numbers,
// strings, an indicator condition, nesting, and only the chosen value
// evaluated (the other would divide by zero).
DCL-S rating INT(10) INZ(4);
DCL-S salary PACKED(9:2) INZ(1000);
DCL-S bonus PACKED(9:2) INZ(250);
DCL-S pay PACKED(9:2);
DCL-S name CHAR(10) INZ('Ada');
DCL-S addr VARCHAR(20);
DCL-S nullInd INT(5) INZ(-1);
DCL-S flag IND INZ(*ON);
DCL-S n INT(10);
pay = salary + %IF(rating > 3 : bonus : 0);
DSPLY %CHAR(pay);
addr = %IF(nullInd = -1 : 'n/a' : name);
DSPLY addr;
DSPLY %IF(flag : 'on' : 'off');
DSPLY ('[' + %IF(NOT flag : name : %TRIMR(name)) + ']');
n = %IF(rating > 5 : 1 : %IF(rating > 3 : 2 : 3));
DSPLY %CHAR(n);
n = %IF(rating = 4 : 10 : 10 / (rating - 4));
DSPLY %CHAR(n);
*INLR = *ON;
RETURN;
