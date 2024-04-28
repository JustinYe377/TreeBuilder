default: treeBuilder


treeBuilder: tree_builder.tab.c lex.yy.c parse_tree.h tree_node.h
	g++ -o treeBuilder tree_builder.tab.c -ll

lex.yy.c: tree_builder.l
	lex -o lex.yy.c tree_builder.l

tree_builder.tab.c: tree_builder.y
	bison -o tree_builder.tab.c -t -v tree_builder.y

clean:
	rm -f treeBuilder lex.yy.o tree_builder.tab.o lex.yy.c tree_builder.tab.c tree_builder.tab.h