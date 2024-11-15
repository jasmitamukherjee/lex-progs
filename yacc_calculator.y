%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);

%}

%union {
    int num;
    char *str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token PLUS MINUS MUL DIV LPAREN RPAREN ASSIGN

%type <num> expression term factor

%%

program:
    statement
    | program statement
;

statement:
    IDENTIFIER ASSIGN expression {
        printf("%s = %d\n", $1, $3);
        free($1);  // Free the memory allocated for the identifier string
    }
    | expression {
        printf("Result = %d\n", $1);
    }
;

expression:
    term {
        $$ = $1;
    }
    | expression PLUS term {
        $$ = $1 + $3;
    }
    | expression MINUS term {
        $$ = $1 - $3;
    }
;

term:
    factor {
        $$ = $1;
    }
    | term MUL factor {
        $$ = $1 * $3;
    }
    | term DIV factor {
        if ($3 == 0) {
            yyerror("Error: Division by zero.");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
;

factor:
    NUMBER {
        $$ = $1;
    }
    | IDENTIFIER {
        // For simplicity, we just assign 0 to identifiers
        $$ = 0;
    }
    | LPAREN expression RPAREN {
        $$ = $2;
    }
    | MINUS factor {
        $$ = -$2;
    }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter an arithmetic expression: ");
    yyparse();
    return 0;
}
