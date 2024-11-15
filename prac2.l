%{
#include<stdio.h>
#include<string.h>

int keyword_count = 0, identifier_count = 0, word_count = 0, line_count = 0, space_count = 0, comment_count = 0;

// Array of keywords in C
char *keywords[] = {"int", "float", "if", "else", "for", "while", "return", "void", "char", "double"};

int is_keyword(char *word) {
    for (int i = 0; i < 10; i++) {
        if (strcmp(word, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}
%}

%%

"/*"([^*]|\*+[^*/])*\*+"/" {
    comment_count++;
} // Matches multi-line comments

"//".* { 
    comment_count++;
} // Matches single-line comments

[a-zA-Z_][a-zA-Z0-9_]* {
    if (is_keyword(yytext)) {
        keyword_count++;
    } else {
        identifier_count++;
    }
    word_count++;
}

[0-9]+ { 
    word_count++;
} // Matches numbers

[ \t]+ { 
    space_count += yyleng;
} // Matches spaces and tabs

\n { 
    line_count++;
} // Matches new lines

. { 
    // Do nothing for other characters
}

%%

int main() {
    printf("Enter the input text (press Ctrl+D or Ctrl+Z to end):\n");
    yylex();

    printf("\nResults:\n");
    printf("Number of lines: %d\n", line_count);
    printf("Number of keywords: %d\n", keyword_count);
    printf("Number of identifiers: %d\n", identifier_count);
    printf("Number of words: %d\n", word_count);
    printf("Number of comments: %d\n", comment_count);
    printf("Number of spaces: %d\n", space_count);

    return 0;
}

int yywrap() {
    return 1;
}
