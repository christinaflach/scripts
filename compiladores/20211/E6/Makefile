CC = cc -g
LEX = flex
YACC = bison
CFLAGS = -DYYDEBUG=1 

cminus : cminus.tab.o lex.yy.o compiler.o
	${CC} -o cminus cminus.tab.o lex.yy.o compiler.o -ly
    
cminus.tab.c cminus.tab.h : cminus.y
	${YACC} -vd cminus.y

lex.yy.c : cminus.l
	${LEX} $<

.SUFFIXES: .l .y .c
