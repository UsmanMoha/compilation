YACC = yacc
LEX = lex
CC = cc
LIBS = -lfl

all: lex yacc calcul

run: input.txt
	@./calcul < $^ 

calcul: lex.yy.c y.tab.c
	@$(CC) -o $@ $^ $(LIBS)

yacc: myfile.y
	@$(YACC) -d $<

lex: myfile.l
	@$(LEX) $<

clean:
	@rm -f lex.yy.c y.tab.c y.tab.h

.PHONY: all clean
