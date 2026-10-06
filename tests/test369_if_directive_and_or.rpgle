**FREE
// Several conditions in one /IF or /ELSEIF, an OpenRPG extension: AND, OR,
// NOT and parentheses over DEFINED(name), and a // comment after them.
/DEFINE LINUX
/DEFINE FAST
/IF DEFINED(LINUX) AND NOT DEFINED(NOGUI)
DSPLY 'linux with gui';
/ENDIF
/IF DEFINED(WINDOWS) OR DEFINED(MACOS)
DSPLY 'wrong';
/ELSEIF (DEFINED(LINUX) OR DEFINED(BSD)) AND DEFINED(FAST) // a comment
DSPLY 'fast unix';
/ELSE
DSPLY 'wrong';
/ENDIF
/IF NOT (DEFINED(A) OR DEFINED(B))
DSPLY 'neither A nor B';
/ENDIF
/IF DEFINED(*OPENRPG) AND DEFINED(LINUX)
DSPLY 'openrpg';
/ENDIF
*INLR = *ON;
RETURN;
