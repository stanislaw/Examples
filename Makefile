generate-parser: clean flex bison

clean:
	rm -rf './Parser/Generated Code'
	mkdir -p './Parser/Generated Code'

flex:
	./bin/flex ./Parser/Lexer.lm

bison:
	./bin/bison -d ./Parser/Parser.ym

