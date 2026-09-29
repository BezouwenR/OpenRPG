**FREE

// Test 102: SND-MSG — send messages to stderr. IBM i writes *INFO, *DIAG
// and *COMP to the job log; rpgc has none, so it prints them.

DCL-S msg VARCHAR(100);

// *INFO — informational message
SND-MSG *INFO 'Starting process';

// *DIAG — diagnostic message
msg = 'Diagnostic: value out of range';
SND-MSG *DIAG msg;

// *COMP — completion message, sent to the caller
SND-MSG *COMP 'Processing complete' %TARGET(*CALLER);

// Plain form — defaults to *INFO
SND-MSG 'Default info message';

// *ESCAPE goes to the caller and ends the procedure, as on IBM i:
// test312.

DSPLY 'Done';

RETURN;
