/* compiler.c
 * Função main para testar o TP2 (ainda sem ações semânticas)
 * Disciplina MATA61-UFBA 
 * Christina von Flach (github: christinaflach)
 * 2020
*/

#include "cminus.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

extern char *yytext;
int yyparse();
void yyerror(char *s, ...);


int main(int argc, char **argv) {
// using stdin and stdout
    int status = yyparse();

    if (!status) 
        printf("no syntax errors found\n");
}

void yyerror(char *s, ...) {
    extern int yylineno;
    va_list ap; va_start(ap, s);

    fprintf(stderr, "error at or before line %d, near lexeme %s: ", yylineno, yytext);
    vfprintf(stderr, s, ap);
    fprintf(stderr, "\n");
    exit(0);
}


