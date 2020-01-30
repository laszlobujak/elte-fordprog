// Generated by Bisonc++ V4.09.02 on Wed, 28 Oct 2015 08:24:48 +0100

#ifndef Parser_h_included
#define Parser_h_included

// $insert baseclass
#include "Parserbase.h"
#include "FlexLexer.h"
#include <cstdlib>

#undef Parser
class Parser: public ParserBase
{
        
    public:
		Parser( std::istream & in ) : lexer( &in, &std::cerr ) {}
        int parse();

    private:
        std::map<std::string,var_data> szimbolumtabla;
        yyFlexLexer lexer;
        void error(char const *msg);    // called on (syntax) errors
        int lex();                      // returns the next token from the
                                        // lexical scanner. 
        void print();                   // use, e.g., d_token, d_loc

    // support functions for parse():
        void executeAction(int ruleNr);
        void errorRecovery();
        int lookup(bool recovery);
        void nextToken();
        void print__();
        void exceptionHandler__(std::exception const &exc);
};


#endif
