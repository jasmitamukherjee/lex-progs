%{
#include <stdio.h>
#include <stdlib.h>

int valid_for_loop = 1;  // Flag to track if the for loop is valid
int for_found = 0;       // Flag to track if we found "for"
int open_parenthesis = 0; // Flag to track if "(" is found
int close_parenthesis = 0; // Flag to track if ")" is found
int open_brace = 0;       // Flag to track if "{" is found
int close_brace = 0;      // Flag to track if "}" is found
%}

%%

"for"                { for_found = 1; }
"("                  { if (for_found) open_parenthesis = 1; }
")"                  { if (open_parenthesis) close_parenthesis = 1; }
"int"                { if (open_parenthesis && !close_parenthesis) valid_for_loop = 0; }
"="                  { if (open_parenthesis && !close_parenthesis) valid_for_loop = 0; }
"<"                  { if (open_parenthesis && !close_parenthesis) valid_for_loop = 0; }
";"                  { if (open_parenthesis && !close_parenthesis) valid_for_loop = 0; }
"i"                  { if (open_parenthesis && !close_parenthesis) valid_for_loop = 0; }
"10"                 { if (open_parenthesis && !close_parenthesis) valid_for_loop = 0; }
"i++"                { if (open_parenthesis && !close_parenthesis) valid_for_loop = 0; }
"{"                  { if (close_parenthesis) open_brace = 1; }
"}"                  { if (open_brace) close_brace = 1; }

[ \t\n]              { /* Skip whitespace */ }

.                    { valid_for_loop = 0; }  // Invalid character found

%%

int main() {
    printf("Enter the input (Ctrl+D to end):\n");
    yylex();  // Start Lexer's processing

    // After processing all input, check if the loop is valid
    if (valid_for_loop && for_found && open_parenthesis && close_parenthesis && open_brace && close_brace) {
        printf("For loop is Accepted.\n");
    } else {
        printf("For loop is Not Accepted.\n");
    }

    return 0;
}

int yywrap() {
    return 1;  // Indicates end of input
}
