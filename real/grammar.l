%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "grammar.tab.h"
int convHex(char* input);
void singleComment();
void multComment();
%}
%%

"#"[^\r\n]*           { singleComment(); }
"/-"                { multComment(); }

"0"[Xx][0-9]+ 	    { yylval.num = (int)strtol(yytext+2, NULL, 16); return NUM; }
[0-9]+ 	            { yylval.num = atoi(yytext); return NUM; }
[0-9]+"."[0-9]* 	{ yylval.num = (int)atof(yytext); fprintf(stderr,"Float/Double are not supported. (Floored to int)"); return NUM;}
[0-9]*"."[0-9]+ 	{ yylval.num = (int)atof(yytext); fprintf(stderr,"Float/Double are not supported. (Floored to int)"); return NUM;}


"++"                {return T_INC;}
">="		        {return T_GE;}
"<="		        {return T_LE;}
"=="		        {return T_EQ;}
">"		            {return T_G;}
"<"		            {return T_L;}
"!="		        {return T_NE;}
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
"["[\t\r\n ]+         {return T_Bracket_L;}
"]"[\t\r\n ]+		    {return T_Bracket_R;}
":"[\t\r\n ]+         {return T_COLON;}
","[\t\r\n ]+          {return T_COMMA;}
"\""[^\"]*"\""		{yylval.str=malloc(yyleng); yytext++; yytext[strlen(yytext)-1] = 0; sprintf(yylval.str,"%s",yytext); return T_STRING; }
"\'"[^\']*"\'"    	{yylval.str=malloc(yyleng); yytext++; yytext[strlen(yytext)-1] = 0; sprintf(yylval.str,"%s",yytext); return T_STRING; }

int[\t ]+		        {return T_INT;}
if[\t\r\n ]+            {return T_IF;}
end           		{return T_END;}
"else"[\t\r\n ]*          {return T_ELSE;}
for[\t ]+             {return T_FOR;}
print[\t ]*           {return T_PRINT;}
printh[\t ]*          {return T_PRINTH;}
newline       		{return T_PRINTLN;}


"("		            {return T_LEFT;}
")"		            {return T_RIGHT;}
"("[ ]*")"		    {} //ignore empty char ( )
\n+		            {}
[\t\b\r\0 ]+              {}
[A-Za-z]+[A-Za-z0-9]*              	{ yylval.str=malloc(yyleng); sprintf(yylval.str,"%s",yytext); return T_NAME; }
.                   				{ fprintf(stderr,"Invalid character \'%s\' ",yytext); }
%%
int convHex(char* input) {
    char* p = input;
    while(*p != 'h' && *p != 'H') {
        p++;
    }
    *p = '\0'; 
    return (int)strtol(input, NULL, 16);
}

void singleComment() {
	while (input() != '\n');
		return;
}

void multComment() {
	for(;;) {
		while (input() != '-');
		if (input() != '/') {
			unput(yytext[yyleng-1]);
		} else {
            if(input() != '\n')
                unput(yytext[yyleng-1]);
			return;
		}
	}	
}

