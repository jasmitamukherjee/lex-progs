%{
#include <stdio.h>
#include <stdlib.h>

// Declare the yylex() function (Lex) and yytext (Lex global variable)
extern int yylex();
extern char* yytext;  // Declare yytext as a global variable from Lex
void yyerror(const char *s);  // Declare the error function

int valid_for_loop = 1;  // Flag to track if the for loop is valid.
%}

%token FOR INT ASSIGN LESS_THAN SEMICOLON INCREMENT LPAREN RPAREN LBRACE RBRACE NUMBER IDENTIFIER INVALID
%left ASSIGN

%%

program:
    | program statement
    ;

statement:
    FOR LPAREN declaration SEMICOLON expression SEMICOLON action RPAREN LBRACE RBRACE {
        printf("For loop is Accepted.\n");
    }
    | FOR LPAREN INVALID { 
        printf("For loop is Not Accepted: Invalid syntax.\n"); 
        valid_for_loop = 0; 
    }
    ;

declaration:
    INT IDENTIFIER ASSIGN NUMBER {
        // Use yytext to get the value of the identifier and number
        printf("Declaration: int %s = %s\n", yytext, yytext);
    }
    ;

expression:
    IDENTIFIER LESS_THAN NUMBER {
        printf("Expression: %s < %s\n", yytext, yytext);
    }
    ;

action:
    IDENTIFIER INCREMENT {
        printf("Action: %s++\n", yytext);
    }
    ;

%%

int main() {
    printf("Enter the input (Ctrl+D to end):\n");
    yyparse();  // Start parsing
    if (!valid_for_loop) {
        printf("For loop is Not Accepted.\n");
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
