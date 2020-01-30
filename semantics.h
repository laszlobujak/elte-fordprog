#ifndef SEMANTICS_H
#define SEMANTICS_H

#include <iostream>
#include <string>
#include <map>
#include <sstream>

enum type { natural, boolean };

struct var_data
{
    int decl_row;
    type var_type;

    var_data(){};

    var_data( int s, type t )
        : decl_row(s), var_type(t) {}
};

#endif //SEMANTICS_H