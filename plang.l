%option noyywrap c++ yylineno

%{
#include <iostream>
#include <cstdlib>
#include "Parserbase.h"
%}

WS  [ \t\n]
VALTOZO [a-zA-Z_][a-zA-Z0-9_]*
SZAM [0-9]+
KOMMENT [#].*

%%

PROGRAM         return Parser::PROGRAM;
PROGRAM_VEGE    return Parser::PROGRAM_VEGE;
VALTOZOK:       return Parser::VALTOZOK;
UTASITASOK:     return Parser::UTASITASOK;
EGESZ           return Parser::EGESZ;
LOGIKAI         return Parser::LOGIKAI;
IGAZ            return Parser::IGAZ;
HAMIS           return Parser::HAMIS;
ES              return Parser::ES;
VAGY            return Parser::VAGY;
NEM             return Parser::NEM;
SKIP            return Parser::SKIP;
HA              return Parser::HA;
AKKOR           return Parser::AKKOR;
KULONBEN        return Parser::KULONBEN;
HA_VEGE         return Parser::HA_VEGE;
CIKLUS          return Parser::CIKLUS;
AMIG            return Parser::AMIG;
CIKLUS_VEGE     return Parser::CIKLUS_VEGE;
KI:             return Parser::KI;
BE:             return Parser::BE;

{SZAM}          return Parser::SZAM;
"("             return Parser::NYITOZAROJEL;
")"             return Parser::CSUKOZAROJEL;
":="            return Parser::ERTEKADAS;
"+"             return Parser::PLUSZ;
"-"             return Parser::MINUSZ;
"*"             return Parser::SZOROZVA;
"/"             return Parser::OSZTVA;
"%"             return Parser::SZAZALEK;
"<"             return Parser::KISEBB;
">"             return Parser::NAGYOBB;
"="             return Parser::EGYENLO;
"<="            return Parser::KISEBBEGYENLO;
">="            return Parser::NAGYOBBEGYENLO;

{KOMMENT}   // komment (akar ures): semmi teendo
{VALTOZO}       return Parser::VALTOZO;
{WS}+       // feher szokozok: semmi teendo

.           {
                std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
                exit(1);
            }

%%
