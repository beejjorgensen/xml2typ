# Markdown to PDF

This is an experiment to see about quickly rendering Markdown to PDF
with `cmark-gfm`, `xsltproc`, and `typst`.

## Usage

The process is:

```
         ┌─────────┐             ┌────────┐             ┌─────┐
foo.md → │cmark-gfm│ → foo.xml → │xsltproc│ → foo.typ → │typst│ → foo.pdf
         └─────────┘             └────────┘             └─────┘
```

There's a `Makefile` that builds the test document.

The main stylesheet, `xmltyp.xsl`, loads in a header template from
`header.xsl`. You can put all your custom Typst stuff in there, `set`,
`show`, etc.;

Right now the `Makefile` builds each intermediate product in turn, but
you could pipeline it for more speed. See the `quick.pdf` target for a
demo.

## Installation

There is no install script. It's up to you where to drop these things.

Dependencies:

* `cmark-gfm` (or the lesser `cmark`—just change the `Makefile`)
* `xsltproc`
* `typst`

## XSLT Parameters

You can control the behavior or the stylesheet by passing the following
`--stringparam` arguments to `xsltproc`:

```
# Align the headers as specified by the Markdown table cells:
--stringparam table_header_align yes

# Make table headers bold:
--stringparam table_header_bold yes
```

## Features
<!-- ✔️⏳❌ -->

|Feature       |State|Notes                                          |
|---------------|:-:|------------------------------------------------|
|Headers        | ✔️ |                                                |
|Italics        | ✔️ |                                                |
|Bold           | ✔️ |                                                |
|Bold Italics   | ✔️ |                                                |
|Code           | ✔️ |                                                |
|Code Block     | ✔️ |With syntax highlighting                        |
|Line break     | ✔️ |                                                |
|Ordered Lists  | ✔️ |                                                |
|Unordered Lists| ✔️ |                                                |
|Tables         | ✔️ |Parameters to control header format             |
|Links          | ✔️ |URL only; XML missing internal link destinations|
|Block quotes   | ✔️ |                                                |
|Horizontal rule| ✔️ |                                                |
|Strike-through | ✔️ |                                                |
|Images         | ✔️ |                                                |
|Footnotes      | ❌ |XML is broken for footnotes                     |

## Pandoc does this, you know...

Yes, but via LaTeX and it's a lot slower. This is an experiment for
funzies.

For a taste, my 2017 MacBook Pro (Linux) builds the test page in around
120 milliseconds:

```
% time make quick.pdf
cmark-gfm -e table -e strikethrough -t xml test.md | \
	xsltproc --novalid xml2typ.xsl - | \
	typst compile - quick.pdf
make quick.pdf  0.09s user 0.03s system 107% cpu 0.112 total
```
