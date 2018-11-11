/* Inspiração para a notacao infixa: http://www.cs.man.ac.uk/~pjj/cs212/ho/node4.html */

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
%token TIPO
%token VAR
%token SE
%token SENAO
%token ENQUANTO
%token COMP

%%
/* Regras definindo a GLC e acoes correspondentes */
/* neste nosso exemplo quase todas as acoes estao vazias */

programa: delim_decl '{' lista_cmds '}'	{;}
;

delim_decl:
		
		| VAR decl_var		{;}
;

decl_var:

		| lista_var ':' TIPO ';' decl_var		{;}
;

lista_var:  ID 					{;}
		| ID ',' lista_var		{;}
;

lista_cmds:	cmd			{;}
		| cmd ';' lista_cmds	{;}
;

cmd:		ID '=' exp		{;}
		| IMPRIMIR fator 		{;}
		| LER '(' ID ')'			{;}
		| SE '(' exp ')' '{' lista_cmds '}' {;}
		| SE '(' exp ')' '{' lista_cmds '}' SENAO '{' lista_cmds '}' {;}
		| SE '(' comp ')' '{' lista_cmds '}' {;}
		| SE '(' comp ')' '{' lista_cmds '}' SENAO '{' lista_cmds '}' {;}
		| ENQUANTO '(' exp ')' '{' lista_cmds '}' {;}
		| ENQUANTO '(' comp ')' '{' lista_cmds '}' {;}
;

comp:
	ID COMP exp {;}
	| exp COMP exp {;}
;

exp: 
	termo 			{;}
    | exp '+' termo {;}
    | exp '-' termo {;}
;

termo: 
	fator           	{;}
	| termo '*' fator 	{;}
	| termo '/' fator 	{;}
;

fator: NUM           	{;}
    | ID 		{;}
    | '(' exp ')'       {;}
;
%%

int main (int argc, char *argv[]) 
{
	//yydebug = 1;
	yyin = fopen(argv[1], "r");
	if(yyin == NULL) {
		printf("Problema com a passagem do arquivo pela linha de comando.\n");
	}
	else {
		if(!(yyparse ())) {
			printf("Programa sintaticamente correto!\n");
		}
		fclose(yyin);
	}
	return 0;
}
void yyerror (const char *s) /* Called by yyparse on error */
{
	printf ("Problema com a analise sintatica! \n");
}