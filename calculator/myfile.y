%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
extern int yylex();
void yyerror(const char *s);
double result; // Add this line to store the result
%}

%union {
    double value;
}

%token <value> NUMBER
%token PLUS MINUS MULT DIV
%token LPAREN RPAREN

%type <value> expr
%type <value> term
%type <value> factor

%left PLUS MINUS
%left MULT DIV

%%

expr:
      term          { result = $1; }
    | expr PLUS expr { $$ = $1 + $3; result = $$; }
    | expr MINUS expr { $$ = $1 - $3; result = $$; }
    ;

term:
      factor
    | term MULT term { $$ = $1 * $3; }
    | term DIV term { $$ = $1 / $3; }
    ;

factor:
      NUMBER
    | LPAREN expr RPAREN { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur: %s\n", s);
}

int main() {
    printf("Veuillez entrer une expression arithmétique:\n");
    if (yyparse() == 0) {
        printf("Résultat: %lf\n", result);
    }
    return 0;
}
