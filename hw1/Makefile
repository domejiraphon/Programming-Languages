
output: bison lex
	g++ lex.yy.c jy3694.calc.tab.c -o calculator

bison: jy3694.calc.y
	bison -d jy3694.calc.y

lex: jy3694.calc.l
	flex jy3694.calc.l

