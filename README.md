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

## Embedded Typst

To a certain extent, you can embed raw Typst into the Markdown since
it's generally ignored by `cmark`.

## Checklist
<!-- ✔️⏳❌ -->

|Task          |State|Notes                                         |
|---------------|:-:|-----------------------------------------------|
|Headers        | ✔️ |                                               |
|Italics        | ✔️ |                                               |
|Bold           | ✔️ |                                               |
|Bold Italics   | ✔️ |                                               |
|Code           | ✔️ |                                               |
|Code Block     | ✔️ |                                               |
|Line break     | ✔️ |                                               |
|Ordered Lists  | ❌ |                                               |
|Unordered Lists| ❌ |                                               |
|Line break     | ❌ |                                               |
|Tables         | ❌ |                                               |
|Footnotes      | ❌ |XML output from `cmark` is broken for footnotes|

## Pandoc does this, you know...

Yes, but via LaTeX and it's a lot slower. This is an experiment for
funzies.

