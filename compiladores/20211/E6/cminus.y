%{
/* includes, C defs */

#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(char *s, ...);
%}


/* declare tokens */
%token NUM
%token ID
%token CONST
%token ELSE 
%token ENUM
%token IF 
%token INT 
%token RETURN 
%token VOID 
%token WHILE
%token EQ
%token NEQ
%token LT
%token GT
%token LTEQ
%token GTEQ
%token AND
%token OR
%token NOT
%token INCR
%token DECR

%nonassoc EQ
%nonassoc NEQ
%nonassoc LT
%nonassoc GT
%nonassoc LTEQ
%nonassoc GTEQ

%start program

%%

program
: declaration-list
;

declaration-list
: declaration
| declaration-list declaration
;

declaration
: var-declaration 
| const-declaration
| enum-declaration
| fun-declaration  
;

var-declaration 
: type-specifier ID ';'
| type-specifier ID '[' NUM ']' ';'
;

const-declaration
: INT CONST ID '=' NUM ';' /* only NUM */
;

enum-declaration
: ENUM ID '{' constant-list '}' ';'
;

constant-list
: ID
| constant-list ',' ID

fun-declaration 
: type-specifier ID '(' params ')' compound-stmt
;

type-specifier
: INT  
| VOID
| ENUM ID '{' constant-list '}'
| ENUM ID 
;

params
: VOID
| param-list
;

param-list
: param
| param-list ',' param 
;

param 
: type-specifier ID
| type-specifier ID '[' ']'
;

compound-stmt 
: '{' local-declarations statement-list '}' 
;

local-declarations
: /* empty */
| local-declarations var-declaration
;

statement-list
: /* empty */
| statement-list statement
;

statement 
: expression-stmt 
| compound-stmt 
| selection-stmt
| iteration-stmt 
| return-stmt 
;

expression-stmt
: expression ';'
| ';'           
;

selection-stmt 
: IF '(' expression ')' statement
| IF '(' expression ')' statement ELSE statement 
;

iteration-stmt 
: WHILE '(' expression ')' statement 
;

return-stmt
: RETURN ';' 
| RETURN expression ';' 
;

expression
: lhs '=' logical_or_expression
| logical_or_expression
;

lhs
: ID
| ID '[' expression ']'
;

logical_or_expression
: logical_and_expression
| logical_or_expression OR logical_and_expression

logical_and_expression
: relational_expression
| logical_and_expression AND relational_expression
;

relational_expression  /* nonassoc */
: additive-expression
| additive-expression relational_op additive-expression 
;

relational_op
: LTEQ | LT | GT | GTEQ | EQ | NEQ
;

additive-expression
: multiplicative-expression
| additive-expression '+' multiplicative-expression
| additive-expression '-' multiplicative-expression
;

multiplicative-expression
: unary_expression
| multiplicative-expression '*' unary_expression
| multiplicative-expression '/' unary_expression
;

unary_expression
: factor
| NOT factor
| INCR factor
| DECR factor
;

factor
: NUM
| ID
| '(' expression ')'
| ID '[' expression ']'
| ID '(' ')'
| ID '(' args-list ')'

args-list
: expression
| args-list ',' expression  
;

%%


