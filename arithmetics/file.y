%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
extern int yylex();
void yyerror(const char *s);
void update_variable(char *name, double value);
double get_variable_value(char *name);
%}

%union {
    double value;
    char *str;
}

%token <value> NUMBER
%token <str> IDENTIFIER
%token PLUS MINUS MULT DIV
%token LPAREN RPAREN
%token ASSIGN
%token SEMICOLON

%type <value> expr
%type <value> term
%type <value> factor

%left PLUS MINUS
%left MULT DIV

%%

program:
      statement
    | program statement
    ;

statement:
      expr SEMICOLON { printf("Résultat: %lf\n", $1); }
    | IDENTIFIER ASSIGN expr SEMICOLON { update_variable($1, $3); printf("%s = %lf\n", $1, $3); }
    ;

expr:
      term
    | expr PLUS expr { $$ = $1 + $3; }
    | expr MINUS expr { $$ = $1 - $3; }
    ;

term:
      factor
    | term MULT term { $$ = $1 * $3; }
    | term DIV term { $$ = $1 / $3; }
    ;

factor:
      NUMBER
    | IDENTIFIER { $$ = get_variable_value($1); }
    | LPAREN expr RPAREN { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
