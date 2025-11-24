NAME=test
XSLT=xmltyp.xsl

.PHONY: all clean pristine

all: $(NAME).pdf

$(NAME).xml: $(NAME).md
	cmark-gfm -e table -e strikethrough -t xml $^ > $@

$(NAME).typ: $(NAME).xml
	xsltproc --novalid -o $@ $(XSLT) $^

$(NAME).pdf: $(NAME).typ
	typst compile $^

clean:
	rm -f $(NAME).xml $(NAME).typ

pristine: clean
	rm -f $(NAME).pdf

