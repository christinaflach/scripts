%option noyywrap
%{ 
#define NUM 1
#define ID 2
#define KEY 3
#define SYM 4
#define ERROR 5

int lines = 1;
%}
int yylex(void);

%%

"//".*                      { /* no action */ }
const                       { return KEY; }
else                        { return KEY; }
enum                        { return KEY; }
if                          { return KEY; }
int                         { return KEY; }
return                      { return KEY; }
void                        { return KEY; }
while                       { return KEY; }
[A-Za-z]([A-Za-z]|[0-9])*   { return ID; }
[0-9]+                      { return NUM; }
("+"|"-"|"*"|"/")           { return SYM; }
("="|"<"|">")               { return SYM; }
("<="|">="|"=="|"!=")       { return SYM; }
(";"|",")                   { return SYM; }
("("|")"|"["|"]"|"{"|"}")   { return SYM; }
("++"|"--")                 { return SYM; }
("!"|"&&"|"||")             { return SYM; }
[\n]                        { lines++; }
[ \t]                       { /* no action */ }
.                           { return ERROR; }


%%

int main(int argc, char **argv) {
    int token;

    while ((token = yylex())) {
        switch (token) {
         case ERROR:
            printf("(%d,ERROR,\"%s\")\n", lines, yytext);
            exit(0);
         case NUM: 
            printf("(%d,NUM,\"%s\")\n", lines, yytext);
            break; 
         case ID: 
            printf("(%d,ID,\"%s\")\n", lines, yytext);
            break;
         case KEY:
            printf("(%d,KEY,\"%s\")\n", lines, yytext);
            break;
         case SYM: 
            printf("(%d,SYM,\"%s\")\n", lines, yytext);
            break;
        }
    }
}

