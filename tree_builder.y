%{
#include <iostream>
#include <string>
#include "tree_node.h"
#include "parse_tree.h"
using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE* yyin;

ParseTree parse_tree; // Global instance of ParseTree

void yyerror(const char *s) {
    cerr << "Parser error: " << s << endl;
    exit(1);
}
%}

%union {
    int integer_val;
    char* string_val;
    TreeNode* tree_node_ptr;
}

%token <integer_val> INTEGER
%token <string_val> STRING IDENTIFIER
%token BUILDNODE FOR IN LSQBRACKET COLON RSQBRACKET LBRACE RBRACE SEMICOLON EQUALS PLUS
%type <tree_node_ptr> program command_list command build_node for_loop

%%

program : command_list { $$ = $1; parse_tree.buildTree(); }

command_list : command_list command { $$ = $1; }
             | /* empty */

command : build_node { $$ = $1; }

build_node : BUILDNODE LBRACE IDENTIFIER EQUALS STRING SEMICOLON IDENTIFIER EQUALS INTEGER SEMICOLON IDENTIFIER EQUALS STRING SEMICOLON RBRACE {
                $$ = new TreeNode($3, "", static_cast<char*>($6)); // Cast $6 to char* assuming it's a string
                parse_tree.addNode($$); // Add node to parse tree
            }
            | BUILDNODE LBRACE IDENTIFIER EQUALS STRING SEMICOLON IDENTIFIER EQUALS INTEGER SEMICOLON IDENTIFIER EQUALS STRING SEMICOLON RBRACE {
                $$ = new TreeNode($3, static_cast<char*>($6), $9); // Cast $6 to char* assuming it's a string
                parse_tree.addNode($$); // Add node to parse tree
            }

for_loop : FOR IDENTIFIER IN LSQBRACKET INTEGER COLON INTEGER RSQBRACKET LBRACE command_list RBRACE {
                for (int i = $5; i <= $7; i++) {
                    TreeNode* node = parse_tree.findNodeByIdentifier("A" + to_string(i)); // Assuming you have a method to find nodes by identifier
                    if (node) {
                        TreeNode* child = new TreeNode("B" + to_string(i), "", 3); // Create child node
                        node->addChild(child); // Add child to parent node
                    }
                }
            }

%%

int main() {
    yyin = fopen("input_file.tb", "r");
    yyparse();
    fclose(yyin);
    parse_tree.printTree(); // Print the tree after parsing and building
    return 0;
}
