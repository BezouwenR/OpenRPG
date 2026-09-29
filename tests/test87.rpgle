**FREE

// Test 87: XML-INTO -- parse XML into a data structure, matched as IBM i
// matches it. The options decide the match: case=lower (the default) wants
// the XML's names in lower case, case=any in any case; allowmissing=no (the
// default) wants an element for every subfield, allowextra=no a subfield for
// every element; the outermost element is named as the variable, unless a
// path names it. A document that does not match is status 353. With
// allowmissing=yes a subfield with no element keeps its value.

DCL-DS order QUALIFIED;
  id INT(10);
  customer VARCHAR(50);
  item VARCHAR(30);
  qty INT(10);
  price PACKED(9:2);
END-DS;

DCL-S xmlData VARCHAR(500);

DCL-DS person QUALIFIED;
  name VARCHAR(40);
  age INT(10);
  city VARCHAR(30);
END-DS;
DCL-S xmlPerson VARCHAR(300);
DCL-DS config QUALIFIED;
  host VARCHAR(50);
  port INT(10);
  debug VARCHAR(10);
END-DS;
DCL-S xmlConfig VARCHAR(300);
DCL-DS partial QUALIFIED INZ;
  x INT(10);
  y INT(10);
  label VARCHAR(20);
END-DS;
DCL-S xmlPartial VARCHAR(200);
DCL-DS msg QUALIFIED;
  text VARCHAR(100);
  sender VARCHAR(50);
END-DS;
DCL-S xmlMsg VARCHAR(300);

// DSPLY shows at most 52 characters (IBM i RNF7016)
DCL-S dspLine VARCHAR(52);

// case=any: any case matches.
xmlData = '<order><ID>1001</ID><Customer>Acme Corp</Customer><Item>Widget</Item>' +
          '<QTY>25</QTY><Price>19.99</Price></order>';
XML-INTO order %XML(xmlData : 'case=any');
DSPLY ('Order: ' + %CHAR(order.id));
dspLine = ('Customer: ' + order.customer);
DSPLY dspLine;
DSPLY ('Item: ' + order.item);
DSPLY ('Qty: ' + %CHAR(order.qty));
DSPLY ('Price: ' + %CHAR(order.price));

xmlPerson = '<person><Name>Alice</Name><Age>30</Age><City>Boston</City></person>';
XML-INTO person %XML(xmlPerson : 'case=any');
DSPLY ('Name: ' + person.name);
DSPLY ('Age: ' + %CHAR(person.age));
DSPLY ('City: ' + person.city);

// Attributes supply subfields too.
xmlPerson = '<person name="Bob" age="44" city="Rome"/>';
XML-INTO person %XML(xmlPerson : 'case=any');
dspLine = 'Attr: ' + person.name + ' ' + %CHAR(person.age) + ' ' + person.city;
DSPLY dspLine;

// No options: case=lower, so the names must be lower case.
xmlConfig = '<config><host>localhost</host><port>8080</port><debug>true</debug></config>';
XML-INTO config %XML(xmlConfig);
dspLine = ('Host: ' + config.host);
DSPLY dspLine;
DSPLY ('Port: ' + %CHAR(config.port));
DSPLY ('Debug: ' + config.debug);

MONITOR;
  xmlConfig = '<config><HOST>h</HOST><PORT>1</PORT><DEBUG>no</DEBUG></config>';
  XML-INTO config %XML(xmlConfig);
  DSPLY 'UPPER CASE MATCHED';
ON-ERROR;
  DSPLY ('Upper case, no case=any: status ' + %CHAR(%STATUS));
ENDMON;

// allowmissing=yes: a subfield with no element keeps its value.
partial.y = 7;
xmlPartial = '<partial><x>42</x></partial>';
XML-INTO partial %XML(xmlPartial : 'allowmissing=yes');
DSPLY ('X: ' + %CHAR(partial.x));
DSPLY ('Y: ' + %CHAR(partial.y));
DSPLY ('Label: [' + partial.label + ']');

MONITOR;
  XML-INTO partial %XML(xmlPartial);
  DSPLY 'MISSING MATCHED';
ON-ERROR;
  DSPLY ('Missing elements: status ' + %CHAR(%STATUS));
ENDMON;

// The outermost element is named as the variable, unless a path names it.
xmlPartial = '<point><x>1</x><y>2</y><label>p</label></point>';
MONITOR;
  XML-INTO partial %XML(xmlPartial);
  DSPLY 'OTHER NAME MATCHED';
ON-ERROR;
  DSPLY ('Other name: status ' + %CHAR(%STATUS));
ENDMON;
XML-INTO partial %XML(xmlPartial : 'path=point');
DSPLY ('Path: ' + %CHAR(partial.x) + ' ' + %CHAR(partial.y) + ' ' + partial.label);

// Entities are decoded.
xmlMsg = '<message><text>Price &lt; $10 &amp; tax</text><sender>Smith</sender></message>';
XML-INTO msg %XML(xmlMsg : 'case=any path=message');
dspLine = ('Text: ' + msg.text);
DSPLY dspLine;
dspLine = ('Sender: ' + msg.sender);
DSPLY dspLine;

// allowextra=no (the default): an element with no subfield is an error.
xmlMsg = '<msg><text>hi</text><sender>Ann</sender><extra>x</extra></msg>';
MONITOR;
  XML-INTO msg %XML(xmlMsg);
  DSPLY 'EXTRA MATCHED';
ON-ERROR;
  DSPLY ('Extra element: status ' + %CHAR(%STATUS));
ENDMON;
XML-INTO msg %XML(xmlMsg : 'allowextra=yes');
dspLine = 'Allowed extra: ' + msg.text + ' ' + msg.sender;
DSPLY dspLine;

RETURN;
