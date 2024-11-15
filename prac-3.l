%{
#include <stdio.h>
int count = 0; // Counter for words starting with 'A'
%}
%option noyywrap

%%
[Aa][a-zA-Z]* { count++; } // Match words starting with 'A' or 'a'
[a-zA-Z]+     ;            // Match other words (ignore)
\n            ;            // Handle new lines
.             ;            // Ignore any other character

%%

int main() {
    printf("Enter text (Ctrl+D to end):\n");
    yylex();
    printf("Number of words starting with 'A' or 'a': %d\n", count);
    return 0;
}
