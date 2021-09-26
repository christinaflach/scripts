GCC = cc -g
LEX = flex
CFLAGS = -DYYDEBUG=1 

lexer: lex.yy.o 
	${GCC} -o lexer lex.yy.o -ll

lex.yy.c: lexer.flex
	${LEX} $<

lex.yy.o: lex.yy.c

.SUFFIXES: .flex .c
