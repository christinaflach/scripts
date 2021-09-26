GCC = cc -g
LEX = flex
YACC = bison
CFLAGS = -DYYDEBUG=1 

parser: cminus.tab.o lex.yy.o ast.o tp2.o
	${GCC} -o parser cminus.tab.o lex.yy.o ast.o tp2.o -ly

cminus.tab.c cminus.tab.h: cminus.y
	${YACC} -vd cminus.y

lex.yy.c: cminus.l
	${LEX} $<

ast.o: ast.c ast.h

tp2.o: tp2.c ast.h

.SUFFIXES: .l .y .c
