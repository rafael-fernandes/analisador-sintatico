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
%token PRINT
%token READ

%%
/* Regras definindo a GLC e acoes correspondentes */
/* neste nosso exemplo quase todas as acoes estao vazias */

input: /* empty */
       | input line
;

line:  '\n'
       | programa '\n'  { printf ("Programa sintaticamente correto!\n"); }
;

programa:	'{' lista_cmds '}'	{;}
;

lista_cmds:	cmd			{;}
					  | cmd ';' lista_cmds	{;}
;

cmd: ID '=' exp		{;}
		 | PRINT '(' exp ')' 		{;}
		 | READ '(' ID ')'			{;}
;
exp: NUM			{;}
		 | ID			{;}
		 | exp exp '+'		{;}
;

%%

int main (int argc, char *argv[]) {
	/*yydebug = 1*/
	yyin = fopen(argv[1], "r");
	yyparse ();
}

/* Called by yyparse on error */
void yyerror (const char *s) {
	printf ("Problema com a analise sintatica!\n");
}