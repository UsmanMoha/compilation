%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
void yyerror(const char *s);
%}

%union {
    int num;
    char *str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token COMMA

%%

sequence:
    element
    | sequence COMMA element
    ;

element:
    NUMBER { printf("Nombre: %d\n", $1); }
    | IDENTIFIER { printf("Identifiant: %s\n", $1); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur: %s\n", s);
}

int main() {
    printf("Veuillez entrer une séquence de nombres et/ou d'identifiants séparés par des virgules:\n");
    yyparse();
    return 0;
}
