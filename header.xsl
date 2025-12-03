<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:template name="header-template">
<!-- 5x8 trade paperback -->
<!--
<xsl:text>#set page(
  width: 5in,
  height: 8in,
  margin: (x: 0.5in, y: 0.5in),
)

#set text(
  font: "Liberation Serif",
  size: 12pt,
)

#show raw.where(block: true): set text(
  font: "Liberation Mono",
  size: 8pt,
)

#set list(
  indent: 1em,
)

#set par(
  justify: true,
  first-line-indent: 1.5em,
  leading: 0.65em,
  spacing: 0.65em,
)

// fix for indenting first paragraphs
// https://forum.typst.app/t/how-to-have-first-line-indent-in-a-new-paragraph-after-a-math-block/1985/2

#set document(
  title: "Working Title",
  author: "Brian \"Beej\" Hall",
)

</xsl:text>
-->

<xsl:text>#set page(
  width: 8.5in,
  height: 11in,
  margin: (x: 1in, y: 1in),
</xsl:text>
<xsl:if test="$page_numbers='1'">
    <xsl:text>numbering: "1",)</xsl:text>
</xsl:if>
<xsl:if test="$page_numbers='2'">
    <xsl:text>numbering: "1 / 1",)</xsl:text>
</xsl:if>
<xsl:text>
)
</xsl:text>

</xsl:template>

</xsl:stylesheet>
