/* recognize tokens for the calculator */ 

%option noyywrap nodefault yylineno
%{
#include "fb3-1.h"
#include "fb3-1.tab.h"

void yyerror(char *s, ...);
%}


%%

"="     { return ASSIGN; }

"+" | 
"-" | 
"*" | 
"/" | 
"(" | 
")" 	{ return yytext[0]; } 

[0-9]+ 	{ yylval = atoi(yytext); return NUMBER; } 
[ \t] 	{ /* ignore white space */ }
\n      { return EOL; }
.   	{ yyerror("Mystery character %c\n", *yytext); }
%%

