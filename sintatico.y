/* Verificando a sintaxe de programas segundo nossa GLC-exemplo */
/* considerando notacao polonesa para expressoes */
%{
	#include <stdio.h>
	#define YYDEBUG 1
	int yylex (void);
	void yyerror (const char *s);
	extern FILE *yyin;
	extern int yydebug;
	extern int yylineno;
%}
%token NUM
%token ID
%%
/* Regras definindo a GLC e acoes correspondentes */
/* neste nosso exemplo quase todas as acoes estao vazias */
input:    /* empty */
        | input line
;
line:     '\n'
        | programa '\n'  { printf ("Programa sintaticamente correto!\n"); }
;
programa:	'{' lista_cmds '}'	{;}
;
lista_cmds:	cmd			{;}
		| cmd ';' lista_cmds	{;}
;
cmd:		ID '=' exp		{;}
;
exp:		NUM			{;}
		| ID			{;}
		| exp exp '+'		{;}
;
%%

void yyerror (const char *s) {
  printf("Erro sintático: %s line %d\n", s, yylineno);
}

int main (int argc, char *argv[]) {
	int result = 0;

	yydebug = 0;
	yyin = fopen(argv[1], "r");

	result = yyparse();

	if (result)
		printf("Programa com erro sintático!\n");
	else
		printf("Programa sintaticamente correto!\n");
	
	return result;
}