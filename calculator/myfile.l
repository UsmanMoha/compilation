%{
#include <stdio.h>
#include "y.tab.h"
%}

DIGIT [0-9]
WHITESPACE [ \t\n]

%%

{DIGIT}+\.?{DIGIT}* { yylval.value = atof(yytext); return NUMBER; }
\.?{DIGIT}+ { yylval.value = atof(yytext); return NUMBER; }
\+ { return PLUS; }
\- { return MINUS; }
\* { return MULT; }
\/ { return DIV; }
\( { return LPAREN; }
\) { return RPAREN; }
{WHITESPACE}+ { /* Ignore whitespace */ }
. { printf("Caractère inconnu: %s\n", yytext); return yytext[0]; }

%%

int yywrap() {
    return 1;
}
