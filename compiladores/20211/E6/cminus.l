%option noyywrap nodefault yylineno
%{ 
#include <string.h>
#include "cminus.tab.h"

void yyerror(char *s, ...);
%}

%%
"//".*	{ /* ignore comment  */ }

[0-9]+  { return NUM; }

"const"  { return CONST; }
"else"   { return ELSE; }
"enum"   { return ENUM; }
"if"     { return IF; }
"int"    { return INT; }
"return" { return RETURN; }
"void"   { return VOID; }
"while"  { return WHILE; }

[A-Za-z][A-Za-z0-9]* { return ID; }
"!="	{ return NEQ; }
"==" 	{ return EQ; }
"<="	{ return LTEQ; }
">=" 	{ return GTEQ; }
"<"		{ return LT; }
">"		{ return GT; }
"++"    { return INCR; }
"--"    { return DECR; }
"&&"    { return AND; }
"||"    { return OR; } 
"!"     { return NOT; }
"="     { return yytext[0]; }
","     { return yytext[0]; }
";" 	{ return yytext[0]; }
"(" 	{ return yytext[0]; }
")" 	{ return yytext[0]; }
"{" 	{ return yytext[0]; }
"}" 	{ return yytext[0]; }
"["     { return yytext[0]; }
"]"     { return yytext[0]; }
"+" 	{ return yytext[0]; }
"-" 	{ return yytext[0]; }
"*"     { return yytext[0]; }
"/"     { return yytext[0]; }
[ \t]   { /* ignore white space */ }
"\n"    { /* ignore white space */ }
. 		{ yyerror("lexical error, character %c", yytext[0]); }
%%

