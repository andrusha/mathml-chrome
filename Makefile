# Makefile for GNU make

RELEASE_DIR = ./release
NAME = mathml-chrome

all: dev

release: dev
	echo "Optimizing with Closure compiler"
	for file in "${NAME}" "inject"; do \
		closure --js $(RELEASE_DIR)/$$file.js --js_output_file $(RELEASE_DIR)/$$file.compiled.js --compilation_level SIMPLE_OPTIMIZATIONS ; \
		mv $(RELEASE_DIR)/$$file.compiled.js $(RELEASE_DIR)/$$file.js ; \
	done

	echo "Cleaning old version"
	rm -f $(RELEASE_DIR)/${NAME}.zip

	echo "Compressing extension"
	cd $(RELEASE_DIR) ; \
	zip ${NAME}.zip manifest.json icon.png icon_enabled.png 48.png 128.png background.html mathml-chrome.js inject.js


dev:
	echo "Compiling HAML"
	for file in "background"; do \
		haml $$file.haml ${RELEASE_DIR}/$$file.html; \
	done

	echo "Compiling coffee script"
	coffee --compile --lint --join $(RELEASE_DIR)/${NAME}.js lib.coffee cached_storage.coffee ${NAME}.coffee
	coffee --compile --lint --join $(RELEASE_DIR)/inject.js inject.coffee
