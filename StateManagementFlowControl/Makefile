all: example StateFlow.pdf

error.o: error.s
	as --gstabs error.s -o error.o

alloc.o: alloc.s
	as --gstabs alloc.s -o alloc.o

example.o: example.s
	as --gstabs example.s -o example.o

pair.o: pair.s
	as --gstabs pair.s -o pair.o

refcount.o: refcount.s
	as --gstabs refcount.s -o refcount.o

string.o: string.s
	as --gstabs string.s -o string.o

symboltable.o: symboltable.s
	as --gstabs symboltable.s -o symboltable.o

common.o: common.s
	as --gstabs common.s -o common.o

example: string.o refcount.o pair.o alloc.o example.o symboltable.o common.o error.o
	ld string.o refcount.o pair.o alloc.o example.o symboltable.o common.o error.o -o example

StateFlow.pdf: StateFlow.xml
	db2pdf -d stateflow.dsl#printdraft StateFlow.xml
