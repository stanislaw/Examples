generate-parser: clean flex bison

clean:
	rm -rf './Parser/Generated Code'
	mkdir -p './Parser/Generated Code'

flex:
	# brew install flex
	/usr/local/bin/flex ./Parser/Lexer.lm

bison:
	# brew install bison
	/usr/local/bin/bison -d ./Parser/Parser.ym

