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
struct OP* opMaker(char* cmd,char* a,char* b);
struct OP* ifMaker(struct OP* cmpStm,struct OP* doStm);
struct OP* ifElseMaker(struct OP* cmpStm,struct OP* doStm,struct OP* elseStm);
struct OP* labelMaker(char* label);
struct OP* forMaker(struct OP* initStm,struct OP* incStm,struct OP* ifStm);
struct OP* printMaker(char* string);

void addData(char* name,int type,char* value);
struct DATA*  addString(char* value);
void addChild(struct OP* parent,struct OP* child);
void printData();
void printAll(struct OP* printAll,int indent);
void printOptimized(struct OP* parent);
char* itoa(int d);
#define ACC 26
#define TOP 27
#define SIZE 28
%}

%code requires {
    struct OP {
        char cmd[20];
		char a[50];
		char b[50];
		char extra1[5];
		char extra2[5];
        struct OP* child[100];
		int count;
		int id;
    };
	struct DATA {
		char name[50];
		char type[5];
		char value[50];
		struct DATA* next;
	};
}

%union {              /* define stack type */
  int num;
  char c;
  char* str;
  struct OP* op;
  struct DATA* data;
}

%token NUM NUM_H							//ประกาศ token
%token T_INC T_GE T_LE T_EQ T_G T_L T_NE T_ASSIGN 
%token T_VERT T_Bracket_L T_Bracket_R T_COLON T_COMMA T_STRING
%token T_INT T_IF T_OR T_ELSE T_FOR T_BREAK T_PRINT T_END
%token T_SPACE T_NEWLINE T_NAME
%type <str>  T_NAME cmp_tks T_STRING
%type <num> NUM NUM_H exp 
%type <op>  statement statements if_stm assign_stm declare_stm print_stm block for_stm compare var_exp
%type <data> string
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
%right T_POW T_IF T_FOR// ^ กระทำจากซ้ายไปขวา



%start program // S -> ....

%%

program: statements { printf("REACHED\n\n\n"); printData(); printAll($1,0); printOptimized($1); };

statements: { }
	| statement { $$ = (struct OP*)malloc(sizeof(struct OP)); addChild($$,$1); }
    | statements statement {  $$ = $1; addChild($$,$2); }
;

statement: 
      print_stm T_NEWLINE		{ printf("Stm - print\n"); 		$$ = $1; }
    | assign_stm T_NEWLINE		{ printf("Stm - ass\n"); 		$$ = $1;}
	| declare_stm T_NEWLINE		{ printf("Stm - declare\n"); 	$$ = $1;}
    | if_stm T_NEWLINE			{ printf("Stm - if\n"); 		$$ = $1;}
	| for_stm T_NEWLINE			{ printf("Stm - for\n"); 		$$ = $1;}
	| block						{ printf("Stm - Block\n");		$$ = $1;}
;

print_stm: 	T_PRINT exp 				{ $$ = printMaker(itoa($2)); }
			| T_PRINT string			{ $$ = printMaker($2->name); }
;

declare_stm: T_INT T_NAME T_ASSIGN exp { printf("declare+assign\n"); $$ = opMaker($2,"DQ",itoa($4)); }
			| T_INT T_NAME { printf("declare\n"); $$ = opMaker($2,"DQ",itoa(0)); }
;

assign_stm: T_NAME T_ASSIGN exp { printf("assign\n"); $$ = opMaker("MOV",$1,itoa($3)); }
			| T_NAME T_ASSIGN var_exp { printf("assign\n"); $$ = opMaker("MOV",$1,$3->a); addChild($$,$3);}
;

if_stm:     T_IF compare T_COLON statement T_END								{ printf("if\n"); $$ = ifMaker($2,$4);}  
			| T_IF compare T_COLON statement T_ELSE T_COLON statement T_END	{ printf("ifElse\n"); $$ = ifElseMaker($2,$4,$7); }  
;

for_stm:     T_FOR assign_stm T_COMMA assign_stm T_COMMA if_stm	{ printf("for\n"); $$ = forMaker($2,$4,$6);  }  
		
;

block: 	  T_Bracket_L statements T_Bracket_R { $$ = $2; }
;

string:		T_STRING						{ $$ = addString($1);   }
			| exp T_PLUS T_STRING			{ char x[strlen($3)+10]; sprintf(x,"%d%s",$1,$3); $$ = addString(x); 	}
			| T_STRING T_PLUS exp			{ char x[strlen($1)+10]; sprintf(x,"%s%d",$1,$3); $$ = addString(x); 	}
			| T_STRING T_PLUS T_STRING		{ char x[strlen($3)+strlen($1)+1]; sprintf(x,"%s%s",$1,$3); $$ = addString(x); 	}
;



compare:	T_NAME cmp_tks exp					{ printf("cmp\n"); $$ = opMaker("CMP",$1,itoa($3)); 	 	sprintf($$->extra1,"J%c%c",$2[0],$2[1]); sprintf($$->extra2,"J%c%c",$2[2],$2[3]); }
			| T_NAME cmp_tks T_NAME				{ printf("cmp\n"); $$ = opMaker("CMP",$1,$3); 				sprintf($$->extra1,"J%c%c",$2[0],$2[1]); sprintf($$->extra2,"J%c%c",$2[2],$2[3]);  }
			| exp cmp_tks exp					{ printf("cmp\n"); $$ = opMaker("CMP",itoa($1),itoa($3));   sprintf($$->extra1,"J%c%c",$2[0],$2[1]); sprintf($$->extra2,"J%c%c",$2[2],$2[3]);  }
;
cmp_tks:		T_EQ	{ $$ = "EQNE"; }
				| T_NE 	{ $$ = "NEEQ"; }
				| T_GE 	{ $$ = "GEL "; }
				| T_LE 	{ $$ = "LEG "; }
				| T_G 	{ $$ = "G LE"; }
				| T_L 	{ $$ = "L GE"; }

;

var_exp: 	T_NAME T_PLUS exp			{ $$ = opMaker("ADD",$1,itoa($3)); 		}
			| T_NAME T_MINUS exp		{ $$ = opMaker("SUB",$1,itoa($3)); 		}
			| T_MINUS T_NAME  %prec NEG{ $$ =  opMaker("NEG",$2,""); 			}	
;	

exp: 		NUM						{ $$ = $1; 				}
			| NUM_H					{ $$ = $1; 				}
	 		| exp T_PLUS exp		{ $$ = $1 + $3; 		}
			| exp T_MINUS exp		{ $$ = $1 - $3; 		}
			| exp T_MULTIPLY exp	{ $$ = $1 * $3; 		}
			| exp T_DIVIDE exp	 	{ if($3!=0) $$ = $1/$3; else {$$ = $1; 	yyerror("Cannot Divide by zero, Result skips /0 calculation");}		}
			| exp T_MOD exp	 		{ if($3!=0) $$ = $1%$3; else {$$ = $1;	yyerror("Cannot Divide by zero, Result skips \\0 calculation");}	}
			| exp T_POW exp	 		{ $$ =(int)pow($1, $3);	}
			| T_NOT exp	 			{ $$ = ~$2; 			}
			| T_LEFT exp T_RIGHT	{ $$ = $2; 				}
			| T_MINUS exp  %prec NEG{ $$ = -$2; 			}	
;			


%%

int reg[29] = {0};
int id = 0;
struct DATA *data,*datahead;

// main function
int main() {
	printf("================= FLAT Language compiler ==============\n> ");
	data = (struct DATA*)malloc(sizeof(struct DATA));
	sprintf(data->name,"%s","");
	sprintf(data->type,"%s","");
	sprintf(data->value,"%s","");
	data->next = NULL;
	datahead = data;
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

struct OP* opMaker(char* cmd,char* a,char* b) {
	struct OP* newOP = (struct OP*)malloc(sizeof(struct OP));
	newOP->id = id++;
	sprintf(newOP->cmd,"%s",cmd);
	sprintf(newOP->a,"%s",a);
	sprintf(newOP->b,"%s",b);
	newOP->count = 0;
	return newOP;
}

struct OP* labelMaker(char* label) {
	struct OP* newOP = (struct OP*)malloc(sizeof(struct OP));
	newOP->id = id++;
	sprintf(newOP->cmd,"%s%d:",label,newOP->id);
	newOP->count = 0;
	return newOP;
}

struct OP* ifMaker(struct OP* cmpStm,struct OP* doStm) {
	struct OP* ifOp = labelMaker("endif"); 
	addChild(ifOp,cmpStm); 
	addChild(ifOp,opMaker(cmpStm->extra2,ifOp->cmd,"")); 
	addChild(ifOp,doStm); 
	return ifOp;
}
struct OP* ifElseMaker(struct OP* cmpStm,struct OP* doStm,struct OP* elseStm) {
	struct OP* ifOp = labelMaker("endif"); 
	struct OP* elseOp = labelMaker("else"); 
	addChild(ifOp,cmpStm); 
	addChild(ifOp,opMaker(cmpStm->extra2,elseOp->cmd,"")); 
	addChild(ifOp,doStm); 
	addChild(ifOp,elseOp); 
	addChild(ifOp,cmpStm); 
	addChild(ifOp,opMaker(cmpStm->extra1,ifOp->cmd,"")); 
	addChild(ifOp,elseStm); 
	return ifOp;
}

struct OP* forMaker(struct OP* initStm,struct OP* incStm,struct OP* ifStm) {
	struct OP* forOp = labelMaker("endfor"); 
	struct OP* startLabel = labelMaker("startloop");
	addChild(forOp,startLabel); 
	addChild(forOp,initStm); 
	addChild(forOp,ifStm); 
	addChild(ifStm,incStm); 
	addChild(ifStm,opMaker("JMP",startLabel->cmd,""));
	return forOp;
}

struct OP* printMaker(char* string) {
	// mov  dx, msg      ; the address of or message in dx
    // mov  ah, 9        ; ah=9 - "print string" sub-function
    // int  0x21         ; call dos services
	struct OP* printOp = opMaker("int","0x21","");
	addChild(printOp,opMaker("MOV","dx",string)); 
	addChild(printOp,opMaker("MOV","ah","9")); 
	return printOp;
}

void addChild(struct OP* parent,struct OP* child) {
	parent->child[(parent->count)++] = child;
}

char* itoa(int d) {
	char* x = malloc (sizeof (char) * 50);
	sprintf(x, "%d", d); 
	return x;
}

void addData(char* name,int type,char* value) {

}

struct DATA* addString(char* value) {
	struct DATA* newdata = (struct DATA*)malloc(sizeof(struct DATA));
	sprintf(newdata->name,"string%d",id++);
	sprintf(newdata->type,"%s","string");
	strcpy(newdata->value,value);
	newdata->next = NULL;
	data->next = newdata;
	data = data->next;
	return newdata;
}

void printData()  {
	printf(".data\n");
	datahead = datahead->next;
	data = datahead;
	while(data != NULL) {
		printf("%s db \"%s\"\n",data->name,data->value);
		data = data->next;
	}
	printf(".code\n");
}

void printAll(struct OP* parent,int indent) {
	

	int i;
	for(i=0;i<parent->count;i++) {
		printAll(parent->child[i],indent+1);
	}
	for(i=0;i<indent;i++) {
		printf("\t");
	}

	if(strlen(parent->cmd)>0)
		printf("%s ",parent->cmd);
	if(strlen(parent->a)>0)
		printf("%s",parent->a);
	if(strlen(parent->b)>0)
		printf(", %s\n",parent->b);
	else
		printf("\n");
}

void printOptimized(struct OP* parent) {
	
}