YACC = yacc
LEX = lex
CC = cc
LIBS = -lfl

all: lex yacc exe

run: input.txt
	@./exe < $^ 

exe: lex.yy.c y.tab.c
	@$(CC) -o $@ $^ $(LIBS)

yacc: monfichier.y
	@$(YACC) -d $<

lex: monfichier.l
	@$(LEX) $<

clean:
	@rm -f lex.yy.c y.tab.c y.tab.h

.PHONY: all clean
