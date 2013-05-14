SHELL=/bin/sh

THEME_DIR:=css/theme
JS_DIR:=js
FONT_DIR:=fonts
TEST_DIR:=test

REVEAL_DIR:=reveal.js
REVEAL_TEMPLATES_DIR:=$(REVEAL_DIR)/$(THEME_DIR)/template

DEPLOYMENT_DIR:=$(HOME)/Sites/reveal_test

REVEAL_IMPORTS:=$(REVEAL_TEMPLATES_DIR)/mixins.scss $(REVEAL_TEMPLATES_DIR)/settings.scss  $(REVEAL_TEMPLATES_DIR)/theme.scss
FONT_IMPORTS:=$(FONT_DIR)/Roboto/stylesheet.css $(FONT_DIR)/Roboto_Condensed/stylesheet.css

THEMES:=$(THEME_DIR)/otago.css
JS:=$(JS_DIR)/position-images.min.js $(JS_DIR)/jquery-1.9.1.min.js



test: themes js
	mkdir -p $(DEPLOYMENT_DIR)
	cp -pRf $(FONT_DIR) $(DEPLOYMENT_DIR)
	cp -pRf $(REVEAL_DIR)/* $(DEPLOYMENT_DIR)
	cp -pRf $(TEST_DIR)/* $(DEPLOYMENT_DIR)
	cp -pRf $(THEME_DIR)/*.css $(DEPLOYMENT_DIR)/$(THEME_DIR)
	cp -pRf $(JS_DIR)/*.js $(DEPLOYMENT_DIR)/$(JS_DIR)


release: themes js
	echo "TODO!"


js: $(JS)

$(JS_DIR)/%.min.js: $(JS_DIR)/%.js
	uglifyjs $< --mangle --output $@

themes: $(THEMES)

$(THEME_DIR)/%.css: $(THEME_DIR)/%.scss $(REVEAL_IMPORTS) $(FONT_IMPORTS)
	sass $< $@
