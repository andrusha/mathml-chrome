# Makefile for GNU make

RELEASE_DIR = ./release
NAME = mathml-chrome

all: dev

release: dev
	#echo "Optimizing with Closure compiler"
	#closure --js $(RELEASE_DIR)/tumblr_shortcuts.js --js_output_file $(RELEASE_DIR)/tumblr_shortcuts.compiled.js --compilation_level SIMPLE_OPTIMIZATIONS
	#mv $(RELEASE_DIR)/tumblr_shortcuts.compiled.js $(RELEASE_DIR)/tumblr_shortcuts.js

	echo "Cleaning old version"
	rm -f $(RELEASE_DIR)/${NAME}.zip

	echo "Compressing extension"
	cd $(RELEASE_DIR) ; \
	zip ${NAME}.zip manifest.json icon.png 48.png 128.png popup.html


dev:
	echo "Compiling HAML"
	haml popup.haml ${RELEASE_DIR}/popup.html

	#echo "Compiling coffee script"
	#coffee --compile --lint --join $(RELEASE_DIR)/tumblr_shortcuts.js lib.coffee shortcuts.coffee tumblr.coffee help.coffee tumblr_shortcuts.coffee 
