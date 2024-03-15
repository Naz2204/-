%{
    #include <stdlib.h>
    #include <string.h>
    #include "calculator.tab.h"

    void yyerror(char*);
    void print_stat();
    void clear_stat();

    int numbers_count = 0;
    int numbers[100];

    int operations_count = 0;
    char operations[100];
%}

%%
[0-9]+  {   
            yylval = atoi(yytext);
            numbers[numbers_count] = yylval;  
            numbers_count++;
            return INTEGER;
        }

[()\n] {return *yytext;}

[-+*/]      {
                operations[operations_count] = *yytext;
                operations_count++;
                return *yytext;
            } 

[ \t] {}

\x1b\[[A-D]  {}

exit    {exit(0);}

. {
    char error[100] = "";
    strcat(error, "Заборонений символ: ");
    strncat(error, yytext, 1);
    yyerror(error);
  } 
%%

void print_stat(){
    printf ("Numbers number: %d;\nNumbers: ", numbers_count);
    for (int i = 0; i < numbers_count; i++){
        printf("%d ", numbers[i]);
    }

    printf (";\nOperations number: %d;\nOperations: ", operations_count);
    for (int i = 0; i < operations_count; i++){
        printf("%c ", operations[i]);
    }
    printf(";\n\n");
}

void clear_stat(){
    for (int i = 0; i < numbers_count; i++){
        numbers[i] = 0;
    }
    numbers_count = 0;
    for (int i = 0; i < operations_count; i++){
        operations[i] = '\0';
    }
    operations_count = 0;
}

int yywrap() {
    return 1;
}
