**FREE

// Test 88: XML-INTO -- array DS targets. The path names the repeated
// element, from the document's root: path=items/item reads each <item>
// under <items> into one element of the array. An array takes as many as
// it has room for and the rest are ignored: a fixed array its dimension, a
// DIM(*VAR) array its current number of elements (left unchanged), a
// DIM(*AUTO) array its maximum (its number of elements becomes the number
// read).

// Test 1: Fixed DIM array DS
DCL-DS item QUALIFIED DIM(5);
  name VARCHAR(50);
  qty INT(10);
  price PACKED(9:2);
END-DS;

DCL-S xmlItems VARCHAR(500);
// Test 2: DIM(*VAR) array DS
DCL-DS emp QUALIFIED DIM(*VAR:10);
  id INT(10);
  name VARCHAR(40);
END-DS;
DCL-S xmlEmps VARCHAR(500);
DCL-DS staff QUALIFIED DIM(*AUTO:10);
  id INT(10);
  name VARCHAR(40);
END-DS;
DCL-DS pair QUALIFIED DIM(2);
  name VARCHAR(50);
  qty INT(10);
  price PACKED(9:2);
END-DS;

// DSPLY shows at most 52 characters (IBM i RNF7016)
DCL-S dspLine VARCHAR(52);

xmlItems = '<items><item><name>Widget</name><qty>5</qty><price>19.99</price></item><item><name>Gadget</name><qty>3</qty><price>29.50</price></item><item><name>Gizmo</name><qty>10</qty><price>9.95</price></item></items>';

XML-INTO item %XML(xmlItems : 'case=any path=items/item');

dspLine = ('Item 1: ' + item(1).name + ' qty=' + %CHAR(item(1).qty) +
      ' price=' + %CHAR(item(1).price));
DSPLY dspLine;
dspLine = ('Item 2: ' + item(2).name + ' qty=' + %CHAR(item(2).qty) +
      ' price=' + %CHAR(item(2).price));
DSPLY dspLine;
dspLine = ('Item 3: ' + item(3).name + ' qty=' + %CHAR(item(3).qty) +
      ' price=' + %CHAR(item(3).price));
DSPLY dspLine;

xmlEmps = '<employees><emp><id>101</id><name>Alice</name></emp><emp><id>102</id><name>Bob</name></emp></employees>';

// A DIM(*VAR) array: read into as many elements as it currently has.
%ELEM(emp) = 1;
MONITOR;
  XML-INTO emp %XML(xmlEmps : 'case=any path=employees/emp');
  DSPLY ('Var count: ' + %CHAR(%ELEM(emp)));
  dspLine = ('Var 1: ' + %CHAR(emp(1).id) + ' ' + emp(1).name);
  DSPLY dspLine;
ON-ERROR;
  DSPLY ('Var: status ' + %CHAR(%STATUS) + ' count ' + %CHAR(%ELEM(emp)));
ENDMON;

// A DIM(*AUTO) array has as many elements as were read.
XML-INTO staff %XML(xmlEmps : 'case=any path=employees/emp');
DSPLY ('Auto count: ' + %CHAR(%ELEM(staff)));
dspLine = ('Auto 2: ' + %CHAR(staff(2).id) + ' ' + staff(2).name);
DSPLY dspLine;

// More elements than the array holds: the rest are ignored.
XML-INTO pair %XML(xmlItems : 'case=any path=items/item');
dspLine = 'Pair: ' + pair(1).name + ' ' + pair(2).name;
DSPLY dspLine;

RETURN;
