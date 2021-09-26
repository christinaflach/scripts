#include <stdio.h> 
#include <stdlib.h> 
#include <stdarg.h>
#include "fb3-1.h"
#include "fb3-1.tab.h"

/* interface to the lexer */

extern int yylineno; 
void yyerror(char *s, ...);

struct ast *
    newast(int nodetype, struct ast *l, struct ast *r) {
    struct ast *a = malloc(sizeof(struct ast));
    if(!a) {
        yyerror("out of space");
        exit(0); 
    }
    a->nodetype = nodetype; 
    a->l = l;
    a->r = r;
    return a;
}

struct ast * newnum(int d) {
    struct numval *a = malloc(sizeof(struct numval));
    if(!a) {
        yyerror("out of space");
        exit(0); 
    }
    a->nodetype = 'K'; 
    a->number = d;
    return (struct ast *)a;
}

void
prettyprint(struct ast *a) {
    switch(a->nodetype) {
        case '+': { printf("[ADD "); prettyprint(a->l); printf(" "); prettyprint(a->r); printf("]"); break; }
        case '-': { printf("[SUB "); prettyprint(a->l); printf(" "); prettyprint(a->r); printf("]"); break; }
        case '*': { printf("[MUL "); prettyprint(a->l); printf(" "); prettyprint(a->r); printf("]"); break; }
        case '/': { printf("[DIV "); prettyprint(a->l); printf(" "); prettyprint(a->r); printf("]"); break; }
/* one subtree */ 
        case 'M': { printf("[ABS "); prettyprint(a->l); printf("]"); break; }
/* no subtree */ 
        case 'K': { printf("[%d]", ((struct numval *)a)->number); break; }
        default:  { printf("internal error: free bad node %c\n", a->nodetype); }
    }
}

void
yyerror(char *s, ...)
{
    va_list ap; va_start(ap, s);
    fprintf(stderr, "%d: error: ", yylineno); 
    vfprintf(stderr, s, ap);
    fprintf(stderr, "\n");
}

int main()
{
    printf("> ");
    int result =  yyparse(); 
    exit(0);
}
