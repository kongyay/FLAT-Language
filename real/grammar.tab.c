/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "grammar.y" /* yacc.c:339  */

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



#line 125 "grammar.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "grammar.tab.h".  */
#ifndef YY_YY_GRAMMAR_TAB_H_INCLUDED
# define YY_YY_GRAMMAR_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUM = 258,
    NUM_H = 259,
    T_INC = 260,
    T_GE = 261,
    T_LE = 262,
    T_EQ = 263,
    T_G = 264,
    T_L = 265,
    T_NE = 266,
    T_ASSIGN = 267,
    T_VERT = 268,
    T_Bracket_L = 269,
    T_Bracket_R = 270,
    T_COLON = 271,
    T_COMMA = 272,
    T_STRING = 273,
    T_INT = 274,
    T_IF = 275,
    T_ELSE = 276,
    T_FOR = 277,
    T_PRINT = 278,
    T_PRINTH = 279,
    T_PRINTLN = 280,
    T_END = 281,
    T_SPACE = 282,
    T_NEWLINE = 283,
    T_NAME = 284,
    T_SAD = 285,
    T_SMILE = 286,
    LOW = 287,
    T_AND = 288,
    T_OR = 289,
    T_PLUS = 290,
    T_MINUS = 291,
    T_MULTIPLY = 292,
    T_DIVIDE = 293,
    T_MOD = 294,
    T_NOT = 295,
    T_LEFT = 296,
    T_RIGHT = 297,
    NEG = 298,
    T_POW = 299
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 60 "grammar.y" /* yacc.c:355  */
              /* define stack type */
  int num;
  char c;
  char* str;
  struct OP* op;
  struct DATA* data;

#line 218 "grammar.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_GRAMMAR_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 235 "grammar.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  45
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   680

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  46
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  15
/* YYNRULES -- Number of rules.  */
#define YYNRULES  89
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  164

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   299

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      45,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   104,   104,   106,   107,   108,   109,   113,   114,   115,
     116,   117,   124,   125,   126,   127,   128,   129,   130,   131,
     132,   133,   137,   148,   153,   161,   165,   170,   178,   183,
     190,   198,   200,   204,   210,   215,   224,   232,   240,   248,
     259,   261,   266,   267,   268,   269,   270,   271,   275,   281,
     288,   295,   307,   321,   337,   342,   347,   353,   360,   370,
     375,   382,   388,   396,   405,   410,   412,   414,   416,   418,
     420,   422,   424,   426,   428,   430,   431,   432,   438,   439,
     440,   441,   442,   443,   444,   445,   446,   447,   448,   449
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "NUM", "NUM_H", "T_INC", "T_GE", "T_LE",
  "T_EQ", "T_G", "T_L", "T_NE", "T_ASSIGN", "T_VERT", "T_Bracket_L",
  "T_Bracket_R", "T_COLON", "T_COMMA", "T_STRING", "T_INT", "T_IF",
  "T_ELSE", "T_FOR", "T_PRINT", "T_PRINTH", "T_PRINTLN", "T_END",
  "T_SPACE", "T_NEWLINE", "T_NAME", "T_SAD", "T_SMILE", "LOW", "T_AND",
  "T_OR", "T_PLUS", "T_MINUS", "T_MULTIPLY", "T_DIVIDE", "T_MOD", "T_NOT",
  "T_LEFT", "T_RIGHT", "NEG", "T_POW", "'\\n'", "$accept", "program",
  "statements", "statement", "print_stm", "assign_stm", "assign_part",
  "if_stm", "for_stm", "block", "string", "compare", "cmp_tks", "var_exp",
  "exp", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,    10
};
# endif

#define YYPACT_NINF -66

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-66)))

#define YYTABLE_NINF -89

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     602,   602,   -25,   105,   -14,   430,   439,   -66,     1,   -66,
     -66,    21,   629,   -66,   -66,   -66,   -66,   -66,   -66,   649,
       1,   -66,   -66,   603,   -66,   420,   567,   447,    18,   391,
     199,    33,   -19,   381,   -66,   400,   228,     0,   -66,   567,
     567,   -66,   257,   449,   -66,   -66,   602,   -66,   -66,   -66,
     -66,   -66,   -66,   -66,   -66,   -66,   447,   447,   447,   447,
     447,   447,   -66,     5,    98,    -7,   370,   212,   602,   478,
     488,   491,   494,   497,   507,     7,   447,   536,   447,   447,
     447,   567,   447,   159,   241,   -14,   538,   546,   548,   185,
     565,   567,   567,   567,   567,   270,   381,   400,   241,   -66,
     554,   241,   554,   126,   126,   374,   400,   567,   -66,   -66,
     -20,    -7,   554,   284,    -7,   554,   300,    -7,   126,   313,
      -7,   126,   313,    -7,   374,   347,    -7,   400,   241,   -66,
     554,   284,   -66,   554,   300,   126,   313,   126,   313,   374,
     347,     5,   400,   241,   -66,    42,    -7,   241,    -7,   -66,
     270,   -66,   323,   331,   342,   342,   352,    22,   -66,    45,
     602,   -66,    36,   -66
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       3,     3,     0,     0,     0,     0,     0,    19,     0,    21,
      20,     0,     0,     4,     7,     8,     9,    10,    11,     0,
      23,    78,    79,     0,    48,     0,     0,     0,     0,     0,
       0,     0,    32,    13,    15,    14,    12,    32,    17,     0,
       0,    18,    16,     0,    24,     1,     0,     5,    31,    22,
      44,    45,    42,    46,    47,    43,     0,     0,     0,     0,
       0,     0,    64,    88,    86,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    89,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    89,    26,    27,    25,     6,
      65,     0,    67,    69,    71,    73,    40,     0,    75,    87,
       0,    66,    49,    54,    68,    50,    55,    70,    51,    56,
      72,    52,    57,    74,    53,    58,    41,    39,    37,    76,
      59,    80,    48,    60,    81,    61,    82,    62,    83,    63,
      84,    85,    38,    36,    77,     0,    35,    34,    33,    35,
      34,    33,    80,    81,    82,    83,    84,     0,    28,     0,
       0,    30,     0,    29
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -66,   -66,    79,    -5,   -66,     8,    62,   -65,   -66,   -66,
      90,   -66,    -4,   100,    -3
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,    11,    12,    13,    14,    15,    44,    16,    17,    18,
      34,    28,    61,    83,    75
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      30,   157,    36,    42,    20,     2,   158,    47,    21,    22,
      21,    22,    31,    43,    47,     8,    86,    57,    58,    59,
      60,    45,    63,    64,    67,    74,    82,    84,    56,    57,
      58,    59,    60,    84,    68,    88,    63,    89,   160,    95,
      98,    99,   107,    91,    92,    93,    94,    26,    40,    81,
      85,    81,   129,   101,   101,   101,   101,   101,   101,   159,
      95,    95,   163,   110,    84,     3,   113,   116,   119,   122,
     125,   128,    95,   131,   134,   136,   138,   140,   141,   143,
      19,    84,    49,   147,   131,   150,    95,   152,   153,   154,
     155,   156,    95,   145,   161,    84,    41,     0,    84,     0,
       0,    21,    22,    29,   152,    35,     0,     0,    21,    22,
      84,     0,     0,    84,     0,     0,    84,     0,     0,    84,
       0,     0,    84,    23,     0,    84,     0,    66,    84,    21,
      22,    84,     0,    84,    24,    84,     0,    84,    95,    40,
      84,    25,    81,    97,    84,    26,    27,    95,     0,    95,
      95,    95,    95,    95,     0,   162,   100,   102,   103,   104,
     105,   106,    21,    22,     0,    73,    26,    40,     0,   112,
     115,   118,   121,   124,   127,     0,   130,   133,   135,   137,
     139,     0,   142,     0,     0,     0,   100,   130,    21,    22,
       0,     0,     0,     0,    69,    70,    71,    72,    73,    26,
      40,     0,    21,    22,   144,    50,    51,    52,    53,    54,
      55,     0,     0,     0,     0,    21,    22,    65,     0,     0,
     107,    91,    92,    93,    94,    26,    40,   109,    24,    81,
      65,    21,    22,     0,    76,    77,    78,    79,    80,    26,
      27,    24,     0,    81,    21,    22,    65,    76,    77,    78,
      79,    80,    26,    27,   109,     0,    81,    24,     0,    65,
      21,    22,     0,    87,    77,    78,    79,    80,    26,    27,
      24,     0,    81,    21,    22,     0,    76,    77,    78,    79,
      80,    26,    27,     0,     0,    81,     0,    21,    22,     0,
       0,     0,    90,    91,    92,    93,    94,    26,    40,     0,
       0,    81,    65,    21,    22,   107,    91,    92,    93,    94,
      26,    40,     0,    24,    81,     0,    21,    22,    65,     0,
       0,    78,    79,    80,    26,    27,    21,    22,    81,    24,
       0,    65,     0,     0,    21,    22,     0,   -88,   -88,   -88,
     -88,   -88,    24,     0,    81,    21,    22,     0,     0,     0,
      21,    22,    80,    26,    27,    21,    22,    81,     0,     0,
      92,    93,    94,    26,    40,    65,     0,    81,   -88,   -88,
     -88,   -88,   -88,    21,    22,    81,    24,    21,    22,     0,
       0,    94,    26,    40,   -48,   -48,    81,    26,    27,     0,
       0,    81,    26,    40,    21,    22,    81,    50,    51,    52,
      53,    54,    55,    21,    22,    69,    70,    71,    72,    73,
      26,    40,   108,     0,    26,    40,   -48,   -48,   -48,   -48,
     -48,   -48,   -48,    21,    22,     0,    69,    70,    71,    72,
      73,    26,    40,    21,    22,    69,    70,    71,    72,    73,
      26,    40,    21,    22,     0,     0,     0,     0,    32,    62,
      21,    22,    21,    22,     0,     0,    39,    37,     0,    33,
      26,    40,     0,     0,     0,    65,    25,    65,    38,     0,
      26,    27,     0,     0,     0,    39,    24,     0,    96,    26,
      40,    21,    22,    25,     0,    25,     0,    26,    27,    26,
      27,    21,    22,     0,    21,    22,   111,    21,    22,     0,
      21,    22,     0,     0,     0,     0,   114,    24,     0,   117,
      21,    22,   120,     0,    25,   123,     0,    24,    26,    27,
      24,     0,     0,    24,    25,   126,    24,    25,    26,    27,
      25,    26,    27,    25,    26,    27,    24,    26,    27,    21,
      22,    21,    22,    25,     0,     0,     0,    26,    27,    21,
      22,    21,    22,     0,    65,     0,   146,    21,    22,     0,
       0,     0,     0,     0,   148,   132,   149,    24,    21,    22,
      21,    22,    25,     0,    25,    24,    26,    27,    26,    27,
       0,     0,    25,   151,    39,     0,    26,    27,    26,    40,
       0,    71,    72,    73,    26,    40,     0,     0,     0,     0,
       0,    39,     0,    39,     0,    26,    40,    26,    40,    50,
      51,    52,    53,    54,    55,     0,     1,     0,     0,     0,
       0,     2,     3,     0,     4,     5,     6,     7,     0,    -2,
      46,     8,     9,    10,     0,     0,     0,     0,    56,    57,
      58,    59,    60,     1,     0,     0,     0,     0,     2,     3,
      46,     4,     5,     6,     7,     0,     0,     0,     8,     9,
      10,     0,     0,     1,    48,     0,     0,     0,     2,     3,
       0,     4,     5,     6,     7,     0,     0,     0,     8,     9,
      10
};

static const yytype_int16 yycheck[] =
{
       3,    21,     5,     6,    29,    19,    26,    12,     3,     4,
       3,     4,     4,    12,    19,    29,    35,    36,    37,    38,
      39,     0,    25,    26,    27,    29,    30,    30,    35,    36,
      37,    38,    39,    36,    16,    35,    39,    40,    16,    42,
      43,    46,    35,    36,    37,    38,    39,    40,    41,    44,
      17,    44,    45,    56,    57,    58,    59,    60,    61,    17,
      63,    64,    26,    68,    67,    20,    69,    70,    71,    72,
      73,    74,    75,    76,    77,    78,    79,    80,    81,    82,
       1,    84,    20,    86,    87,    88,    89,    90,    91,    92,
      93,    94,    95,    85,   159,    98,     6,    -1,   101,    -1,
      -1,     3,     4,     3,   107,     5,    -1,    -1,     3,     4,
     113,    -1,    -1,   116,    -1,    -1,   119,    -1,    -1,   122,
      -1,    -1,   125,    18,    -1,   128,    -1,    27,   131,     3,
       4,   134,    -1,   136,    29,   138,    -1,   140,   141,    41,
     143,    36,    44,    43,   147,    40,    41,   150,    -1,   152,
     153,   154,   155,   156,    -1,   160,    56,    57,    58,    59,
      60,    61,     3,     4,    -1,    39,    40,    41,    -1,    69,
      70,    71,    72,    73,    74,    -1,    76,    77,    78,    79,
      80,    -1,    82,    -1,    -1,    -1,    86,    87,     3,     4,
      -1,    -1,    -1,    -1,    35,    36,    37,    38,    39,    40,
      41,    -1,     3,     4,    45,     6,     7,     8,     9,    10,
      11,    -1,    -1,    -1,    -1,     3,     4,    18,    -1,    -1,
      35,    36,    37,    38,    39,    40,    41,    42,    29,    44,
      18,     3,     4,    -1,    35,    36,    37,    38,    39,    40,
      41,    29,    -1,    44,     3,     4,    18,    35,    36,    37,
      38,    39,    40,    41,    42,    -1,    44,    29,    -1,    18,
       3,     4,    -1,    35,    36,    37,    38,    39,    40,    41,
      29,    -1,    44,     3,     4,    -1,    35,    36,    37,    38,
      39,    40,    41,    -1,    -1,    44,    -1,     3,     4,    -1,
      -1,    -1,    35,    36,    37,    38,    39,    40,    41,    -1,
      -1,    44,    18,     3,     4,    35,    36,    37,    38,    39,
      40,    41,    -1,    29,    44,    -1,     3,     4,    18,    -1,
      -1,    37,    38,    39,    40,    41,     3,     4,    44,    29,
      -1,    18,    -1,    -1,     3,     4,    -1,    37,    38,    39,
      40,    41,    29,    -1,    44,     3,     4,    -1,    -1,    -1,
       3,     4,    39,    40,    41,     3,     4,    44,    -1,    -1,
      37,    38,    39,    40,    41,    18,    -1,    44,    37,    38,
      39,    40,    41,     3,     4,    44,    29,     3,     4,    -1,
      -1,    39,    40,    41,     3,     4,    44,    40,    41,    -1,
      -1,    44,    40,    41,     3,     4,    44,     6,     7,     8,
       9,    10,    11,     3,     4,    35,    36,    37,    38,    39,
      40,    41,    42,    -1,    40,    41,    35,    36,    37,    38,
      39,    40,    41,     3,     4,    -1,    35,    36,    37,    38,
      39,    40,    41,     3,     4,    35,    36,    37,    38,    39,
      40,    41,     3,     4,    -1,    -1,    -1,    -1,    18,    29,
       3,     4,     3,     4,    -1,    -1,    36,    18,    -1,    29,
      40,    41,    -1,    -1,    -1,    18,    36,    18,    29,    -1,
      40,    41,    -1,    -1,    -1,    36,    29,    -1,    29,    40,
      41,     3,     4,    36,    -1,    36,    -1,    40,    41,    40,
      41,     3,     4,    -1,     3,     4,    18,     3,     4,    -1,
       3,     4,    -1,    -1,    -1,    -1,    18,    29,    -1,    18,
       3,     4,    18,    -1,    36,    18,    -1,    29,    40,    41,
      29,    -1,    -1,    29,    36,    18,    29,    36,    40,    41,
      36,    40,    41,    36,    40,    41,    29,    40,    41,     3,
       4,     3,     4,    36,    -1,    -1,    -1,    40,    41,     3,
       4,     3,     4,    -1,    18,    -1,    18,     3,     4,    -1,
      -1,    -1,    -1,    -1,    18,    29,    18,    29,     3,     4,
       3,     4,    36,    -1,    36,    29,    40,    41,    40,    41,
      -1,    -1,    36,    18,    36,    -1,    40,    41,    40,    41,
      -1,    37,    38,    39,    40,    41,    -1,    -1,    -1,    -1,
      -1,    36,    -1,    36,    -1,    40,    41,    40,    41,     6,
       7,     8,     9,    10,    11,    -1,    14,    -1,    -1,    -1,
      -1,    19,    20,    -1,    22,    23,    24,    25,    -1,     0,
       1,    29,    30,    31,    -1,    -1,    -1,    -1,    35,    36,
      37,    38,    39,    14,    -1,    -1,    -1,    -1,    19,    20,
       1,    22,    23,    24,    25,    -1,    -1,    -1,    29,    30,
      31,    -1,    -1,    14,    15,    -1,    -1,    -1,    19,    20,
      -1,    22,    23,    24,    25,    -1,    -1,    -1,    29,    30,
      31
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    14,    19,    20,    22,    23,    24,    25,    29,    30,
      31,    47,    48,    49,    50,    51,    53,    54,    55,    48,
      29,     3,     4,    18,    29,    36,    40,    41,    57,    59,
      60,    51,    18,    29,    56,    59,    60,    18,    29,    36,
      41,    56,    60,    12,    52,     0,     1,    49,    15,    52,
       6,     7,     8,     9,    10,    11,    35,    36,    37,    38,
      39,    58,    29,    60,    60,    18,    59,    60,    16,    35,
      36,    37,    38,    39,    58,    60,    35,    36,    37,    38,
      39,    44,    58,    59,    60,    17,    35,    35,    35,    60,
      35,    36,    37,    38,    39,    60,    29,    59,    60,    49,
      59,    60,    59,    59,    59,    59,    59,    35,    42,    42,
      49,    18,    59,    60,    18,    59,    60,    18,    59,    60,
      18,    59,    60,    18,    59,    60,    18,    59,    60,    45,
      59,    60,    29,    59,    60,    59,    60,    59,    60,    59,
      60,    60,    59,    60,    45,    51,    18,    60,    18,    18,
      60,    18,    60,    60,    60,    60,    60,    21,    26,    17,
      16,    53,    49,    26
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    46,    47,    48,    48,    48,    48,    49,    49,    49,
      49,    49,    50,    50,    50,    50,    50,    50,    50,    50,
      50,    50,    51,    51,    51,    52,    52,    52,    53,    53,
      54,    55,    56,    56,    56,    56,    57,    57,    57,    57,
      57,    57,    58,    58,    58,    58,    58,    58,    59,    59,
      59,    59,    59,    59,    59,    59,    59,    59,    59,    59,
      59,    59,    59,    59,    59,    59,    59,    59,    59,    59,
      59,    59,    59,    59,    59,    59,    59,    59,    60,    60,
      60,    60,    60,    60,    60,    60,    60,    60,    60,    60
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     0,     1,     2,     3,     1,     1,     1,
       1,     1,     2,     2,     2,     2,     2,     2,     2,     1,
       1,     1,     3,     2,     2,     2,     2,     2,     5,     8,
       6,     3,     1,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     1,     1,     1,     1,     1,     1,     1,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     2,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     1,     1,
       3,     3,     3,     3,     3,     3,     2,     3,     2,     2
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 104 "grammar.y" /* yacc.c:1646  */
    { printf("Compiled... :)\n\n\n"); printProgram((yyvsp[0].op)); }
#line 1526 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 106 "grammar.y" /* yacc.c:1646  */
    { }
#line 1532 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 107 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = (struct OP*)malloc(sizeof(struct OP)); addChild((yyval.op),(yyvsp[0].op)); }
#line 1538 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 108 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = (yyvsp[-1].op); addChild((yyval.op),(yyvsp[0].op)); }
#line 1544 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 109 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = (yyvsp[-2].op); addChild((yyval.op),(yyvsp[0].op)); yyerrok; fprintf(stderr,"Error: Bad Statement\n"); }
#line 1550 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 113 "grammar.y" /* yacc.c:1646  */
    { /*printf("Stm - print\n");*/ 		        (yyval.op) = (yyvsp[0].op); }
#line 1556 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 114 "grammar.y" /* yacc.c:1646  */
    { /*printf("Stm - declare/assign\n");*/ 	(yyval.op) = (yyvsp[0].op);}
#line 1562 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 115 "grammar.y" /* yacc.c:1646  */
    { /*printf("Stm - if\n");*/ 		        (yyval.op) = (yyvsp[0].op);}
#line 1568 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 116 "grammar.y" /* yacc.c:1646  */
    { /*printf("Stm - for\n");*/ 		        (yyval.op) = (yyvsp[0].op);}
#line 1574 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 117 "grammar.y" /* yacc.c:1646  */
    { /*printf("Stm - Block\n");*/		        (yyval.op) = (yyvsp[0].op);}
#line 1580 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 124 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = printIntMaker((yyvsp[0].num)); }
#line 1586 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 125 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = printMaker(checkVar((yyvsp[0].str))); }
#line 1592 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 126 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = printVarExpMaker((yyvsp[0].op)); }
#line 1598 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 127 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = printMaker((yyvsp[0].data)); }
#line 1604 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 128 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = printIntHexMaker((yyvsp[0].num)); }
#line 1610 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 129 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = printHexMaker(checkVar((yyvsp[0].str))); }
#line 1616 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 130 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = NULL; fprintf(stderr,"Error: Can't print string as hex"); }
#line 1622 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 131 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = printMaker(checkVar(".NewLine")); }
#line 1628 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 132 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = printMaker(checkVar(".Smile")); }
#line 1634 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 133 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = printMaker(checkVar(".Sad")); }
#line 1640 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 138 "grammar.y" /* yacc.c:1646  */
    { 
                        //printf("declare+assign\n"); 
                        if(strcmp((yyvsp[0].op)->b,(yyvsp[-1].str))==0) {
                            (yyval.op) = NULL;
                        } else {
                            sprintf((yyvsp[0].op)->b,"%s",addInt((yyvsp[-1].str))->reg); 
                            (yyval.op) = (yyvsp[0].op); 
                        }
                        
                    }
#line 1655 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 149 "grammar.y" /* yacc.c:1646  */
    { 
                        //printf("declare\n"); 
                        (yyval.op) = opMaker("MOVQ","$0",addInt((yyvsp[0].str))->reg); 
                    }
#line 1664 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 154 "grammar.y" /* yacc.c:1646  */
    { 
                        //printf("assign\n"); 
                        sprintf((yyvsp[0].op)->b,"%s",checkVar((yyvsp[-1].str))->reg); 
                        (yyval.op) = (yyvsp[0].op); 
                    }
#line 1674 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 162 "grammar.y" /* yacc.c:1646  */
    {   
                    (yyval.op) = opMaker("MOVQ",imm((yyvsp[0].num)),""); 
                }
#line 1682 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 166 "grammar.y" /* yacc.c:1646  */
    {    
                    (yyval.op) = opMaker("MOVQ","%rax",""); 
                    addChild((yyval.op),opMaker("MOVQ",checkVar((yyvsp[0].str))->reg,"%rax"));
                }
#line 1691 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 171 "grammar.y" /* yacc.c:1646  */
    { 
                    
                    (yyval.op) = opMaker("MOVQ","%rax",""); 
                    addChild((yyval.op),(yyvsp[0].op)); 
                }
#line 1701 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 179 "grammar.y" /* yacc.c:1646  */
    { 
                    //printf("if\n"); 
                    (yyval.op) = ifMaker((yyvsp[-3].op),(yyvsp[-1].op));
                }
#line 1710 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 184 "grammar.y" /* yacc.c:1646  */
    { 
                    //printf("ifElse\n"); 
                    (yyval.op) = ifElseMaker((yyvsp[-6].op),(yyvsp[-4].op),(yyvsp[-1].op)); 
                }
#line 1719 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 191 "grammar.y" /* yacc.c:1646  */
    { 
                    //printf("for\n"); 
                    (yyval.op) = forMaker((yyvsp[-4].op),(yyvsp[-2].op),(yyvsp[0].op));  
                }
#line 1728 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 198 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = (yyvsp[-1].op); }
#line 1734 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 201 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.data) = addString((yyvsp[0].str));   
                }
#line 1742 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 205 "grammar.y" /* yacc.c:1646  */
    { 
                    char x[strlen((yyvsp[0].str))+10]; 
                    sprintf(x,"%d%s",(yyvsp[-2].num),(yyvsp[0].str)); 
                    (yyval.data) = addString(x); 
                }
#line 1752 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 211 "grammar.y" /* yacc.c:1646  */
    { 
                    char x[strlen((yyvsp[-2].str))+10]; 
                    sprintf(x,"%s%d",(yyvsp[-2].str),(yyvsp[0].num)); (yyval.data) = addString(x); 	
                }
#line 1761 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 216 "grammar.y" /* yacc.c:1646  */
    { 
                    char x[strlen((yyvsp[0].str))+strlen((yyvsp[-2].str))+1]; 
                    sprintf(x,"%s%s",(yyvsp[-2].str),(yyvsp[0].str)); (yyval.data) = addString(x); 	
                }
#line 1770 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 225 "grammar.y" /* yacc.c:1646  */
    { 
                    //printf("cmp %d %d\n",$1,$3);
                    (yyval.op) = opMaker("CMPQ",imm((yyvsp[0].num)),imm((yyvsp[-2].num)));   
                    sprintf((yyval.op)->extra1,"J%c%c",(yyvsp[-1].str)[0],(yyvsp[-1].str)[1]); 
                    sprintf((yyval.op)->extra2,"J%c%c",(yyvsp[-1].str)[2],(yyvsp[-1].str)[3]);  
                }
#line 1781 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 233 "grammar.y" /* yacc.c:1646  */
    { 
                    //printf("cmp %d\n",$3);
                    (yyval.op) = opMaker("CMPQ",imm((yyvsp[0].num)),"%rax"); 	 	
                    addChild((yyval.op),(yyvsp[-2].op));
                    sprintf((yyval.op)->extra1,"J%c%c",(yyvsp[-1].str)[0],(yyvsp[-1].str)[1]); 
                    sprintf((yyval.op)->extra2,"J%c%c",(yyvsp[-1].str)[2],(yyvsp[-1].str)[3]); 
                }
#line 1793 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 241 "grammar.y" /* yacc.c:1646  */
    { 
                    //printf("cmp %d\n",$1);
                    (yyval.op) = opMaker("CMPQ","%rax",imm((yyvsp[-2].num))); 
                    addChild((yyval.op),(yyvsp[0].op));	
                    sprintf((yyval.op)->extra1,"J%c%c",(yyvsp[-1].str)[0],(yyvsp[-1].str)[1]); 
                    sprintf((yyval.op)->extra2,"J%c%c",(yyvsp[-1].str)[2],(yyvsp[-1].str)[3]);  
                }
#line 1805 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 249 "grammar.y" /* yacc.c:1646  */
    { 
                    //printf("cmp\n");
                    (yyval.op) = opMaker("CMPQ","%rbx","%rax");   
                    addChild((yyval.op),(yyvsp[0].op));
                    addChild((yyval.op),opMaker("MOVQ","%rax","%rbx"));
                    addChild((yyval.op),(yyvsp[-2].op));
                    
                    sprintf((yyval.op)->extra1,"J%c%c",(yyvsp[-1].str)[0],(yyvsp[-1].str)[1]); 
                    sprintf((yyval.op)->extra2,"J%c%c",(yyvsp[-1].str)[2],(yyvsp[-1].str)[3]);  
                }
#line 1820 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 260 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't compare string\n"); }
#line 1826 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 262 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't compare string\n"); }
#line 1832 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 266 "grammar.y" /* yacc.c:1646  */
    { (yyval.str) = "EQNE"; }
#line 1838 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 267 "grammar.y" /* yacc.c:1646  */
    { (yyval.str) = "NEEQ"; }
#line 1844 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 268 "grammar.y" /* yacc.c:1646  */
    { (yyval.str) = "GEL "; }
#line 1850 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 269 "grammar.y" /* yacc.c:1646  */
    { (yyval.str) = "LEG "; }
#line 1856 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 270 "grammar.y" /* yacc.c:1646  */
    { (yyval.str) = "G LE"; }
#line 1862 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 271 "grammar.y" /* yacc.c:1646  */
    { (yyval.str) = "L GE"; }
#line 1868 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 276 "grammar.y" /* yacc.c:1646  */
    { 
                    char comment[50];
                    sprintf(comment,"%%rax\t# %s",(yyvsp[0].str));
                    (yyval.op) = opMaker("MOVQ ",checkVar((yyvsp[0].str))->reg,comment); 
                }
#line 1878 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 282 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("ADDQ","%rbx","%rax"); 
                    addChild((yyval.op),(yyvsp[0].op)); 
                    addChild((yyval.op),opMaker("MOVQ","%rax","%rbx")); 
                    addChild((yyval.op),(yyvsp[-2].op)); 
                }
#line 1889 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 289 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("SUBQ","%rbx","%rax"); 
                    addChild((yyval.op),(yyvsp[0].op)); 
                    addChild((yyval.op),opMaker("MOVQ","%rax","%rbx")); 
                    addChild((yyval.op),(yyvsp[-2].op)); 
                }
#line 1900 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 296 "grammar.y" /* yacc.c:1646  */
    { 
                    // movq	-24(%rbp), %rax
                    // cqto
                    // idivq	-16(%rbp)
                    // movq	%rax, -24(%rbp)
                    (yyval.op) = opMaker("IMULQ","%rbx","");
                    addChild((yyval.op),(yyvsp[0].op));
                    addChild((yyval.op),opMaker("MOVQ","%rax","%rbx")); 
                    
                    addChild((yyval.op),(yyvsp[-2].op));
                }
#line 1916 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 308 "grammar.y" /* yacc.c:1646  */
    { 
                    // movq	-24(%rbp), %rax
                    // cqto
                    // idivq	-16(%rbp)
                    // movq	%rax, -24(%rbp)
                    (yyval.op) = opMaker("IDIVQ","%rbx","");
                    addChild((yyval.op),(yyvsp[0].op));
                    addChild((yyval.op),opMaker("MOVQ","%rax","%rbx")); 
                    
                    addChild((yyval.op),(yyvsp[-2].op));
                    
                    addChild((yyval.op),opMaker("","CQTO",""));		
                }
#line 1934 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 322 "grammar.y" /* yacc.c:1646  */
    { 
                    // movq	-24(%rbp), %rax
                    // cqto
                    // idivq	-16(%rbp)
                    // movq	%rax, -24(%rbp)
                    (yyval.op) = opMaker("MOVQ","%rdx","%rax");
                    addChild((yyval.op),(yyvsp[0].op));
                    addChild((yyval.op),opMaker("MOVQ","%rax","%rbx")); 
                    
                    addChild((yyval.op),(yyvsp[-2].op));
                    
                    addChild((yyval.op),opMaker("","CQTO",""));		
                    addChild((yyval.op),opMaker("IDIVQ","%rbx","")); 
                }
#line 1953 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 338 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("ADDQ",imm((yyvsp[0].num)),"%rax");
                    addChild((yyval.op),(yyvsp[-2].op));		
                }
#line 1962 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 343 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("SUBQ",imm((yyvsp[0].num)),"%rax");
                    addChild((yyval.op),(yyvsp[-2].op));		
                }
#line 1971 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 348 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("IMULQ","%rbx","");
                    addChild((yyval.op),(yyvsp[-2].op));
                    addChild((yyval.op),opMaker("MOVQ",imm((yyvsp[0].num)),"%rbx"));	
                }
#line 1981 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 354 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("IDIVQ","%rbx","");
                    addChild((yyval.op),(yyvsp[-2].op));
                    addChild((yyval.op),opMaker("MOVQ",imm((yyvsp[0].num)),"%rbx"));
                    addChild((yyval.op),opMaker("","CQTO",""));		
                }
#line 1992 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 361 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("MOVQ","%rax","%rax");
                    addChild((yyval.op),(yyvsp[-2].op));
                    addChild((yyval.op),opMaker("MOVQ",imm((yyvsp[0].num)),"%rbx"));
                    addChild((yyval.op),opMaker("IDIVQ","%rbx",""));	
                    addChild((yyval.op),opMaker("","CQTO",""));	
                }
#line 2004 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 371 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("ADDQ",imm((yyvsp[-2].num)),"%rax");
                    addChild((yyval.op),(yyvsp[0].op));		
                }
#line 2013 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 376 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("SUBQ","%rbx","%rax");
                    addChild((yyval.op),(yyvsp[0].op));		
                    addChild((yyval.op),opMaker("MOVQ","%rax","%rbx"));	
                    addChild((yyval.op),opMaker("MOVQ",imm((yyvsp[-2].num)),"%rax"));
                }
#line 2024 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 383 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("IMULQ","%rbx","");
                    addChild((yyval.op),(yyvsp[0].op));
                    addChild((yyval.op),opMaker("MOVQ",imm((yyvsp[-2].num)),"%rbx"));	
                }
#line 2034 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 389 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("IDIVQ","%rbx","");
                    addChild((yyval.op),(yyvsp[0].op));
                    addChild((yyval.op),opMaker("MOVQ","%rax","%rbx"));
                    addChild((yyval.op),opMaker("MOVQ",imm((yyvsp[-2].num)),"%rbx"));
                    addChild((yyval.op),opMaker("","CQTO",""));		
                }
#line 2046 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 397 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) = opMaker("MOVQ","%rdx","%rax");
                    addChild((yyval.op),(yyvsp[0].op));
                    addChild((yyval.op),opMaker("MOVQ","%rax","%rbx"));
                    addChild((yyval.op),opMaker("MOVQ",imm((yyvsp[-2].num)),"%rbx"));
                    addChild((yyval.op),opMaker("","CQTO",""));	
                    addChild((yyval.op),opMaker("IDIVQ","%rbx",""));	
                }
#line 2059 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 406 "grammar.y" /* yacc.c:1646  */
    { 
                    (yyval.op) =  opMaker("NEG","%rax",""); 		
                    addChild((yyval.op),opMaker("MOVQ",checkVar((yyvsp[0].str))->reg,"%rax"));	
                }
#line 2068 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 411 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[0].op); }
#line 2074 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 66:
#line 413 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[-2].op); }
#line 2080 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 67:
#line 415 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[0].op); }
#line 2086 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 68:
#line 417 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[-2].op); }
#line 2092 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 69:
#line 419 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[0].op); }
#line 2098 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 70:
#line 421 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[-2].op); }
#line 2104 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 71:
#line 423 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[0].op); }
#line 2110 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 72:
#line 425 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[-2].op); }
#line 2116 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 73:
#line 427 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[0].op); }
#line 2122 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 74:
#line 429 "grammar.y" /* yacc.c:1646  */
    { fprintf(stderr,"Error: Can't do math operation with string\n"); (yyval.op) = (yyvsp[-2].op); }
#line 2128 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 75:
#line 430 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = (yyvsp[-1].op); 	   }
#line 2134 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 76:
#line 431 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = (yyvsp[-2].op);   fprintf(stderr,"Error: Missing an operator, Taking only variable operand...\n");  }
#line 2140 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 77:
#line 432 "grammar.y" /* yacc.c:1646  */
    { (yyval.op) = (yyvsp[-1].op);  fprintf(stderr,"Error: Missing an operator, Taking only variable operand...\n");  }
#line 2146 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 78:
#line 438 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) = (yyvsp[0].num); 				}
#line 2152 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 79:
#line 439 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) = (yyvsp[0].num); 				}
#line 2158 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 80:
#line 440 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) = (yyvsp[-2].num) + (yyvsp[0].num); 		}
#line 2164 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 81:
#line 441 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) = (yyvsp[-2].num) - (yyvsp[0].num); 		}
#line 2170 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 82:
#line 442 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) = (yyvsp[-2].num) * (yyvsp[0].num); 		}
#line 2176 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 83:
#line 443 "grammar.y" /* yacc.c:1646  */
    { if((yyvsp[0].num)!=0) (yyval.num) = (yyvsp[-2].num)/(yyvsp[0].num); else {(yyval.num) = (yyvsp[-2].num); 	fprintf(stderr,"Error: Cannot Divide by zero, Result skips calculation");}		}
#line 2182 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 84:
#line 444 "grammar.y" /* yacc.c:1646  */
    { if((yyvsp[0].num)!=0) (yyval.num) = (yyvsp[-2].num)%(yyvsp[0].num); else {(yyval.num) = (yyvsp[-2].num);	fprintf(stderr,"Error: Cannot Divide by zero, Result skips calculation");}	}
#line 2188 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 85:
#line 445 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) =(int)pow((yyvsp[-2].num), (yyvsp[0].num));	}
#line 2194 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 86:
#line 446 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) = ~(yyvsp[0].num); 			}
#line 2200 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 87:
#line 447 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) = (yyvsp[-1].num); 				}
#line 2206 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 88:
#line 448 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) = -(yyvsp[0].num); 			}
#line 2212 "grammar.tab.c" /* yacc.c:1646  */
    break;

  case 89:
#line 449 "grammar.y" /* yacc.c:1646  */
    { (yyval.num) = (yyvsp[-1].num);   fprintf(stderr,"Error: Missing an operator, Taking left operand...\n");  }
#line 2218 "grammar.tab.c" /* yacc.c:1646  */
    break;


#line 2222 "grammar.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 453 "grammar.y" /* yacc.c:1906  */


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
