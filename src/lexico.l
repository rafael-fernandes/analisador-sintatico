/* Analisador Lexico */
%{
  # include "sintatico.tab.h"
%}
%%
("ler")								{return LER;}
("imprimir")								{return IMPRIMIR;}
[0-9]+			{return NUM;}
[a-zA-Z][a-zA-Z0-9]*	{return ID;}
[ \t\n]+			{;}
.			{return yytext[0];}
%%
int yywrap() {
  return 1;
}