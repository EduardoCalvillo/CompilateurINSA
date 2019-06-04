%{
    #include "ts.h"
    int yylex(void);
    void yyerror(char*);
    int type = -1;
%}

%token tEMOJI tMAIN tCONST tBOOL tINT tCHARET tCHAR tCARACT tFLOAT tRET tVOID tWHILE tIF tELSE tPRINT tPARO tPARF tACCO tACCF tEXCLAM tPLUS tMOINS tMUL tDIV tEQV tPV tV tG tNUM tSTRING tDECIMAL tID tERROR tSUP_EGAL tINF_EGAL tSUP tINF tEGAL tAND tOR tTRUE tFALSE tDIFF
%right tEQV
%left tPLUS tMOINS
%left tMUL tDIV
%left tPARO 
%nonassoc tIFEND         
%nonassoc tELSE

%union{
    int entier;
    char* id;
    float fl;
    char* string;  
    char caractere; 
      
}

%type <entier> tNUM;
%type <id> tID;
%type <string> tSTRING;
%type <fl> tDECIMAL;
%type <caractere> tCARACT; 
%type <entier> Valeurs; 
%type <entier> Boolean; 
%type <entier> Expr; 
%type <entier> tIF; 
%type <entier> tELSE; 
%type <entier> Else; 
%type <entier> tWHILE; 
%type <entier> tPARO; 
%type <id> Cond; 

%%
start: Fonctions;
Fonctions: Fonction Fonctions | ;
Fonction:   Type_void tID tPARO Args_void tPARF Body    
        |   Type_void tMAIN {init();}tPARO tPARF Body { printASM();};

Type_void: Type | tVOID;
Args_void: Args | tVOID;
Type: tINT  { type = INT; }| tCHAR { type = CHAR; }| tFLOAT { type = FLOAT; }| tCHARET { type = STRING; } | tBOOL { type = BOOL; };

Args: Arg Tv_args | ;
Arg: Type tID;
Tv_args: tV Arg Tv_args | ;


Body: tACCO {ts_inc_profondeur();} Lignes tACCF {ts_dec_profondeur();};
Lignes: Ligne Lignes | ; 

Ligne: Affectation tPV;
Affectation: tID  tEQV  Expr {    
        tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));    
        int index = ts_get_index($1);
        if(index == -1)
        printError("undefined variable %s\n", $1);
        tins_add2("STORE", ts_get_adr(index), 0);
        ts_pop_tmp();  
       };

Expr:  tPARO Expr tPARF {$$ = $2;} 
    |   Expr  tPLUS  Expr 
        {
                //check_type($1,$3); 
                tins_add2("LOAD", 1, ts_get_adr(ts_get_last_index()));
                ts_pop_tmp();
                tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));
                tins_add3("ADD", 0, 0, 1);
                
                tins_add2("STORE", ts_get_adr(ts_get_last_index()), 0);
        }
    |   Expr  tMOINS  Expr
        {
                //check_type($1,$3);
                tins_add2("LOAD", 1, ts_get_adr(ts_get_last_index()));
                ts_pop_tmp();
                tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));
                tins_add3("SOU", 0, 0, 1);
                tins_add2("STORE", ts_get_adr(ts_get_last_index()), 0);
        }
    |   Expr  tMUL  Expr
        {
                //check_type($1,$3); 
                tins_add2("LOAD", 1, ts_get_adr(ts_get_last_index()));
                ts_pop_tmp();
                tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));
                tins_add3("MUL", 0, 0, 1);
                tins_add2("STORE", ts_get_adr(ts_get_last_index()), 0);
                /*$$ <- $1*$2;*/
        } 
    |   Expr  tDIV  Expr
        {
                //comment arreter l execution et afficher des erreurs
                //comment recupérer depuis le code une valeure stockée du registre
                /*if($3 == 0)
                //CRIERRRRRRRRRRRRRRRRRRRRR
                ;
                */
                //check_type($1,$3);
                tins_add2("LOAD", 1, ts_get_adr(ts_get_last_index()));
                ts_pop_tmp();
                tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));
                tins_add3("DIV", 0, 0, 1);
                tins_add2("STORE", ts_get_adr(ts_get_last_index()), 0);
        }
    |   Valeurs {$$ = $1;};
 
Ligne: Declaration tPV;
Declaration:    Type tID { ts_add($2, type);} Decl_sans_type 
            |   Type tID { ts_add($2, type);} tEQV Expr 
                { 
                        tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));    
                        int index = ts_get_index($2);
                        tins_add2("STORE", ts_get_adr(index), 0);
                        ts_pop_tmp();  
                } Decl_sans_type;
Decl_sans_type: tV tID  { ts_add($2, type); } Decl_sans_type
            |   tV tID { ts_add($2, type);} tEQV Expr 
                { 
                        tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));    
                        int index = ts_get_index($2);
                        tins_add2("STORE", ts_get_adr(index), 0);
                        ts_pop_tmp();  
                } Decl_sans_type;
            | ;

Valeurs:    tID {
                printf(">id> %s\n", $1);
                int index = ts_get_index($1);//0
                if(index == -1)
                printError("undefined");
                int adr = ts_get_adr(index);//400
                int tmp = ts_add_tmp(ts_get_type(index));//8
                // printf("index = [%d], addresse=[%d], tmp=[%d]\n", index,adr,tmp);
                tins_add2("LOAD", 0, adr);
                tins_add2("STORE", ts_get_adr(tmp), 0);
                $$ = ts_get_type(index);
                }
        |   tNUM {
                printf(">int> %d\n", $1);
                int tmp = ts_add_tmp(INT);
                tins_add2("AFC", 0, $1);    
                tins_add2("STORE", ts_get_adr(tmp), 0);
                $$ = INT;
                }
        |   tDECIMAL {printf(">float> %f\n", $1);$$ = FLOAT; }
        |   tSTRING {printf(">string> %s\n", $1);$$ = STRING; 
        // RAJOUTER dans la table de symboles, ATTENTION à la manière d'utiliser les @s mémoire
        }
        |   tCARACT {
                printf(">char> %c\n", $1);
                int tmp = ts_add_tmp(CHAR);
                tins_add2("AFC", 0, $1);
                tins_add2("STORE", ts_get_adr(tmp), 0);
                $$ = CHAR;
        }

        |   Boolean {
                int tmp = ts_add_tmp(BOOL);
                tins_add2("AFC", 0, $1);
                tins_add2("STORE", ts_get_adr(tmp), 0);
                $$ = BOOL;
                };

Boolean:    tTRUE  { 
                printf(">bool> ✔\n");
                $$ = 1;
                } 
        |   tFALSE {
                printf(">bool> ✖\n");
                $$ = 0;
                }; 


Ligne: tIF tPARO Tests tPARF {
                        tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));
                        tins_add2("JMPC", -1, 0); 
                        $1 = tins_get_current();
                } Body Else {
                        if ($7 == -1) {
                                update_jmp_addr($1);
                        } else {
                                update_jmp_addr_to($1, $7+1);
                                update_jmp_addr($7);
                        }
                };

Else: tELSE     {
                        tins_add1("JMP", -1);
                        $1 = tins_get_current();  
                } Body {
                        $$ = $1;
                }
                | { $$ = -1; };
 
Ligne: tWHILE tPARO {
                        $2 = tins_get_next();
                } Tests tPARF {
                        tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));
                        tins_add2("JMPC", -1, 0); 
                        $1 = tins_get_current();
                }Body {
                        tins_add1("JMP", $2);
                        update_jmp_addr($1);
                };

Tests: Test And_or_Test;
Test: Expr Cond Expr {
                tins_add2("LOAD", 1, ts_get_adr(ts_get_last_index()));
                ts_pop_tmp();
                tins_add2("LOAD", 0, ts_get_adr(ts_get_last_index()));
                tins_add3($2, 0, 0, 1);
                tins_add2("STORE", ts_get_adr(ts_get_last_index()), 0);

        }
        | Expr;
And_or_Test: And_Or Test And_or_Test |  ;


//Considerer le cas not (test): negation de test
Cond: tSUP_EGAL {$$ = SUP_EGAL;} 
        | tINF_EGAL {$$ = INF_EGAL;} 
        | tSUP {$$ = SUP;} 
        | tINF {$$ = INF;}
        | tEGAL {$$ = EGAL;}
        | tDIFF {$$ = DIFF;};

And_Or: tAND | tOR;






Ligne: tRET Valeurs tPV;

Ligne: tPRINT tPARO Valeurs tPARF tPV {ts_pop_tmp();};

%%

void main(void) {
//XXX    yydebug = 1;
    yyparse();
}