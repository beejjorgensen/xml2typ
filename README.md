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

## Checklist

|Task          |State|Notes                                         |
|---------------|:-:|-----------------------------------------------|
|Header         | ✔️ |                                               |
|Italics        | ✔️ |                                               |
|Bold           | ✔️ |                                               |
|Code           | ✔️ |                                               |
|Code Block     | ⏳ |No syntax highlighting                         |
|Bold Italics   | ❌ |                                               |
|Ordered Lists  | ❌ |                                               |
|Unordered Lists| ❌ |                                               |
|Tables         | ❌ |                                               |
|Footnotes      | ❌ |XML output from `cmark` is broken for footnotes|

## Pandoc does this

Yes, but via LaTeX and it's a lot slower. This is an experiment.

