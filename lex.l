%{
    #include<stdio.h>
    int COMMENT = 0;
%}

identifier [a-zA-Z][a-zA-Z0-9]*

RESERVED 	else|if|while|do|foreach|for|begin|int|float|boolean|procedure|var|printf|scanf|return

%%

#.* { printf("\n %s is a preprocessor directive", yytext); }

 {RESERVED} { printf("\n %s is a keyword", yytext); }

"/*" { COMMENT = 1; } { printf("\n %s is a COMMENT", yytext); }

""

{identifier}\( { if (!COMMENT) printf("\nFUNCTION \n %s", yytext); }

\{  { if (!COMMENT) printf("\n BLOCK BEGINS"); }

\} { if (!COMMENT) printf("BLOCK ENDS "); }

{identifier}(\[[0-9]*\])? { if (!COMMENT) printf("\n %s is a IDENTIFIER", yytext); }

\".*\" { if (!COMMENT) printf("\n %s is a STRING", yytext); }

[0-9]+ { if (!COMMENT) printf("\n %s is a NUMBER ", yytext); }

\( { if (!COMMENT) printf("\n %s is an OPEN PARENTHESIS", yytext); }

\) { if (!COMMENT) printf("\n %s is a CLOSE PARENTHESIS", yytext); }


= { if (!COMMENT) printf("\n %s is an ASSIGNMENT OPERATOR", yytext); }

\<= | \>= | < | == | \> { if (!COMMENT) printf("\n %s is a RELATIONAL OPERATOR", yytext); }

[0-9]+(\.[0-9]+)? { if (!COMMENT) printf("\n %s is a NUMBER", yytext); }

[-+*/] { if (!COMMENT) printf("\n %s is an ARITHMETIC OPERATOR", yytext); }

";" { if (!COMMENT) printf("\n %s is a DELIMITER", yytext); }

"," {if (!COMMENT) printf("\n %s is a DELIMITER", yytext); }

%%

int main(int argc, char **argv)
{
    FILE *file;
    file = fopen("input.txt", "r");
    if (!file)
    {
        printf("Could not open the file");
        exit(0);
    }
    yyin = file;
    yylex();
    printf("\n");
    return (0);
}

int yywrap()
{
    return (1);
}