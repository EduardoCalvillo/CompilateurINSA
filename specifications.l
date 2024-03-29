%{
    #include "y.tab.h"
void strDstr(char *chaine, const char *str, char *result)
{
    char temp[100] = "";
    char *ptr = NULL;
    unsigned i = 0, j = 0, n = strlen(chaine), a = 0;
    ptr = strstr(chaine, str);

    for (i = 0; i < n; i++)
    {
        a = ptr - chaine;
        if (i < a || i >= a + strlen(str))
            temp[j++] = chaine[i];
    }

    strcpy(result, temp);
}

int comment_lines = 0;
%}


%x comment
%x short_comment
%%


"✔" {return tTRUE;}
"true" {return tTRUE;}
"false" {return tFALSE;}
"✖" {return tFALSE;}
"main" {return tMAIN; 
    yylval.commentSize = 0;}
"const" {return tCONST;}
"bool" {return tBOOL;}
"int" {return tINT;}
"string" {return tCHARET;}
"char" {return tCHAR;}
"float" {return tFLOAT;}
"return" {return tRET;}
"void" {return tVOID;}
"if" {return tIF;}
"😕" {return tIF;}
"while" {return tWHILE;}
"else" {return tELSE;}
"printf" {return tPRINT;}
"(" {return tPARO;}
")" {return tPARF;}
"{" {return tACCO;}
"}" {return tACCF;}
" " 
"\t" {}
"\n" {}
"!=" {return tDIFF;}
"!" {return tEXCLAM;}
"+" {return tPLUS;}
"-" {return tMOINS;}
"*" {return tMUL;}
"/" {return tDIV;}
">=" {return tSUP_EGAL;}
"<=" {return tINF_EGAL;}
">" {return tSUP;}
"<" {return tINF;}
"==" {return tEGAL;}
"=" {return tEQV;}
"&&" {return tAND;}
"||" {return tOR;}
";" {return tPV;}
"," {return tV;}

"/*"         BEGIN(comment);{comment_lines = 0;}

<comment>[^*\n]*        /* consommer tout ce qui n'est pas un a '*' */
<comment>"*"+[^*/\n]*   /* consommer les '*'s non suivient par un '/'s */
<comment>\n {comment_lines++; printf("++\n");}
<comment>"*"+"/"        BEGIN(INITIAL); {yylval.commentSize = comment_lines + 1; comment_lines = 0; return tCOM;}

"//"         BEGIN(short_comment); {yylval.commentSize = 1; comment_lines = 0; return tCOM;}

<short_comment>[[:alnum:]]*       /* consommer tout ce qui n'est pas un a '*' */
<short_comment>\n         BEGIN(INITIAL);

\'([^\\\"]|\\.)\' {
    char a[10] = "";
    strcpy(a,yytext);
    strDstr(a, "\'", a); //Supprimer les quotes du caractere
    strDstr(a, "\'", a); //Supprimer les quotes du caractere
    yylval.caractere = a[0]; 
    return tCARACT;
    }
\"([^\\\"]|\\.)*\" {
    char a[100] = "";
    strcpy(a,yytext);
    strDstr(a, "\"", a);
    strDstr(a, "\"", a);
    yylval.string = a; 
    return tSTRING;
    }
([0-9]+\.[0-9]+) {yylval.fl = atof(yytext); return tDECIMAL;}
(-[0-9]+)|[0-9]+ {yylval.entier = atoi(yytext); return tNUM;}
[a-z]([0-9]|[A-Z]|[a-z]|"_")* {yylval.id = strdup(yytext); return tID;}
. {return tERROR;}
