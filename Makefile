compiler: y.tab.c lex.yy.c
	gcc y.tab.c lex.yy.c ts.c -o compiler -ly -ll
lex.yy.c: specifications.l
	flex specifications.l
y.tab.c: compiler.y
	yacc -t -d -v compiler.y
test: compiler
	./compiler < test.c
simple: compiler
	./compiler < simple.c 