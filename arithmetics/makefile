YACC = yacc
LEX = lex
CC = cc
LIBS = -lfl

all: lex yacc arith

run: input.txt
	@./arith < $^ 

arith: lex.yy.c y.tab.c
	@$(CC) -o $@ $^ $(LIBS)

yacc: file.y
	@$(YACC) -d $<

lex: file.l
	@$(LEX) $<

clean:
	@rm -f lex.yy.c y.tab.c y.tab.h

.PHONY: all clean
