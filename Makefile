# Makefile for GNU make

RELEASE_DIR = ./release
NAME = mathml-chrome

all: dev

release: dev
	echo "Optimizing with Closure compiler"
	for file in "${NAME}" "inject" "options"; do \
		closure --js $(RELEASE_DIR)/$$file.js --js_output_file $(RELEASE_DIR)/$$file.compiled.js --compilation_level SIMPLE_OPTIMIZATIONS ; \
		mv $(RELEASE_DIR)/$$file.compiled.js $(RELEASE_DIR)/$$file.js ; \
	done

	echo "Cleaning old version"
	rm -f $(RELEASE_DIR)/${NAME}.zip

	echo "Compressing extension"
	cd $(RELEASE_DIR) ; \
	zip ${NAME}.zip manifest.json icon.png icon_enabled.png 48.png 128.png background.html options.html mathml-chrome.js inject.js options.js


dev:
	echo "Compiling HAML"
	for file in "background" "options"; do \
		haml $$file.haml ${RELEASE_DIR}/$$file.html; \
	done

	echo "Compiling coffee script"
	coffee --compile --lint --join $(RELEASE_DIR)/${NAME}.js lib.coffee cached_storage.coffee ${NAME}.coffee
	for file in "inject" "options"; do \
		coffee --compile --lint --join $(RELEASE_DIR)/$$file.js $$file.coffee; \
	done
