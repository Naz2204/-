%{
    #include "analize.tab.h"

    void yyerror(char*);
%}

%%
a {return A;}

b {return B;}

[\n] {return NL;}

. {}
%%

int yywrap(){
    return 1;
}