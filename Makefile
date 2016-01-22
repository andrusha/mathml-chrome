# Makefile for GNU make

RELEASE_DIR = ./release
NAME = mathml-chrome
CLOSURE=$(shell command -v closure-compiler >/dev/null 2>&1 && echo 'closure-compiler' || command -v closure >/dev/null 2>&1 && echo 'closure' || echo 'No closure compiler found'; exit 1)

all: dev

release: dev

	echo "Optimizing with ${CLOSURE} compiler"
	for file in "${NAME}" "inject" "options"; do \
		$(CLOSURE) --js $(RELEASE_DIR)/$$file.js --js_output_file $(RELEASE_DIR)/$$file.compiled.js --compilation_level SIMPLE_OPTIMIZATIONS ; \
		mv $(RELEASE_DIR)/$$file.compiled.js $(RELEASE_DIR)/$$file.js ; \
	done

	echo "Cleaning old version"
	rm -f $(RELEASE_DIR)/${NAME}.zip

	echo "Compressing extension"
	cd $(RELEASE_DIR) ; \
	zip ${NAME}.zip manifest.json icon.png icon_enabled.png 48.png 128.png options.html mathml-chrome.js inject.js options.js


dev:
	echo "Compiling coffee script"
	(cat lib.coffee; echo;cat cached_storage.coffee; echo; cat ${NAME}.coffee) | coffee --compile --stdio > $(RELEASE_DIR)/${NAME}.js
	for file in "inject" "options"; do \
		cat $$file.coffee | coffee --compile --stdio > $(RELEASE_DIR)/$$file.js; \
	done
