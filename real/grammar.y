%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>
#include <string.h>
#include <stdarg.h>
#include <unistd.h>
extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s,...);

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
	char reg[50];
	int isInt;
	char value[50];
	struct DATA* next;
};

struct OP* opMaker(char* cmd,char* a,char* b);
struct OP* ifMaker(struct OP* cmpStm,struct OP* doStm);
struct OP* ifElseMaker(struct OP* cmpStm,struct OP* doStm,struct OP* elseStm);
struct OP* labelMaker(char* label);
struct OP* forMaker(struct OP* initStm,struct OP* incStm,struct OP* ifStm);
struct OP* printMaker(struct DATA* toPrint);
struct OP* printIntMaker(int value);
struct OP* printHexMaker(struct DATA* toPrint);
struct OP* printIntHexMaker(int value);
struct OP* printVarExpMaker(struct OP* varExp);

struct DATA* addVar(char *name, char *value);
struct DATA* addString(char* value);
struct DATA* addInt(char* varName);
void addChild(struct OP* parent,struct OP* child);
void printProgram();
void printCode(struct OP* printCode,int indent);
unsigned hashfn(char *s);
struct DATA *lookup(char *s);
struct DATA *checkVar(char *s);
char* imm(int d);
void showToken();

#define hash_size 100


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
%token T_INT T_IF T_ELSE T_FOR T_PRINT T_PRINTH T_PRINTLN T_END
%token T_SPACE T_NEWLINE T_NAME T_SAD T_SMILE
%type <str>  T_NAME cmp_tks T_STRING
%type <num> NUM NUM_H exp 
%type <op>  statement statements if_stm assign_part assign_stm print_stm block for_stm compare var_exp T_PRINTLN
%type <data> string
// เรียงลำดับความสำคัญของ token ต่างๆ

%precedence LOW
%nonassoc T_END
%nonassoc T_ELSE
%right T_PRINT T_PRINTH
%right T_INC T_GE T_LE T_EQ T_G T_L T_NE T_ASSIGN 
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

program: statements { printf("Compiled... :)\n\n\n"); printProgram($1); };

statements: { }
	| statement                     { $$ = (struct OP*)malloc(sizeof(struct OP)); addChild($$,$1); }
    | statements statement          { $$ = $1; addChild($$,$2); }
    | statements error statement    { $$ = $1; addChild($$,$3); yyerrok; fprintf(stderr,"Error: Bad Statement\n"); } 
;

statement: 
      print_stm 		{ /*printf("Stm - print\n");*/ 		        $$ = $1; }
	| assign_stm 		{ /*printf("Stm - declare/assign\n");*/ 	$$ = $1;}
    | if_stm 			{ /*printf("Stm - if\n");*/ 		        $$ = $1;}
	| for_stm 		    { /*printf("Stm - for\n");*/ 		        $$ = $1;}
	| block				{ /*printf("Stm - Block\n");*/		        $$ = $1;}

;


;

print_stm: 	  T_PRINT exp 			    { $$ = printIntMaker($2); }
			| T_PRINT T_NAME			{ $$ = printMaker(checkVar($2)); }
            | T_PRINT var_exp			{ $$ = printVarExpMaker($2); }
			| T_PRINT string			{ $$ = printMaker($2); }
			| T_PRINTH exp				{ $$ = printIntHexMaker($2); }
			| T_PRINTH T_NAME			{ $$ = printHexMaker(checkVar($2)); }
			| T_PRINTH string			{ $$ = NULL; fprintf(stderr,"Error: Can't print string as hex"); }
			| T_PRINTLN					{ $$ = printMaker(checkVar(".NewLine")); }
            | T_SMILE					{ $$ = printMaker(checkVar(".Smile")); }
            | T_SAD					    { $$ = printMaker(checkVar(".Sad")); }
;


assign_stm: T_INT T_NAME assign_part 
                    { 
                        //printf("declare+assign\n"); 
                        if(strcmp($3->b,$2)==0) {
                            $$ = NULL;
                        } else {
                            sprintf($3->b,"%s",addInt($2)->reg); 
                            $$ = $3; 
                        }
                        
                    }
			| T_INT T_NAME 
                    { 
                        //printf("declare\n"); 
                        $$ = opMaker("MOVQ","$0",addInt($2)->reg); 
                    }
            | T_NAME assign_part 
                    { 
                        //printf("assign\n"); 
                        sprintf($2->b,"%s",checkVar($1)->reg); 
                        $$ = $2; 
                    }
;

assign_part: T_ASSIGN exp 
                {   
                    $$ = opMaker("MOVQ",imm($2),""); 
                }
			| T_ASSIGN T_NAME 
                {    
                    $$ = opMaker("MOVQ","%rax",""); 
                    addChild($$,opMaker("MOVQ",checkVar($2)->reg,"%rax"));
                }
			| T_ASSIGN var_exp 
                { 
                    
                    $$ = opMaker("MOVQ","%rax",""); 
                    addChild($$,$2); 
                } 
;

if_stm:     T_IF compare T_COLON statement T_END								
                { 
                    //printf("if\n"); 
                    $$ = ifMaker($2,$4);
                }  
			| T_IF compare T_COLON statement T_ELSE T_COLON statement T_END	
                { 
                    //printf("ifElse\n"); 
                    $$ = ifElseMaker($2,$4,$7); 
                }  
;

for_stm:     T_FOR assign_stm T_COMMA assign_stm T_COMMA if_stm	
                { 
                    //printf("for\n"); 
                    $$ = forMaker($2,$4,$6);  
                }  
		
;

block: 	  T_Bracket_L statements T_Bracket_R { $$ = $2; };

string:		T_STRING						
                { 
                    $$ = addString($1);   
                }
			| exp T_PLUS T_STRING			
                { 
                    char x[strlen($3)+10]; 
                    sprintf(x,"%d%s",$1,$3); 
                    $$ = addString(x); 
                }
			| T_STRING T_PLUS exp			
                { 
                    char x[strlen($1)+10]; 
                    sprintf(x,"%s%d",$1,$3); $$ = addString(x); 	
                }
			| T_STRING T_PLUS T_STRING		
                { 
                    char x[strlen($3)+strlen($1)+1]; 
                    sprintf(x,"%s%s",$1,$3); $$ = addString(x); 	
                }
;



compare:	exp cmp_tks exp					
                { 
                    //printf("cmp %d %d\n",$1,$3);
                    $$ = opMaker("CMPQ",imm($3),imm($1));   
                    sprintf($$->extra1,"J%c%c",$2[0],$2[1]); 
                    sprintf($$->extra2,"J%c%c",$2[2],$2[3]);  
                }
            
            | var_exp cmp_tks exp					
                { 
                    //printf("cmp %d\n",$3);
                    $$ = opMaker("CMPQ",imm($3),"%rax"); 	 	
                    addChild($$,$1);
                    sprintf($$->extra1,"J%c%c",$2[0],$2[1]); 
                    sprintf($$->extra2,"J%c%c",$2[2],$2[3]); 
                }
			| exp cmp_tks var_exp				
                { 
                    //printf("cmp %d\n",$1);
                    $$ = opMaker("CMPQ","%rax",imm($1)); 
                    addChild($$,$3);	
                    sprintf($$->extra1,"J%c%c",$2[0],$2[1]); 
                    sprintf($$->extra2,"J%c%c",$2[2],$2[3]);  
                }
            | var_exp cmp_tks var_exp					
                { 
                    //printf("cmp\n");
                    $$ = opMaker("CMPQ","%rbx","%rax");   
                    addChild($$,$3);
                    addChild($$,opMaker("MOVQ","%rax","%rbx"));
                    addChild($$,$1);
                    
                    sprintf($$->extra1,"J%c%c",$2[0],$2[1]); 
                    sprintf($$->extra2,"J%c%c",$2[2],$2[3]);  
                }
            | T_STRING cmp_tks var_exp					
                { fprintf(stderr,"Error: Can't compare string\n"); } 
            | var_exp cmp_tks T_STRING					
                { fprintf(stderr,"Error: Can't compare string\n"); } 

            
;
cmp_tks:		T_EQ	{ $$ = "EQNE"; } 
				| T_NE 	{ $$ = "NEEQ"; }
				| T_GE 	{ $$ = "GEL "; }
				| T_LE 	{ $$ = "LEG "; }
				| T_G 	{ $$ = "G LE"; }
				| T_L 	{ $$ = "L GE"; }

;

var_exp: 	T_NAME                      
                { 
                    char comment[50];
                    sprintf(comment,"%%rax\t# %s",$1);
                    $$ = opMaker("MOVQ ",checkVar($1)->reg,comment); 
                }
            | var_exp T_PLUS var_exp    
                { 
                    $$ = opMaker("ADDQ","%rbx","%rax"); 
                    addChild($$,$3); 
                    addChild($$,opMaker("MOVQ","%rax","%rbx")); 
                    addChild($$,$1); 
                }
            | var_exp T_MINUS var_exp    
                { 
                    $$ = opMaker("SUBQ","%rbx","%rax"); 
                    addChild($$,$3); 
                    addChild($$,opMaker("MOVQ","%rax","%rbx")); 
                    addChild($$,$1); 
                }    
            | var_exp T_MULTIPLY var_exp			
                { 
                    // movq	-24(%rbp), %rax
                    // cqto
                    // idivq	-16(%rbp)
                    // movq	%rax, -24(%rbp)
                    $$ = opMaker("IMULQ","%rbx","");
                    addChild($$,$3);
                    addChild($$,opMaker("MOVQ","%rax","%rbx")); 
                    
                    addChild($$,$1);
                }
            | var_exp T_DIVIDE var_exp			
                { 
                    // movq	-24(%rbp), %rax
                    // cqto
                    // idivq	-16(%rbp)
                    // movq	%rax, -24(%rbp)
                    $$ = opMaker("IDIVQ","%rbx","");
                    addChild($$,$3);
                    addChild($$,opMaker("MOVQ","%rax","%rbx")); 
                    
                    addChild($$,$1);
                    
                    addChild($$,opMaker("","CQTO",""));		
                }
            | var_exp T_MOD var_exp			
                { 
                    // movq	-24(%rbp), %rax
                    // cqto
                    // idivq	-16(%rbp)
                    // movq	%rax, -24(%rbp)
                    $$ = opMaker("MOVQ","%rdx","%rax");
                    addChild($$,$3);
                    addChild($$,opMaker("MOVQ","%rax","%rbx")); 
                    
                    addChild($$,$1);
                    
                    addChild($$,opMaker("","CQTO",""));		
                    addChild($$,opMaker("IDIVQ","%rbx","")); 
                }

            | var_exp T_PLUS exp			
                { 
                    $$ = opMaker("ADDQ",imm($3),"%rax");
                    addChild($$,$1);		
                }
            | var_exp T_MINUS exp			
                { 
                    $$ = opMaker("SUBQ",imm($3),"%rax");
                    addChild($$,$1);		
                }
            | var_exp T_MULTIPLY exp			
                { 
                    $$ = opMaker("IMULQ","%rbx","");
                    addChild($$,$1);
                    addChild($$,opMaker("MOVQ",imm($3),"%rbx"));	
                }
            | var_exp T_DIVIDE exp			
                { 
                    $$ = opMaker("IDIVQ","%rbx","");
                    addChild($$,$1);
                    addChild($$,opMaker("MOVQ",imm($3),"%rbx"));
                    addChild($$,opMaker("","CQTO",""));		
                }
            | var_exp T_MOD exp			
                { 
                    $$ = opMaker("MOVQ","%rax","%rax");
                    addChild($$,$1);
                    addChild($$,opMaker("MOVQ",imm($3),"%rbx"));
                    addChild($$,opMaker("IDIVQ","%rbx",""));	
                    addChild($$,opMaker("","CQTO",""));	
                }


            | exp T_PLUS var_exp			
                { 
                    $$ = opMaker("ADDQ",imm($1),"%rax");
                    addChild($$,$3);		
                }
            | exp T_MINUS var_exp			
                { 
                    $$ = opMaker("SUBQ","%rbx","%rax");
                    addChild($$,$3);		
                    addChild($$,opMaker("MOVQ","%rax","%rbx"));	
                    addChild($$,opMaker("MOVQ",imm($1),"%rax"));
                }
            | exp T_MULTIPLY var_exp			
                { 
                    $$ = opMaker("IMULQ","%rbx","");
                    addChild($$,$3);
                    addChild($$,opMaker("MOVQ",imm($1),"%rbx"));	
                }
            | exp T_DIVIDE var_exp			
                { 
                    $$ = opMaker("IDIVQ","%rbx","");
                    addChild($$,$3);
                    addChild($$,opMaker("MOVQ","%rax","%rbx"));
                    addChild($$,opMaker("MOVQ",imm($1),"%rbx"));
                    addChild($$,opMaker("","CQTO",""));		
                }
            | exp T_MOD var_exp			
                { 
                    $$ = opMaker("MOVQ","%rdx","%rax");
                    addChild($$,$3);
                    addChild($$,opMaker("MOVQ","%rax","%rbx"));
                    addChild($$,opMaker("MOVQ",imm($1),"%rbx"));
                    addChild($$,opMaker("","CQTO",""));	
                    addChild($$,opMaker("IDIVQ","%rbx",""));	
                }
			| T_MINUS T_NAME  %prec NEG 
                { 
                    $$ =  opMaker("NEG","%rax",""); 		
                    addChild($$,opMaker("MOVQ",checkVar($2)->reg,"%rax"));	
                }	
            | T_STRING T_PLUS var_exp					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $3; } 
            | var_exp T_PLUS T_STRING					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $1; } 
            | T_STRING T_MINUS var_exp					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $3; } 
            | var_exp T_MINUS T_STRING					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $1; } 
            | T_STRING T_MULTIPLY var_exp					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $3; } 
            | var_exp T_MULTIPLY T_STRING					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $1; } 
            | T_STRING T_DIVIDE var_exp					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $3; } 
            | var_exp T_DIVIDE T_STRING					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $1; } 
            | T_STRING T_MOD var_exp					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $3; } 
            | var_exp T_MOD T_STRING					
                { fprintf(stderr,"Error: Can't do math operation with string\n"); $$ = $1; } 
            | T_LEFT var_exp T_RIGHT	{ $$ = $2; 	   }
            | var_exp exp          { $$ = $1;   fprintf(stderr,"Error: Missing an operator, Taking only variable operand...\n");  }
            | exp var_exp          { $$ = $2;  fprintf(stderr,"Error: Missing an operator, Taking only variable operand...\n");  }
            
;	

;

exp: 		NUM						{ $$ = $1; 				}
			| NUM_H					{ $$ = $1; 				}
	 		| exp T_PLUS exp		{ $$ = $1 + $3; 		}
			| exp T_MINUS exp		{ $$ = $1 - $3; 		}
			| exp T_MULTIPLY exp	{ $$ = $1 * $3; 		}
			| exp T_DIVIDE exp	 	{ if($3!=0) $$ = $1/$3; else {$$ = $1; 	fprintf(stderr,"Error: Cannot Divide by zero, Result skips calculation");}		}
			| exp T_MOD exp	 		{ if($3!=0) $$ = $1%$3; else {$$ = $1;	fprintf(stderr,"Error: Cannot Divide by zero, Result skips calculation");}	}
			| exp T_POW exp	 		{ $$ =(int)pow($1, $3);	}
			| T_NOT exp	 			{ $$ = ~$2; 			}
			| T_LEFT exp T_RIGHT	{ $$ = $2; 				}
			| T_MINUS exp  %prec NEG{ $$ = -$2; 			}	 
            | exp exp               { $$ = $1;   fprintf(stderr,"Error: Missing an operator, Taking left operand...\n");  }
;			


%%

int reg[29] = {0};

int id = 0, stackSize = 0;
struct DATA *dataTable[hash_size];
char varName[hash_size][50];
int varCount = 0;
char filename[50];

// main function
int main( int argc, char **argv) {
	FILE *f = fopen(argv[1], "r");
	if (f == NULL)
	{
		printf("Error opening input file!\n");
		exit(1);
	}

	printf("================= FLAT Language compiler ==============\n> ");
	addVar(".FormatStr","%s\\0");
	addVar(".FormatInt","%ld\\0");
	addVar(".FormatHex","%x\\0");
	addVar(".NewLine","\\12\\0");
    addVar(".Smile","Have a good day :)\\12\\0");
    addVar(".Sad","Don't cry :(\\12\\0");
	strcpy(filename,argv[1]);
	yyin = f;
    //showToken();
	// Loop parse ในกรณี input file
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


void showToken () {
	int tok;
 	while(tok = yylex()) {
         printf("[%d]\n", tok);
 	}
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
	sprintf(newOP->cmd,".%s%d",label,newOP->id);
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
    addChild(ifOp,opMaker("JMP",ifOp->cmd,"")); 
	addChild(ifOp,elseOp); 
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

struct OP* printMaker(struct DATA* toPrint) {
	// movl 	$FormatStr, %edi
	// movl 	$ToPrint, %esi
	// movl 	$0, %eax
    // call		printf
	
	if(toPrint==NULL) {
		return NULL;
	}

	struct OP* printOp = opMaker("CALL","printf","");
	

	if(toPrint->isInt == 1) {
		addChild(printOp,opMaker("MOVQ",toPrint->reg,"%rsi"));
		addChild(printOp,opMaker("MOVL","$.FormatInt","%edi")); 	
	}
 	else 
		addChild(printOp,opMaker("MOVL",toPrint->reg,"%edi"));

	addChild(printOp,opMaker("MOVL","$0","%eax"));
	return printOp;
}

struct OP* printIntMaker(int value) {
	struct OP* printOp;

	printOp = opMaker("CALL","printf","");

	addChild(printOp,opMaker("MOVQ",imm(value),"%rsi"));
	addChild(printOp,opMaker("MOVL","$.FormatInt","%edi")); 	

	addChild(printOp,opMaker("MOVL","$0","%eax"));
	return printOp;
}

struct OP* printHexMaker(struct DATA* toPrint) {
	struct OP* printOp = printMaker(toPrint);
	sprintf(printOp->child[1]->a,"%s","$.FormatHex");
	return printOp;
}

struct OP* printIntHexMaker(int value) {
	struct OP* printOp = printIntMaker(value);
	sprintf(printOp->child[1]->a,"%s","$.FormatHex");
	return printOp;
}

struct OP* printVarExpMaker(struct OP* varExp) {
	struct OP* printOp = opMaker("CALL","printf","");
    addChild(printOp,varExp);
    addChild(printOp,opMaker("MOVQ","%rax","%rsi"));
    addChild(printOp,opMaker("MOVL","$.FormatInt","%edi")); 	

	addChild(printOp,opMaker("MOVL","$0","%eax"));
	return printOp;
}

struct DATA *addVar(char *name, char *value)
{
    struct DATA *newData = lookup(name);
    
    if (newData == NULL) { // not exists
        newData = (struct DATA*) malloc(sizeof(struct DATA));
		strcpy(newData->name,name);
		strcpy(newData->value,value);
		sprintf(newData->reg,"$%s",name);
		newData->isInt = 0;
        unsigned hashval = hashfn(name);
        newData->next = dataTable[hashval];
        dataTable[hashval] = newData;
		strcpy(varName[varCount++],name);
		
    } else { // already exists
		fprintf(stderr,"Variable %s is previously declared..\n",name);
		return NULL;
	} 
	//printf("Added '%s'\n",newData->name);
	
    return newData;
}

struct DATA* addInt(char* varName) {
	//movl	$10, -8(%rbp)

	struct DATA *newData = addVar(varName, imm(0));
	if(newData==NULL)
		return NULL;
	newData->isInt = 1;

	char memAddr[10];
	sprintf(memAddr,"-%d(%%rbp)",(++stackSize)*8);
	sprintf(newData->reg,"%s",memAddr);
	
	return newData;
}

struct DATA* addString(char* value) {
	char name[10],value_s[strlen(value)+2];
	sprintf(name,".string%d",id++);
	sprintf(value_s,"%s\\0",value);
	return addVar(name, value_s);
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
    return NULL; // not found
}

struct DATA *checkVar(char *s)
{   
    struct DATA *newData = lookup(s);
    if(newData!=NULL)
        return newData;
    fprintf(stderr,"Variable \"%s\" has not been declared yet.\n",s);
    return NULL; // not found
}



void printProgram(struct OP* parent)  {
	char outputname[55];
	sprintf(outputname,"%s.s",filename);
	FILE *f = fopen(outputname, "w+");
	if (f == NULL)
	{
		printf("Error opening output file!\n");
		exit(1);
	}
	int saved_stdout = dup(1);
	dup2(fileno(f), 1);

	int i;
	for(i = 0;i<varCount;i++) {
		struct DATA* data = lookup(varName[i]);
		if(data != NULL)
			if(data->isInt==0) 
				printf("%s:\n\t%s \"%s\"\n",data->name,".string",data->value);
			
	}
	int inc_size = (stackSize-1)/2*16;
	printf(".globl main\n");
	printf("main:\n");
	printf("	PUSHQ   %%rbp\n\n");
	printf("	MOVQ	%%rsp, %%rbp\n");
	printf("	SUBQ	$%d, %%rsp\n",32+inc_size);
	printf("	MOVL	%%edi, -%d(%%rbp)\n",20+inc_size);
	printf("	MOVQ	%%rsi, -%d(%%rbp)\n",32+inc_size);
	// ....int data.....
	printCode(parent,0);
	// Exit Int.
	printf("MOVL	$0, %%eax\n");
	printf("leave\n");
    printf("ret\n\n\n");

	dup2(saved_stdout, 1);
	close(saved_stdout);

    char cmd1[50],cmd2[50];
    sprintf(cmd1,"gcc %s.s -o %s.o",filename,filename);
    sprintf(cmd2,"./%s.o",filename);
    system(cmd1); system(cmd2);
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
	if(strlen(parent->a)>0) {
        if(strlen(parent->cmd)>0) {// 1-arg op
		    printf("%s	%s\n",parent->cmd,parent->a); return;
        } else {// 0-arg op
            printf("%s\n",parent->a); return;
        }

	}
	if(strlen(parent->cmd)>0) {// Label
		printf("%s:\n",parent->cmd); return;
	}
	else
		printf("\n");
}