%{
#include <stdio.h>
#include "y.tab.h"
%}

DIGIT [0-9]
ALPHA [a-zA-Z]
WHITESPACE [ \t\n]

%%

{ALPHA}({ALPHA}|{DIGIT})* { yylval.str = strdup(yytext); return IDENTIFIER; }
{DIGIT}+ { yylval.num = atoi(yytext); return NUMBER; }
{WHITESPACE}+   { /* Ignorer les espaces */ }
,               { return COMMA; }
.               { printf("Caractère inconnu: %s\n", yytext); }

%%
