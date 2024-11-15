%{
#include <stdio.h>
#include "y.tab.h"  // Include the Yacc header file generated after parsing
%}

%%

"for"                { return FOR; }
"int"                { return INT; }
"="                  { return ASSIGN; }
"<"                  { return LESS_THAN; }
";"                  { return SEMICOLON; }
"++"                 { return INCREMENT; }
"("                  { return LPAREN; }
")"                  { return RPAREN; }
"{"                  { return LBRACE; }
"}"                  { return RBRACE; }
[0-9]+               { return NUMBER; }
[A-Za-z_][A-Za-z0-9_]* { return IDENTIFIER; }  // Recognizes identifiers (variable names)
[ \t\n]              { /* Skip whitespace */ }
.                    { return INVALID; }  // Any invalid characters.

%%

int yywrap() {
    return 1;  // End of input.
}
