%{
#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include "jy3694.calc.tab.h"  /* We want the tokens defined in calc1.y. */
%}

%option noyywrap

%%

                        /* 'val' in 'yylval.val' is the field declared in
                           calc1.y with the %union directive. [0-9]+ (\.[0-9]+)?      { yylval.val_f = atoi(yytext); return NUMF; } */

[0-9]+(\.[0-9]+)?      { yylval.val = atoi(yytext); return NUMBER; }
\n                      { return EOL; }
"-"                     { return SUB; }
"+"                     { return ADD; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"^"                     { return POW; }
"%"|"mod"                     { return MOD; }
"("                     { return L_BRACKET; }
")"                     { return R_BRACKET; }
"!"                     { return FACTORIAL; }

"PI"|"pi"                    { return PI; }
"sqrt"|"SQRT"           { return SQRT; }
"abs"|"ABS"             { return ABS; }
"floor"|"FLOOR"         { return FLOOR; }
"ceil"|"CEIL"           { return CEIL; }
"cos"|"COS"             { return COS; }
"sin"|"SIN"             { return SIN; }
"tan"|"TAN"             { return TAN; }
"log2"|"LOG2"             { return LOG2; }
"log10"|"LOG10"             { return LOG10; }
"gbp_to_usd"|"GBP_TO_USD"             { return GBP_TO_USD; }
"usd_to_gbp"|"USD_TO_GBP"             { return USD_TO_GBP; }
"gbp_to_euro"|"GBP_TO_EURO"             { return GBP_TO_EURO; }
"euro_to_gbp"|"EURO_TO_GBP"             { return EURO_TO_GBP; }
"usd_to_euro"|"USD_TO_EURO"             { return USD_TO_EURO; }
"euro_to_usd"|"EURO_TO_USD"             { return EURO_TO_USD; }
"cel_to_fah"|"CEL_TO_FAH"             { return CEL_TO_FAH; }
"fah_to_cel"|"FAH_TO_CEL"             { return FAH_TO_CEL; }
"mi_to_km"|"MI_TO_KM"             { return MI_TO_KM; }
"km_to_mi"|"KM_TO_MI"             { return KM_TO_MI; }

"var"|"VAR"                      { return VAR_KEYWORD; }
([a-z]|[A-Z])+([a-z]|[A-Z]|[0-9])*     { return VARIABLE; }
"="                               { return EQUALS; }

[ \t\r]+              { /* Ignore white characters. */ }
.                       { std::cerr << "ERROR: Undefined symbol" << std::endl; exit(1); }

%%
