CHAPTERS = CountingCh.xml FilesCh.xml FirstProgsCh.xml FunctionsCh.xml IntroductionCh.xml LinkingCh.xml MemoryCh.xml MemoryIntCh.xml OptimizationCh.xml OtherLangCh.xml RobustCh.xml WhereNextCh.xml
APPENDICES = ASCIIAp.xml GUIAp.xml SyscallAp.xml
PROGS = alloc.s exit.s factorial.s Hello-World.c helloworld-lib.s helloworld-nolib.s maximum.s printf-example.s toupper2.s toupper3.s toupper.s
GRAPHICS = assembling-a-program.dia memorypages.svg memory.svg
INDEX = index.xml
BOOKNOINDEX = ProgrammingGroundUp.xml programming.dsl $(CHAPTERS) $(PROGS) $(GRAPHICS) $(APPENDICES)
FULLBOOK = $(BOOKNOINDEX) $(INDEX)
JADE = openjade

all: ProgrammingGroundUp.pdf

ProgrammingGroundUp.pdf: ProgrammingGroundUp.ps
	ps2pdf ProgrammingGroundUp.ps

ProgrammingGroundUp.ps: ProgrammingGroundUp.dvi
	dvips ProgrammingGroundUp.dvi -o ProgrammingGroundUp.ps

ProgrammingGroundUp.dvi: ProgrammingGroundUp.tex
	jadetex ProgrammingGroundUp.tex
	jadetex ProgrammingGroundUp.tex
	jadetex ProgrammingGroundUp.tex

ProgrammingGroundUp.tex: $(FULLBOOK)
	$(JADE) -t tex -d programming.dsl#printdraft xml.dcl ProgrammingGroundUp.xml

index.xml: HTML.index 
	collateindex.pl -o index.xml HTML.index

HTML.index: $(BOOKNOINDEX)
	collateindex.pl -N >index.xml
	$(JADE) -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets/html/docbook.dsl xml.dcl ProgrammingGroundUp.xml 
	rm -f *.htm *.html

clean:
	rm -f ProgrammingGroundUp.log
	rm -f ProgrammingGroundUp.aux
	rm -f ProgrammingGroundUp.tex
	rm -f ProgrammingGroundUp.dvi
	rm -f HTML.index

realclean: clean
	rm -f ProgrammingGroundUp.pdf
	rm -f ProgrammingGroundUp.ps
	rm -rf html/

download:
	scp -C johnnyb@eskimo.com:/u/j/johnnyb/Projects/ProgrammingGroundUp/*.* .

upload:
	scp -C *.* Makefile johnnyb@eskimo.com:/u/j/johnnyb/Projects/ProgrammingGroundUp/

