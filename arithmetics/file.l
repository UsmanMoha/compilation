%{
#include <stdio.h>
#include "y.tab.h"
%}

DIGIT [0-9]
ALPHA [a-zA-Z]
WHITESPACE [ \t\n]

%%

{ALPHA}({ALPHA}|{DIGIT})* { yylval.str = strdup(yytext); return IDENTIFIER; }
{DIGIT}+(\.{DIGIT}+)? { yylval.value = atof(yytext); return NUMBER; }
{WHITESPACE}+   { /* Ignore whitespace */ }
\+              { return PLUS; }
\-              { return MINUS; }
\*              { return MULT; }
\/              { return DIV; }
\(              { return LPAREN; }
\)              { return RPAREN; }
=               { return ASSIGN; }
;               { return SEMICOLON; }
.               { printf("Unknown character: %s\n", yytext); }

%%

#define MAX_VARIABLES 100

typedef struct {
    char *name;
    double value;
} Variable;

Variable variables[MAX_VARIABLES];
int variable_count = 0;

void update_variable(char *name, double value) {
    for (int i = 0; i < variable_count; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            variables[i].value = value;
            return;
        }
    }

    if (variable_count < MAX_VARIABLES) {
        variables[variable_count].name = strdup(name);
        variables[variable_count].value = value;
        variable_count++;
    } else {
        fprintf(stderr, "Error: too many variables\n");
    }
}

double get_variable_value(char *name) {
    for (int i = 0; i < variable_count; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            return variables[i].value;
        }
    }
    fprintf(stderr, "Error: variable %s not found\n", name);
    return 0;
}

