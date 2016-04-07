PARSER_PATH=./Source
PARSER_FILES=$(wildcard $(PARSER_PATH)/*)

OUT_PATH=./Generated-Code

# brew install flex && brew link flex --force
# brew install bison && brew link bison --force
# it is important to then explicitly specify
# full path:
# /usr/local/bin/flex
# /usr/local/bin/bison
# because Xcode has its own environment with 10-year-old GNU tools enabled

generate: $(OUT_PATH)

versions:
	/usr/local/bin/flex --version
	/usr/local/bin/bison --version

clean:
	rm -rf $(OUT_PATH)

$(OUT_PATH): $(PARSER_FILES)
	mkdir -p $(OUT_PATH)

	/usr/local/bin/flex --header-file=$(OUT_PATH)/Lexer.h --outfile=$(OUT_PATH)/Lexer.m $(PARSER_PATH)/Lexer.lm 
	/usr/local/bin/bison --defines=$(OUT_PATH)/Parser.h --output=$(OUT_PATH)/Parser.m $(PARSER_PATH)/Parser.ym
	touch $(OUT_PATH)

