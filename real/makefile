all: grammar


grammar.tab.c grammar.tab.h:	grammar.y
	bison -d grammar.y

lex.yy.c: grammar.l grammar.tab.h
	flex grammar.l

grammar: lex.yy.c grammar.tab.c grammar.tab.h
	gcc -o grammar grammar.tab.c lex.yy.c -lm
	./grammar input.txt

clean:
	rm grammar grammar.tab.c lex.yy.c grammar.tab.h

compile:
	gcc input.txt.s -o input.txt.o
	./input.txt.o