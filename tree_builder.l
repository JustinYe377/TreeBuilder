%{
#include "tree_builder.tab.h"
%}

%%

"buildnode"   { return BUILDNODE; }
"for"         { return FOR; }
"in"          { return IN; }
"["           { return LSQBRACKET; }
":"           { return COLON; }
"]"           { return RSQBRACKET; }
"{"           { return LBRACE; }
"}"           { return RBRACE; }
";"           { return SEMICOLON; }
"="           { return EQUALS; }
"+"           { return PLUS; }
[0-9]+        { yylval.integer_val = atoi(yytext); return INTEGER; }
\"[^\"]+\"    { yylval.string_val = strdup(yytext); return STRING; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.string_val = strdup(yytext); return IDENTIFIER; }
[ \t\n]       ;  // Ignore whitespace and newline
.             { printf("Error: Unexpected character %s\n", yytext); }

%%

int yywrap() {
    return 1;
}