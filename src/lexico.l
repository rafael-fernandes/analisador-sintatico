/* Analisador Lexico */
%{
  # include "sintatico.tab.h"
  int yydebug;
%}
%%
("ler")								{return LER;}
("imprimir")								{return IMPRIMIR;}
("flutuante"|"inteiro")				{return TIPO;}
("se")				{return SE;}
("senao")				{return SENAO;}
("var")								{return VAR;}
("<"|"<="|">"|">="|"==") {return COMP;}
[0-9]+			{return NUM;}
[a-zA-Z][a-zA-Z0-9]*	{return ID;}
[ \t\n]+			{;}
.			{{return yytext[0];}}
%%
int yywrap() {
  return 1;
}