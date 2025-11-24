<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cm="http://commonmark.org/xml/1.0"
                version="1.0">

<xsl:output method="text" encoding="UTF-8" />

<xsl:include href="header.xsl"/>

<xsl:template match="/cm:document">
<xsl:text>// This is a computer-generated file. Do not edit.

</xsl:text>

<xsl:call-template name="header-template"/>

<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cm:heading[@level=1]">
    <xsl:text>= </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;&#10;</xsl:text>
</xsl:template>

<xsl:template match="cm:heading[@level=2]">
    <xsl:text>== </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;&#10;</xsl:text>
</xsl:template>

<xsl:template match="cm:paragraph">
    <xsl:apply-templates/>
    <xsl:text>&#10;&#10;</xsl:text>
</xsl:template>

<xsl:template match="cm:emph">
    <xsl:text>_</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>_</xsl:text>
</xsl:template>

<xsl:template match="cm:text">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="cm:softbreak">
    <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="cm:code_block">
    <xsl:text>```&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>```&#10;</xsl:text>
</xsl:template>

<!-- Vacuum up all inter-tag whitespace -->
<xsl:template match="text()[parent::cm:document or
    parent::cm:heading or
    parent::cm:paragraph or
    parent::cm:strong or
    parent::cm:emph]"/>

</xsl:stylesheet>
