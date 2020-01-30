%baseclass-preinclude "semantics.h"
%lsp-needed

%union
{
  std::string *szoveg;
  type  *types;
}

%token PROGRAM PROGRAM_VEGE VALTOZOK UTASITASOK EGESZ LOGIKAI IGAZ HAMIS SKIP HA AKKOR KULONBEN HA_VEGE CIKLUS AMIG CIKLUS_VEGE KI BE ERTEKADAS NYITOZAROJEL CSUKOZAROJEL SZAM
%token <szoveg> VALTOZO

%left VAGY
%left ES
%left EGYENLO
%left KISEBB NAGYOBB KISEBBEGYENLO NAGYOBBEGYENLO
%left PLUSZ MINUSZ   
%left SZOROZVA OSZTVA SZAZALEK
%right NEM

%type<types> exp

%%

start:
    PROGRAM VALTOZO deklaracio utasitasok PROGRAM_VEGE
    {
        std::cout << "start -> PROGRAM VALTOZO deklaracio utasitasok PROGRAM_VEGE" << std::endl;
    }
;

deklaracio:
    // ures
    {
        std::cout << "deklaracio -> epszilon" << std::endl;
    }
    |
    VALTOZOK EGESZ VALTOZO dekl
    {
        if( szimbolumtabla.count(*$3) > 0 )
        {
            std::stringstream ss;
            ss << "Ujradeklaralt valtozo: " << *$3 << ".\n" << "Korabbi deklaracio sora: " << szimbolumtabla[*$3].decl_row << std::endl;
            error( ss.str().c_str() ); 
        }
        else
        {
            szimbolumtabla[*$3] = var_data( d_loc__.first_line, natural );
        }
        delete $3;
    }
    |
    VALTOZOK LOGIKAI VALTOZO dekl
    {
        if( szimbolumtabla.count(*$3) > 0 )
        {
            std::stringstream ss;
            ss << "Ujradeklaralt valtozo: " << *$3 << ".\n" << "Korabbi deklaracio sora: " << szimbolumtabla[*$3].decl_row << std::endl;
            error( ss.str().c_str() ); 
        }
        else
        {
            szimbolumtabla[*$3] = var_data( d_loc__.first_line, boolean );
        }
        delete $3;
    }
;

dekl:
    // ures
    {
        std::cout << "dekl -> epszilon" << std::endl;
    }
|
    EGESZ VALTOZO dekl
    {
        if( szimbolumtabla.count(*$2) > 0 )
        {
            std::stringstream ss;
            ss << "Ujradeklaralt valtozo: " << *$2 << ".\n" << "Korabbi deklaracio sora: " << szimbolumtabla[*$2].decl_row << std::endl;
            error( ss.str().c_str() ); 
        }
        else
        {
            szimbolumtabla[*$2] = var_data( d_loc__.first_line, natural );
        }
        delete $2;
    }
|
    LOGIKAI VALTOZO dekl
    {
        if( szimbolumtabla.count(*$2) > 0 )
        {
            std::stringstream ss;
            ss << "Ujradeklaralt valtozo: " << *$2 << ".\n" << "Korabbi deklaracio sora: " << szimbolumtabla[*$2].decl_row << std::endl;
            error( ss.str().c_str() ); 
        }
        else
        {
            szimbolumtabla[*$2] = var_data( d_loc__.first_line, boolean );
        }
        delete $2;
    }
;

utasitasok:
    UTASITASOK utasitasok_2
    {
         std::cout << "utasitasok -> UTASITASOK utasitasok_2" << std::endl;
    }
;

utasitasok_2:
    SKIP utasitasok_3
    {
        std::cout << "utasitasok_2 -> SKIP utasitasok_3" << std::endl;
    }
|
    BE VALTOZO utasitasok_3
    {
        std::cout << "utasitasok_2 -> BE VALTOZO utasitasok_3" << std::endl;
    }
|
    KI exp utasitasok_3
    {
        std::cout << "utasitasok_2 -> KI exp utasitasok_3" << std::endl;
    }
|
    HA exp AKKOR utasitasok_2 HA_VEGE utasitasok_3
    {
        if(*$2 != boolean)
        {
      	    error( "Tipushibas kifejezes.\n" );
        }
        delete $2;
    }
|
    HA exp AKKOR utasitasok_2 KULONBEN utasitasok_2 HA_VEGE utasitasok_3
    {
        if(*$2 != boolean)
        {
      	    error( "Tipushibas kifejezes.\n" );
        }
        delete $2;
    }
|
    CIKLUS AMIG exp utasitasok_2 CIKLUS_VEGE utasitasok_3
    {
        if(*$3 != boolean)
        {
      	    error( "Tipushibas kifejezes.\n" );
        }
        delete $3;
    }
|
    VALTOZO ERTEKADAS exp utasitasok_3
    {
        if( szimbolumtabla.count(*$1) == 0 )
        {
            std::stringstream ss;
            ss << "Nem deklaralt valtozo: " << *$1 << ".\n"
            << "Valtozo sora: " << d_loc__.first_line << std::endl;
            error( ss.str().c_str() );
        }
        if(szimbolumtabla[*$1].var_type != *$3){
      	    error( "Tipushibas ertekadas.\n" );
        }
        delete $1;
        delete $3;
    }
;

utasitasok_3:
    // ures
    {
        std::cout << "utasitasok_3 -> epszilon" << std::endl;
    }
|
    SKIP utasitasok_3
    {
        std::cout << "utasitasok_3 -> SKIP utasitasok_3" << std::endl;
    }
|
    BE VALTOZO utasitasok_3
    {
        std::cout << "utasitasok_3 -> BE VALTOZO utasitasok_3" << std::endl;
    }
|
    KI exp utasitasok_3
    {
        std::cout << "utasitasok_3 -> KI exp utasitasok_3" << std::endl;
    }
|
    HA exp AKKOR utasitasok_2 HA_VEGE utasitasok_3
    {
        if(*$2 != boolean)
        {
      	    error( "Tipushibas kifejezes.\n" );
        }
        delete $2;
    }
|
    HA exp AKKOR utasitasok_2 KULONBEN utasitasok_2 HA_VEGE utasitasok_3
    {
        if(*$2 != boolean)
        {
      	    error( "Tipushibas kifejezes.\n" );
        }
        delete $2;
    }
|
    CIKLUS AMIG exp utasitasok_2 CIKLUS_VEGE utasitasok_3
    {
        if(*$3 != boolean)
        {
      	    error( "Tipushibas kifejezes.\n" );
        }
        delete $3;
    }
|
    VALTOZO ERTEKADAS exp utasitasok_3
    {
        if( szimbolumtabla.count(*$1) == 0 )
        {
            std::stringstream ss;
            ss << "Nem deklaralt valtozo: " << *$1 << ".\n"
            << "Valtozo sora: " << d_loc__.first_line << std::endl;
            error( ss.str().c_str() );
        }
        if(szimbolumtabla[*$1].var_type != *$3){
      	    error( "Tipushibas ertekadas.\n" );
        }
        delete $1;
        delete $3;
    }
;

exp:
    VALTOZO
    {
        if( szimbolumtabla.count(*$1) == 0 )
        {
            std::stringstream ss;
            ss << "Nem deklaralt valtozo: " << *$1 << ".\n"
            << "Valtozo sora: " << d_loc__.first_line << std::endl;
            error( ss.str().c_str() );
        }
        $$ = new type(szimbolumtabla[*$1].var_type);
        delete $1;
    }
|
    SZAM
    {
        $$ = new type(natural);
    }
|
   IGAZ
    {
        $$ = new type(boolean);
    }
|
   HAMIS
    {
        $$ = new type(boolean);
    }
|
   exp PLUSZ exp
    {
        if((*$1 != *$3) || (*$1 == boolean))
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(*$1);
        }
        delete $1;
        delete $3;
    }
|
   exp MINUSZ exp
    {
        if((*$1 != *$3) || (*$1 == boolean))
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(*$1);
        }
        delete $1;
        delete $3;
    }
|
   exp SZOROZVA exp
    {
        if((*$1 != *$3) || (*$1 == boolean))
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(*$1);
        }
        delete $1;
        delete $3;
    }
|
   exp OSZTVA exp
    {
        if((*$1 != *$3) || (*$1 == boolean))
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(*$1);
        }
        delete $1;
        delete $3;
    }
|
   exp SZAZALEK exp
    {
        if((*$1 != *$3) || (*$1 == boolean))
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(*$1);
        }
        delete $1;
        delete $3;
    }
|
   exp KISEBB exp
    {
        if((*$1 != *$3) || (*$1 == boolean))
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(boolean);
        }
        delete $1;
        delete $3;
    }
|
   exp NAGYOBB exp
    {
        if((*$1 != *$3) || (*$1 == boolean))
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(boolean);
        }
        delete $1;
        delete $3;
    }
|
   exp KISEBBEGYENLO exp
    {
        if((*$1 != *$3) || (*$1 == boolean))
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(boolean);
        }
        delete $1;
        delete $3;
    }
|
   exp NAGYOBBEGYENLO exp
    {
        if((*$1 != *$3) || (*$1 == boolean))
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(boolean);
        }
        delete $1;
        delete $3;
    }
|
   exp EGYENLO exp
    {
        if(*$1 != *$3)
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(boolean);
        }
        delete $1;
        delete $3;
    }
|
    exp ES exp
    {
        if(*$1 != *$3)
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(*$1);
        }
        delete $1;
        delete $3;
    }
|
    exp VAGY exp
    {
        if(*$1 != *$3)
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(*$1);
        }
        delete $1;
        delete $3;
    }
|
    NYITOZAROJEL exp CSUKOZAROJEL
    {
        $$ = new type(*$2);
        delete $2;
    }
|
    NEM exp
    {
        if(*$2 != boolean)
        {
            error( "Tipushibas kifejezes.\n" );
        }
        else
        {
            $$ = new type(*$2);
        }
        delete $2;
    }
;
