%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(char*);

int user_want;
int a_counter;
%}

%token A B NL

%%
prog: 
    check NL      {
                        if (a_counter == user_want) {
                            printf("Correct\n");
                            YYACCEPT;
                        }
                        else {
                            printf("Incorrect %d insted of %d\n", a_counter, user_want);
                            YYABORT;
                        }
                    }
    |;

check:  
    A rep B {a_counter++;}
    | B
;

rep: 
    | A rep {a_counter++;}

;
%%

void yyerror(char* error) {
    printf("Incorrect\n");
}

int main(void) {
    while(1) {
        a_counter = 0;
        printf("Enter ammount of a's or -1 to exit: ");
        scanf("%d", &user_want);
        getchar();
        if(user_want == -1){
            return 0;
        }
        else {
            yyparse();
        }
    }
    return 0;
}