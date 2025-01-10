/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_TRANSLATOR06_01_TAB_H_INCLUDED
# define YY_YY_TRANSLATOR06_01_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    TOK_PLUS = 258,                /* TOK_PLUS  */
    TOK_MINUS = 259,               /* TOK_MINUS  */
    TOK_MULT = 260,                /* TOK_MULT  */
    TOK_DIV = 261,                 /* TOK_DIV  */
    TOK_LEFTP = 262,               /* TOK_LEFTP  */
    TOK_RIGHTP = 263,              /* TOK_RIGHTP  */
    TOK_LEFTBP = 264,              /* TOK_LEFTBP  */
    TOK_RIGHTBP = 265,             /* TOK_RIGHTBP  */
    TOK_DECLARE_VAR = 266,         /* TOK_DECLARE_VAR  */
    TOK_INT = 267,                 /* TOK_INT  */
    TOK_FLOAT = 268,               /* TOK_FLOAT  */
    TOK_DOUBLE = 269,              /* TOK_DOUBLE  */
    TOK_SEP = 270,                 /* TOK_SEP  */
    TOK_ASSIGN = 271,              /* TOK_ASSIGN  */
    TOK_SCAN = 272,                /* TOK_SCAN  */
    TOK_PRINT = 273,               /* TOK_PRINT  */
    TOK_ERROR = 274,               /* TOK_ERROR  */
    TOK_EQ = 275,                  /* TOK_EQ  */
    TOK_NEQ = 276,                 /* TOK_NEQ  */
    TOK_GT = 277,                  /* TOK_GT  */
    TOK_GTE = 278,                 /* TOK_GTE  */
    TOK_LT = 279,                  /* TOK_LT  */
    TOK_LTE = 280,                 /* TOK_LTE  */
    TOK_IF = 281,                  /* TOK_IF  */
    TOK_ELSE = 282,                /* TOK_ELSE  */
    VAR_INT = 283,                 /* VAR_INT  */
    VAR_FLOAT = 284,               /* VAR_FLOAT  */
    VAR_DOUBLE = 285,              /* VAR_DOUBLE  */
    TOK_IDENTIFIER = 286,          /* TOK_IDENTIFIER  */
    TOK_STRING = 287               /* TOK_STRING  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 247 "translator06.01.y"
 
    char* sir; 
    double doubleVal; 
    int intVal; 
    float floatVal; 

#line 103 "translator06.01.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;

int yyparse (void);


#endif /* !YY_YY_TRANSLATOR06_01_TAB_H_INCLUDED  */
