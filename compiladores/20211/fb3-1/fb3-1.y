%{
#include <stdio.h>
#include <stdlib.h>
#include "fb3-1.h"

/* interface to the lexer */
 
extern int yylineno; /* from lexer */
void yyerror(char *s, ...);
int yylex();
%}

/* declare tokens */ 
%token NUMBER
%token ID
%token ASSIGN
%token ERROR
%token EOL

%start program

%%
program: expr EOL { printf("OK\n"); return 1; }
;

expr: term
| expr '+' term 
;

term: 
  factor 
| term '*' factor
;

factor:
    NUMBER { printf("%d\n",$1); }
|   ID
;

%%

