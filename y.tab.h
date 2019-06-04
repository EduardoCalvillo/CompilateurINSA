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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tEMOJI = 258,
    tMAIN = 259,
    tCONST = 260,
    tBOOL = 261,
    tINT = 262,
    tCHARET = 263,
    tCHAR = 264,
    tCARACT = 265,
    tFLOAT = 266,
    tRET = 267,
    tVOID = 268,
    tWHILE = 269,
    tIF = 270,
    tELSE = 271,
    tPRINT = 272,
    tPARO = 273,
    tPARF = 274,
    tACCO = 275,
    tACCF = 276,
    tEXCLAM = 277,
    tPLUS = 278,
    tMOINS = 279,
    tMUL = 280,
    tDIV = 281,
    tEQV = 282,
    tPV = 283,
    tV = 284,
    tG = 285,
    tNUM = 286,
    tSTRING = 287,
    tDECIMAL = 288,
    tID = 289,
    tERROR = 290,
    tSUP_EGAL = 291,
    tINF_EGAL = 292,
    tSUP = 293,
    tINF = 294,
    tEGAL = 295,
    tAND = 296,
    tOR = 297,
    tTRUE = 298,
    tFALSE = 299,
    tDIFF = 300,
    tIFEND = 301
  };
#endif
/* Tokens.  */
#define tEMOJI 258
#define tMAIN 259
#define tCONST 260
#define tBOOL 261
#define tINT 262
#define tCHARET 263
#define tCHAR 264
#define tCARACT 265
#define tFLOAT 266
#define tRET 267
#define tVOID 268
#define tWHILE 269
#define tIF 270
#define tELSE 271
#define tPRINT 272
#define tPARO 273
#define tPARF 274
#define tACCO 275
#define tACCF 276
#define tEXCLAM 277
#define tPLUS 278
#define tMOINS 279
#define tMUL 280
#define tDIV 281
#define tEQV 282
#define tPV 283
#define tV 284
#define tG 285
#define tNUM 286
#define tSTRING 287
#define tDECIMAL 288
#define tID 289
#define tERROR 290
#define tSUP_EGAL 291
#define tINF_EGAL 292
#define tSUP 293
#define tINF 294
#define tEGAL 295
#define tAND 296
#define tOR 297
#define tTRUE 298
#define tFALSE 299
#define tDIFF 300
#define tIFEND 301

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 16 "compiler.y" /* yacc.c:1909  */

    int entier;
    char* id;
    float fl;
    char* string;  
    char caractere; 
      

#line 155 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
