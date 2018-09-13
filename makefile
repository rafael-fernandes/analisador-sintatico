CC = gcc
SRC = src
FLEX = flex
BISON = bison
TESTS_DIR = tests

default: analisador

analisador:
	$(FLEX) $(SRC)/lexico.l
	$(BISON) -d $(SRC)/sintatico.y
	$(CC) -ll sintatico.tab.c lex.yy.c

run:
	./a.out tests/program.orn

clean: 
	rm sintatico.tab.c
	rm sintatico.tab.h
	rm lex.yy.c
	rm a.out
	clear