%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>
#include <string.h>
#include <stdarg.h>
extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s,...);
#define ACC 26
#define TOP 27
#define SIZE 28
%}

%union {              /* define stack type */
  int num;
  char c;
  char* str;
}

%token NUM NUM_H							//ประกาศ token
%token T_INC T_GE T_LE T_EQ T_G T_L T_ASSIGN 
%token T_VERT T_Bracket_L T_Bracket_R T_COLON T_COMMA T_STRING
%token T_INT T_IF T_OR T_ELSE T_FOR T_BREAK T_PRINT T_END
%token T_SPACE T_NEWLINE T_NAME
%type <str> T_STRING T_NAME string bool exp statement statements if_stm assign_stm declare_stm print_stm block for_stm
%type <num> NUM NUM_H 
// เรียงลำดับความสำคัญของ token ต่างๆ

%nonassoc LOW; // token มีไว้ให้ rule อ้างอิงถึงกรณีที่ต้องการให้ความสำคัญหลังสุด
%nonassoc T_END;
%nonassoc T_ELSE;
%left T_AND 
%left T_OR  
%left T_PLUS T_MINUS 
%left T_MULTIPLY T_DIVIDE
%left T_MOD
%left T_NOT 

%left T_LEFT // วงเล็บ ()
%left T_RIGHT 


%precedence NEG // token NEG มีไว้ให้ rule เลขติดลบอ้างถึง กรณีที่ให้ความสำคัญทำก่อน operation exp-exp
%right T_POW // ^ กระทำจากซ้ายไปขวา



%start program // S -> ....

%%

program: statements { };

statements: { }
	| statement {  }
    | statements statement { printf("stms %s\n",$2); }
;

statement: 
      print_stm T_NEWLINE	{ printf("Stm - print\n"); }
    | assign_stm T_NEWLINE	{ printf("Stm - ass\n"); }
	| declare_stm T_NEWLINE		{ printf("Stm - declare\n");}
    | if_stm T_NEWLINE		{ printf("Stm - if\n");}
	| for_stm T_NEWLINE		{ printf("Stm - for\n");}
	| block					{ printf("Stm - Block\n"); }
;

print_stm: 	T_PRINT exp 				{ char x[50+strlen($2)]; printf("printNum\n");/*sprintf(x,"%sPRINTnum: %s\n",$2, "reg");*/	$$ = x; }
			| T_PRINT string			{ char x[50+strlen($2)]; printf("printStr\n"); /*sprintf(x,"%sPRINTstr: %s\n",$2, "reg");*/	$$ = x; }
;

declare_stm: T_INT assign_stm { char x[50]; printf("declare\n"); /*sprintf(x,"MOV %s,%s\n",$1,$3); */ $$ = x; }
;

assign_stm: T_NAME T_ASSIGN exp { char x[50]; printf("assign\n"); /*sprintf(x,"MOV %s,%s\n",$1,$3); */ $$ = x; }
;

if_stm:     T_IF bool T_COLON statement T_END								{ char x[50]; printf("if\n");	/*sprintf(x,"[%s] JMP nope\n %s nope: ",$2,$4);*/ $$ = x; }  
			| T_IF bool T_COLON statement T_ELSE T_COLON statement T_END	{ printf("ifElse\n"); char x[50]; 	/*sprintf(x,"ELSE");*/ $$ = x; }  
;

for_stm:     T_FOR assign_stm T_COMMA bool T_COMMA assign_stm T_COLON statement T_END	{ char x[50]; printf("for\n");	/*sprintf(x,"[%s] JMP nope\n %s nope: ",$2,$4);*/ $$ = x; }  
		
;

block: 	  T_Bracket_L statements T_Bracket_R { printf("block\n"); $$ = $2; }
;

string:		T_STRING						{ char x[50+strlen($1)]; /*sprintf(x,"MOV reg,%s\n",$1);*/ $$ = x;	}
			| exp T_PLUS T_STRING			{ $$ = $1; 	}
			| T_STRING T_PLUS exp			{ $$ = $1;	}
			| T_STRING T_PLUS T_STRING		{ $$ = $1;	}
;

bool:		exp	T_EQ exp					{ char x[50+strlen($1)+strlen($3)]; printf("cmp\n");/*sprintf(x,"%s%sCMP %s,%s\n",$1,$3,"reg","reg");*/ $$ = x;	}
;

exp: 		NUM						{ char x[50]; printf("num\n");/*sprintf(x,"MOV reg,%d\n",$1);*/ $$ = x; 	}
			| NUM_H					{ char x[50]; /*sprintf(x,"MOV reg,%d\n",$1);*/ $$ = x; 	}
	 		| exp T_PLUS exp		{ char x[50+strlen($1)+strlen($3)]; /*sprintf(x,"%s%sADD %s,%s\n",$1,$3,"reg","reg");*/ $$ = x; }
			| exp T_MINUS exp		{ char x[50+strlen($1)+strlen($3)]; printf("sub\n");/*sprintf(x,"%s%sSUB %s,%s\n",$1,$3,"reg","reg");*/ $$ = x; }
			| exp T_MULTIPLY exp	{ char x[50+strlen($1)+strlen($3)]; /*sprintf(x,"%s%sMUL %s,%s\n",$1,$3,"reg","reg");*/ $$ = x; }
			| exp T_DIVIDE exp	 	{ char x[50+strlen($1)+strlen($3)]; /*sprintf(x,"%s%sDIV %s,%s\n",$1,$3,"reg","reg");*/ $$ = x; }
			| exp T_MOD exp	 		{ char x[50+strlen($1)+strlen($3)]; /*sprintf(x,"%s%sMOD %s,%s\n",$1,$3,"reg","reg");*/ $$ = x; }
			| exp T_POW exp	 		{ char x[50+strlen($1)+strlen($3)]; /*sprintf(x,"%s%sPOW %s,%s\n",$1,$3,"reg","reg");*/ $$ = x; }
			| T_LEFT exp T_RIGHT	{ $$ = $2; 				}
			| T_MINUS exp  %prec NEG{ char x[50]; /*sprintf(x,"NEG %s\n","reg");*/ $$ = x; }
;			


%%

int reg[29] = {0};

// main function
int main() {
	printf("================= FLAT Language compiler ==============\n> ");
	// Loop parse ในกรณี input file
	yyin = stdin;
	do {
		yyparse();
	} while(!feof(yyin));
	return 0;
}

// error display function
void yyerror(const char* s,...) {
	va_list ap;
	va_start(ap,s);
	fprintf(stderr, "Error: ");
	vfprintf(stderr, s, ap);
	fprintf(stderr, "\n");
}

