%option noyywrap
%{
	#include "translator06.01.tab.h"
	#include<iostream>
	#include <stdio.h>
	#include <string.h>


	int lineNo = 1;
	int colNo = 1;
%}

%%
"+"				{ colNo++; return TOK_PLUS; }
"-"				{ colNo++; return TOK_MINUS; }
"*"				{ colNo++; return TOK_MULT; }
"/"				{ colNo++; return TOK_DIV; }
"("				{ colNo++; return TOK_LEFTP; }
")"				{ colNo++; return TOK_RIGHTP; }
"{"             {colNo++; return TOK_LEFTBP;}
"}"             {colNo++; return TOK_RIGHTBP;}
";"				{ colNo++; return TOK_SEP; }
"="				{ colNo++; return TOK_ASSIGN; }
"=="            {colNo+=2; return TOK_EQ;}
"!="            {colNo+=2; return TOK_NEQ;}
"<"             {colNo++; return TOK_LT;}
"<="            {colNo+=2; return TOK_LTE;}
">"             {colNo++; return TOK_GT;}
">="            {colNo+=2; return TOK_GTE;}
0|[1-9][0-9]*	{ 	yylloc.first_line = lineNo; 
					yylloc.first_column = colNo; 
					colNo+=strlen(yytext); 
					yylval.doubleVal = atoi(yytext); 
					return VAR_INT; }
0\.[0-9]*|[1-9][0-9]*\.[0-9]+ {
					yylloc.first_line=lineNo;
					yylloc.first_column=colNo;
					colNo+=strlen(yytext);
					yylval.doubleVal=atof(yytext);
					return VAR_DOUBLE;
				}

0\.[0-9]*f|[1-9][0-9]*\.[0-9]+f {
					yylloc.first_line=lineNo;
					yylloc.first_column=colNo;
					colNo+=strlen(yytext);
    				char buffer[strlen(yytext)];
					strncpy(buffer, yytext, strlen(yytext) - 1);
					buffer[strlen(yytext) - 1] = '\0';
					yylval.doubleVal = atof(buffer);
					return VAR_FLOAT;
				}

"int"			{ colNo+=3; return TOK_INT; }
"double"		{ colNo+=6;	return TOK_DOUBLE; }
"float"			{ colNo+=5;	return TOK_FLOAT; }
"var"			{ colNo+=3; return TOK_DECLARE_VAR; }
"print"			{ colNo+=5; return TOK_PRINT; }
"scan"			{ colNo+=5; return TOK_SCAN; }
"if"            {colNo+=2; return TOK_IF;}
"else"          {colNo+=4; return TOK_ELSE;}
[a-zA-Z][a-zA-Z0-9]* { 	yylloc.first_line = lineNo; 
						yylloc.first_column = colNo; 
						colNo+=strlen(yytext); 
						yylval.sir = new char[strlen(yytext)+1]; 
						strcpy(yylval.sir,yytext); 
						return TOK_IDENTIFIER;}
\"[^"]*\"   	{ yylloc.first_line = lineNo;
				yylloc.first_column = colNo;
				colNo+=strlen(yytext);
				yylval.sir = new char[strlen(yytext)+1];
				strcpy(yylval.sir,yytext);
				return TOK_STRING;}
[ ]				{ colNo++; }
\r\n			{ lineNo++; colNo=1; }
\n				{ lineNo++; colNo=1; }
\/\/.*          { colNo+=strlen(yytext); }
"/*"([^*]|[*]+[^*/])*"*/"  { colNo+=strlen(yytext); }
.				{ colNo++; return TOK_ERROR; }
%%