%token INTEGER
%left '+' '-'
%left '*' '/'

%{
    #include <stdio.h>
    void yyerror(char*);
    void print_stat();
    void clear_stat();
    int yylex();
%}

%%
program:
    program '\n'
    | program expration '\n'    { 
                                    printf("%d\n\n", $2);  
                                    print_stat(); 
                                    clear_stat();
                                }
    | error '\n' {
                        clear_stat();
                        yyerror("Помилка при введенні. Введіть правильні значення.\n");
                    }
    |
    ;
expration: 
    INTEGER                     { $$ = $1; }
    | expration '+' expration   { $$ = $1 + $3; }
    | expration '-' expration   { $$ = $1 - $3; }
    | expration '*' expration   { $$ = $1 * $3; }
    | expration '/' expration   {   
                                    if($3 == 0){
                                        yyerror("Ділення на нуль.");
                                        YYERROR;
                                    }
                                    else{
                                        $$ = $1 / $3; 
                                    }
                                }
    |'(' expration ')'          { $$ = $2; }
    ;
%%

void yyerror(char *s) {
    printf("%s\n", s);
}

int main(void){
    while(1){
        yyparse();
    }
}