%{
#include <stdio.h>
%}


%%
[a-z] { // Match lowercase letters
    putchar(yytext[0] - 'a' + 'A'); // Convert to uppercase
}
[A-Z] { // Match uppercase letters
    putchar(yytext[0] - 'A' + 'a'); // Convert to lowercase
}
. { // Match other characters
    putchar(yytext[0]); // Output as-is
}
\n { // Handle newlines
    putchar('\n');
}

%%

int yywrap() {
    return 1; // Signal end of input
}

int main() {
    printf("Enter text (Ctrl+D to end):\n");
    yylex(); // Start scanning
    return 0;
}
