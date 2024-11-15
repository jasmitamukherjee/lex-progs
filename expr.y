%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

char* new_temp(void);
void gen_code(char* op, char* arg1, char* arg2, char* result);

%}

%union {
    char* str;
}

%token <str> IDENTIFIER NUMBER
%token PLUS MINUS MUL DIV ASSIGN LPAREN RPAREN
%type <str> expression term factor

%%

program:
    statement
;

statement:
    IDENTIFIER ASSIGN expression {
        printf("%s = %s\n", $1, $3);
    }
;

expression:
    term { $$ = $1; }
    | expression PLUS term {
        $$ = new_temp();
        gen_code("+", $1, $3, $$);
    }
    | expression MINUS term {
        $$ = new_temp();
        gen_code("-", $1, $3, $$);
    }
;

term:
    factor { $$ = $1; }
    | term MUL factor {
        $$ = new_temp();
        gen_code("*", $1, $3, $$);
    }
    | term DIV factor {
        $$ = new_temp();
        gen_code("/", $1, $3, $$);
    }
;

factor:
    NUMBER { $$ = strdup($1); }
    | IDENTIFIER { $$ = strdup($1); }
    | LPAREN expression RPAREN { $$ = $2; }
;

%%

char* new_temp(void) {
    static int counter = 0;
    char* temp = (char*)malloc(10);
    sprintf(temp, "t%d", counter++);
    return temp;
}

void gen_code(char* op, char* arg1, char* arg2, char* result) {
    printf("%s = %s %s %s\n", result, arg1, op, arg2);
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}
