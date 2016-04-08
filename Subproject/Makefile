IN_PATH=./Source
IN_FILES=$(wildcard $(IN_PATH)/*.in)

OUT_PATH=./Generated-Code

OUT_FILES := $(patsubst %, $(OUT_PATH)/%, $(notdir $(IN_FILES)))
OUT_FILES := $(patsubst %.in, %.out, $(OUT_FILES))

# this is for debugging
# $(error $(OUT_FILES))

default: generate

generate: $(OUT_FILES)

clean:
	rm -rf $(OUT_PATH)

$(OUT_PATH)/%.out: $(OUT_PATH) $(IN_PATH)/%.in
	cp -v $(IN_PATH)/$*.in $(OUT_PATH)/$*.out

$(OUT_PATH):
	mkdir -p $(OUT_PATH)

