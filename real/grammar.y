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

struct DATA *lookup(char *s);

void checkVar(char *name,int mode);
struct DATA* addVar(char *name, char *value);
struct DATA* addInt(char *name, int value);
struct DATA*  addString(char* value);
void addChild(struct OP* parent,struct OP* child);
void printProgram();
void printCode(struct OP* printCode,int indent);
void printOptimized(struct OP* parent);
char* imm(int d);

#define hash_size 100

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
	int isInt;
	char value[50];
	struct DATA* next;
};
%}

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
%token T_INT T_IF T_OR T_ELSE T_FOR T_BREAK T_PRINT T_PRINTLN T_END
%token T_SPACE T_NEWLINE T_NAME
%type <str>  T_NAME cmp_tks T_STRING
%type <num> NUM NUM_H exp 
%type <op>  statement statements if_stm assign_stm declare_stm print_stm block for_stm compare var_exp T_PRINTLN
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

program: statements { printf("REACHED\n\n\n"); printProgram($1); };

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
	| T_PRINTLN					{ printf("Stm - newline\n");	$$ = $1;}
	| block						{ printf("Stm - Block\n");		$$ = $1;}
;

print_stm: 	T_PRINT exp 				{ struct DATA* x = addString(imm($2)); $$ = printMaker(x->name); }
			| T_PRINT T_NAME			{ $$ = printMaker($2); }
			| T_PRINT string			{ $$ = printMaker($2->name); }
;

declare_stm: T_INT T_NAME T_ASSIGN exp { printf("declare+assign\n"); checkVar($2,0); $$ = NULL; addInt($2,$4); }
			| T_INT T_NAME { printf("declare\n"); checkVar($2,0); $$ = NULL; addInt($2,0); }
;

assign_stm: T_NAME T_ASSIGN exp { printf("assign\n"); checkVar($1,1); $$ = opMaker("MOVQ",imm($3),$1); }
			| T_NAME T_ASSIGN T_NAME { printf("assign\n"); checkVar($1,1); checkVar($3,1); if(strcmp($1,$3)==0) $$ = NULL; else {$$ = opMaker("MOVQ","%rax",$1); addChild($$,opMaker("MOVQ",$3,"%rax"));} }
			| T_NAME T_ASSIGN var_exp { printf("assign\n"); checkVar($1,1); if(strcmp($1,$3->a)==0) $$ = $3; else { $$ = opMaker("MOVQ","%rax",$1); addChild($$,$3); addChild($$,opMaker("MOVQ",$3->a,"%rax")); } } 
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



compare:	T_NAME cmp_tks exp					{ printf("cmp\n"); $$ = opMaker("CMPQ",imm($3),$1); 	 	sprintf($$->extra1,"J%c%c",$2[0],$2[1]); sprintf($$->extra2,"J%c%c",$2[2],$2[3]); }
			| T_NAME cmp_tks T_NAME				{ printf("cmp\n"); $$ = opMaker("CMPQ",$3,$1); 				sprintf($$->extra1,"J%c%c",$2[0],$2[1]); sprintf($$->extra2,"J%c%c",$2[2],$2[3]);  }
			| exp cmp_tks exp					{ printf("cmp\n"); $$ = opMaker("CMPQ",imm($3),imm($1));   sprintf($$->extra1,"J%c%c",$2[0],$2[1]); sprintf($$->extra2,"J%c%c",$2[2],$2[3]);  }
;
cmp_tks:		T_EQ	{ $$ = "EQNE"; }
				| T_NE 	{ $$ = "NEEQ"; }
				| T_GE 	{ $$ = "GEL "; }
				| T_LE 	{ $$ = "LEG "; }
				| T_G 	{ $$ = "G LE"; }
				| T_L 	{ $$ = "L GE"; }

;

var_exp: 	T_NAME T_PLUS exp			{ checkVar($1,1); $$ = opMaker("ADDQ",imm($3),$1); 		}
			| T_NAME T_MINUS exp		{ checkVar($1,1); $$ = opMaker("SUBQ",imm($3),$1); 		}

			| exp T_PLUS T_NAME			{ checkVar($3,1); $$ = opMaker("ADDQ",imm($1),$3); 		}
			| exp T_MINUS T_NAME		{ checkVar($3,1); $$ = opMaker("SUBQ",imm($1),$3); 		}

			| T_NAME T_PLUS T_NAME		{ checkVar($1,1); checkVar($3,1); $$ = opMaker("ADDQ",$3,$1); 		}
			| T_NAME T_MINUS T_NAME		{ checkVar($1,1); checkVar($3,1); $$ = opMaker("SUBQ",$3,$1); 		}

			| T_MINUS T_NAME  %prec NEG { checkVar($2,1); $$ =  opMaker("NEG",$2,""); 			}	
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
struct DATA *dataTable[hash_size];
char varName[hash_size][50];
int varCount = 0;

// main function
int main() {
	printf("================= FLAT Language compiler ==============\n> ");
	addVar("FormatStr","%s\\12\\0");
	addVar("FormatInt","%d\\12\\0");
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
	fprintf(stderr, s, ap);
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
	sprintf(newOP->cmd,"%s%d",label,newOP->id);
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
	//printCode(ifOp,0);
	return ifOp;
}

struct OP* forMaker(struct OP* initStm,struct OP* incStm,struct OP* ifStm) {
	struct OP* forOp = labelMaker("endfor"); 
	struct OP* startLabel = labelMaker("startloop");
	addChild(forOp,initStm); 
	addChild(forOp,startLabel); 
	addChild(forOp,ifStm); 
	addChild(ifStm,incStm); 
	addChild(ifStm,opMaker("JMP",startLabel->cmd,""));
	return forOp;
}

struct OP* printMaker(char* varName) {
	// movl 	$FormatStr, %edi
	// movl 	$ToPrint, %esi
	// movl 	$0, %eax
    // call		printf
	struct OP* printOp;
	struct DATA* toPrint = lookup(varName);
	if(toPrint==NULL) {
		yyerror("Variable \"%s\" has not been declared yet.",varName);
		return NULL;
	}

	printOp = opMaker("CALL","printf","");
	addChild(printOp,opMaker("MOVL",varName,"%esi"));

	if(toPrint->isInt == 1) 	
		addChild(printOp,opMaker("MOVL","FormatInt","%esi")); 	
 	else 
		addChild(printOp,opMaker("MOVL","FormatStrng","%esi"));
	
	return printOp;
}

void addChild(struct OP* parent,struct OP* child) {
	if(child == NULL || parent == NULL)
		return;
	parent->child[(parent->count)++] = child;
}

char* imm(int d) {
	char* x = malloc (sizeof (char) * 50);
	sprintf(x, "$%d", d); 
	return x;
}

unsigned hashfn(char *s)
{
    unsigned hashval;
    for (hashval = 0; *s != '\0'; s++)
      hashval = *s + 31 * hashval;
    return hashval % hash_size;
}

struct DATA *lookup(char *s)
{
    struct DATA *newData;
    for (newData = dataTable[hashfn(s)]; newData != NULL; newData = newData->next)
        if (strcmp(s, newData->name) == 0)
          return newData; // found
    return NULL; // not forund
}

void checkVar(char *name,int mode)
{   
    if (lookup(name) == NULL) {
		if(mode != 0) // Check if available
			yyerror("Variable \"%s\" has not been declared yet.",name);
	} else {
		if(mode != 1) 
			yyerror("Variable \"%s\" is previously declared. It will be replaced by the later one.",name);
	}
}

struct DATA *addVar(char *name, char *value)
{
    struct DATA *newData = lookup(name);
    
    if (newData == NULL) { // not exists
        newData = (struct DATA*) malloc(sizeof(struct DATA));
		strcpy(newData->name,name);
		strcpy(newData->value,value);
		newData->isInt = 0;
        unsigned hashval = hashfn(name);
        newData->next = dataTable[hashval];
        dataTable[hashval] = newData;
		strcpy(varName[varCount++],name);
		
    } else { // already exists
		yyerror("This variable is previously declared and will be replaced by the later one.");
		strcpy(newData->value,value);
	} 
    return newData;
}

struct DATA* addInt(char *name, int value) {
	struct DATA *newData = addVar(name, imm(value)+1);
	newData->isInt = 1;
	return newData;
}

struct DATA* addString(char* value) {
	char name[10],value_s[strlen(value)+2];
	sprintf(name,"string%d",id++);
	sprintf(value_s,"\"%s$\"",value);
	return addVar(name, value_s);
}



void printProgram(struct OP* parent)  {
	int i;
	for(i = 0;i<varCount;i++) {
		struct DATA* data = lookup(varName[i]);
		if(data != NULL)
			if(data->isInt==1) 
				printf("%s:\n\t%s %s\n",data->name,".quad",data->value);
			else
				printf("%s:\n\t%s \"%s\"\n",data->name,".string",data->value);
			
	}
	printf(".globl main\n");
	printf("main:\n");
	printf("	pushq   %%rbp\n");
	printCode(parent,0);
	// Exit Int.
	printf("popq %%rbp\n");
    printf("ret\n\n\n");
}

void printCode(struct OP* parent,int indent) {
	int i;
	for(i=0;i<parent->count;i++) {
		printCode(parent->child[i],indent+1);
	}
	for(i=0;i<indent;i++) {
		printf("\t");
	}

	if(strlen(parent->b)>0) { // 2-args op
		printf("%s	%s, %s\n",parent->cmd,parent->a,parent->b); return;
	}
	if(strlen(parent->a)>0) {// 1-arg op
		printf("%s	%s\n",parent->cmd,parent->a); return;
	}
	if(strlen(parent->cmd)>0) {// Label
		printf("%s:\n",parent->cmd); return;
	}
	else
		printf("\n");
}

void printOptimized(struct OP* parent) {
	
}