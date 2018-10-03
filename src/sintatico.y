/* Verificando a sintaxe de programas segundo nossa GLC-exemplo */
/* considerando notacao polonesa para expressoes */
%{
#include <stdio.h> 
#define YYDEBUG 1
extern FILE *yyin;
int yylex (void);
void yyerror (const char *s);
extern int yydebug;
%}
%token NUM
%token ID
%token IMPRIMIR
%token LER
%%
/* Regras definindo a GLC e acoes correspondentes */
/* neste nosso exemplo quase todas as acoes estao vazias */
programa:	'{' lista_cmds '}'	{;}
;
lista_cmds:	cmd			{;}
		| cmd ';' lista_cmds	{;}
;
cmd:		ID '=' exp		{;}
		| IMPRIMIR '(' exp ')' 		{;}
		| LER '(' ID ')'			{;}
;
exp:		NUM			{;}
		| ID			{;}
		| exp exp '+'		{;}
;
%%
int main (int argc, char *argv[]) 
{
	/*yydebug = 1*/
	yyin = fopen(argv[1], "r");
	if(yyin == NULL) {
		printf("Problema com a passagem do arquivo pela linha de comando.\n");
		return 0;
	}
	if(!(yyparse ())) {
		printf("Programa sintaticamente correto!\n");
	}
}
void yyerror (const char *s) /* Called by yyparse on error */
{
	printf ("Problema com a analise sintatica!\n");
}

