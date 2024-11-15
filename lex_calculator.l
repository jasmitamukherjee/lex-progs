%{
#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
%}

NUMBER [0-9]+
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*

%%
{NUMBER}        { yylval.num = atoi(yytext); return NUMBER; }
{IDENTIFIER}    { yylval.str = strdup(yytext); return IDENTIFIER; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"="             { return ASSIGN; }
\n              { return 0; }
.               { return yytext[0]; }
%%
int yywrap(void) {
    return 1;
}
