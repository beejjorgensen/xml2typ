NAME=test
XSLT=xml2typ.xsl
XSLT_PARAMS=--stringparam page_numbers 2 --stringparam table_header_align yes --stringparam table_header_bold yes
CMARK_PARAMS=-e table -e strikethrough -e autolink

.PHONY: all clean pristine

all: $(NAME).pdf

$(NAME).xml: $(NAME).md
	cmark-gfm $(CMARK_PARAMS) -t xml $^ > $@

$(NAME).typ: $(NAME).xml
	xsltproc --novalid $(XSLT_PARAMS) -o $@ $(XSLT) $^

$(NAME).pdf: $(NAME).typ
	typst compile $^

quick.pdf: $(NAME).md
	cmark-gfm $(CMARK_PARAMS) -t xml $^ | \
		xsltproc --novalid $(XSLT_PARAMS) $(XSLT) - | \
		typst compile - $@

clean:
	rm -f $(NAME).xml $(NAME).typ

pristine: clean
	rm -f $(NAME).pdf quick.pdf

