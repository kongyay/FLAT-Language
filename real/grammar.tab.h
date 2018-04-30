/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

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

#ifndef YY_YY_GRAMMAR_TAB_H_INCLUDED
# define YY_YY_GRAMMAR_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 31 "grammar.y" /* yacc.c:1909  */

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

#line 63 "grammar.tab.h" /* yacc.c:1909  */

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
    T_OR = 276,
    T_ELSE = 277,
    T_FOR = 278,
    T_BREAK = 279,
    T_PRINT = 280,
    T_END = 281,
    T_SPACE = 282,
    T_NEWLINE = 283,
    T_NAME = 284,
    LOW = 285,
    T_AND = 286,
    T_PLUS = 287,
    T_MINUS = 288,
    T_MULTIPLY = 289,
    T_DIVIDE = 290,
    T_MOD = 291,
    T_NOT = 292,
    T_LEFT = 293,
    T_RIGHT = 294,
    NEG = 295,
    T_POW = 296
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 50 "grammar.y" /* yacc.c:1909  */
              /* define stack type */
  int num;
  char c;
  char* str;
  struct OP* op;
  struct DATA* data;

#line 125 "grammar.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_GRAMMAR_TAB_H_INCLUDED  */
