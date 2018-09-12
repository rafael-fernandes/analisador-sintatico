CC = gcc
CFLAGS =
FLEX = flex
BISON = bison

BISONFLAGS= -dvt
# -d: gera arquivo de cabecalho
# -v: relata detalhes sobre estados do automato
# -t: rastreia passo a passo da analise sintatica

INPUT_DIR= ./input
OUTPUT_DIR= ./src
TESTS_DIR= ./tests
SRC_DIR= ./
INCLUDE_DIR= ./include

all = main
LEXICON = lexico.l
LEXICON_OUT = lex.yy.c
SYNTACTIC = sintatico.y
SYNTACTIC_FULL_OUT = sintatico.tab.c sintatico.tab.h sintatico.output
SYNTACTIC_OUT = sintatico.tab.c
SYNTACTIC_LIB_OUT = sintatico.tab.h

ANALYSER = analisador
FILES = $(shell ls tests/*mlp)

default: analyser

analyser: $(OBJS)
	$(FLEX) $(INPUT_DIR)/$(LEXICON)
	$ mkdir -p src
	$ mkdir -p include
	$ mv $(LEXICON_OUT) $(OUTPUT_DIR)

	$(BISON) $(BISONFLAGS) $(INPUT_DIR)/$(SYNTACTIC)
	$ mv $(SYNTACTIC_FULL_OUT) $(OUTPUT_DIR)
	$ cp $(OUTPUT_DIR)/$(SYNTACTIC_LIB_OUT) $(INCLUDE_DIR)
	$(CC) $(CFLAGS) $(OUTPUT_DIR)/$(SYNTACTIC_OUT) $(OUTPUT_DIR)/$(LEXICON_OUT) -o $(ANALYSER)

run:
	./$(ANALYSER) $(TESTS_DIR)/*.mlp

clean:
	rm -f $(ANALYSER) src/* include/*
	clear