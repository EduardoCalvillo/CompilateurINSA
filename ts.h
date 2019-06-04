#ifndef _TS_H
#define _TS_H
#define INT 1
#define FLOAT 2
#define CHAR 4
#define STRING 3
#define BOOL 5

#define SUP_EGAL "SUPEGAL"
#define INF_EGAL "INFEGAL"
#define SUP "SUP"
#define INF "INF"
#define EGAL "EGAL"
#define DIFF "DIFF"

#define INST_TBL_SIZE 1024

struct symbol
{
    char name[16];
    int adresse;
    int profondeur;
    int type;
} symbols[INST_TBL_SIZE];

struct instruction
{
    char *inst;
    int rA;
    int rB;
    int rC;
    int nbrArg;
} instTable[1024];

void ts_add(char *name, int type);
int ts_add_tmp(int type);
int ts_get_adr(int index);
int ts_get_index(char *name);
int ts_get_type(int index);
void ts_print(void);
int ts_get_last_index();
void ts_pop_tmp();
int ts_get_profondeur(char *name);
void ts_inc_profondeur();
void ts_dec_profondeur();
void check_type(int first, int second);
char *toString(int type);
extern void printError(const char *name, ...);
void init(void);
extern void printASM(void);
char *toHexa(char *op);
void tins_add1(char *instruction, int rA);
void tins_add2(char *instruction, int rA, int rB);
void tins_add3(char *instruction, int rA, int rB, int rC);
int tins_get_current(void);
int tins_get_next(void);
void update_jmp_addr(int addr);
void update_jmp_addr_to(int addr, int to);
#endif