%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "grammar.tab.h"
extern void yyerror(const char* s,...);
int convHex(char* input);
%}
%%

"0"[Xx][0-9]+ 	    { yylval.num = atoi(yytext+2); return NUM_H; }
[0-9]+ 	            { yylval.num = atoi(yytext); return NUM; }
[0-9]+"."[0-9]* 	{ yylval.num = (int)atof(yytext); yyerror("Float/Double are not supported. (Floored to int)"); return NUM;}
[0-9]*"."[0-9]+ 	{ yylval.num = (int)atof(yytext); yyerror("Float/Double are not supported. (Floored to int)"); return NUM;}


"++"                {return T_INC;}
">="		        {return T_GE;}
"<="		        {return T_LE;}
"=="		        {return T_EQ;}
">"		            {return T_G;}
"<"		            {return T_L;}
"="		            {return T_ASSIGN;}

"+"		            {return T_PLUS;}
"-"		            {return T_MINUS;}
"*"		            {return T_MULTIPLY;}
"/"		            {return T_DIVIDE;}
"^"		            {return T_POW;}
"%"		            {return T_MOD;}



"&&"		    {return T_AND;}
"||"	        {return T_OR;}
"!"		        {return T_NOT;}

"|"		            {return T_VERT;}
"["[\t\n ]+         {return T_Bracket_L;}
"]"[\t\n ]+		    {return T_Bracket_R;}
":"[\t\n ]+         {return T_COLON;}
", "                {return T_COMMA;}
"\""[^\"]*"\""      { yylval.str=malloc(yyleng); yytext++; yytext[strlen(yytext)-1] = 0; sprintf(yylval.str,"%s",yytext); return T_STRING; }
"\'"[^\']*"\'"      { yylval.str=malloc(yyleng); yytext++; yytext[strlen(yytext)-1] = 0; sprintf(yylval.str,"%s",yytext); return T_STRING; }

"int"[\t ]+		        {return T_INT;}
"if"[\t\n ]+                {return T_IF;}
"end"                {return T_END;}
"or"[\t\n ]+                {return T_OR;}
"else"[\t\n ]+              {return T_ELSE;}
"for"[\t ]+               {return T_FOR;}
"break"[\t ]+             {return T_BREAK;}
"print"[\t ]+             {return T_PRINT;}


"("		            {return T_LEFT;}
")"		            {return T_RIGHT;}
"("[ ]*")"		    {} //ignore empty ( )
\n+		            {return T_NEWLINE;}
[\t ]+              {}
[A-Za-z]+[A-Za-z0-9]*              {  yylval.str=malloc(yyleng); sprintf(yylval.str,"%s",yytext); return T_NAME;}
.                   {yyerror("Invalid character");}
%%
int convHex(char* input) {
    char* p = input;
    while(*p != 'h' && *p != 'H') {
        p++;
    }
    *p = '\0'; 
    return (int)strtol(input, NULL, 16);
}