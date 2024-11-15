%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

IDENTIFIER [a-zA-Z][a-zA-Z0-9]*
NUMBER [0-9]+(\.[0-9]+)?
%%
{IDENTIFIER}   { yylval.str = strdup(yytext); return IDENTIFIER; }
{NUMBER}       { yylval.str = strdup(yytext); return NUMBER; }
"+"            { return PLUS; }
"-"            { return MINUS; }
"*"            { return MUL; }
"/"            { return DIV; }
"="            { return ASSIGN; }
"("            { return LPAREN; }
")"            { return RPAREN; }
\n             { return 0; }
.              { return yytext[0]; }
%%
int yywrap(void) {
    return 1;
}
