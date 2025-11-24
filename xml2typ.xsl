<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cm="http://commonmark.org/xml/1.0"
                version="1.0">

<xsl:output method="text" encoding="UTF-8" />

<!-- Repeat a character a number of times -->
<xsl:template name="repchar">
    <xsl:param name="char"/>
    <xsl:param name="count"/>
    <xsl:if test="$count &gt; 0">
        <xsl:value-of select="$char"/>
        <xsl:call-template name="repchar">
            <xsl:with-param name="char" select="$char"/>
            <xsl:with-param name="count" select="$count - 1"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:include href="header.xsl"/>

<xsl:template match="/cm:document">
<xsl:text>// This is a computer-generated file. Do not edit.

</xsl:text>

<xsl:call-template name="header-template"/>

<xsl:apply-templates/>
</xsl:template>

<xsl:template match="cm:heading">
    <xsl:call-template name="repchar">
        <xsl:with-param name="char" select="'='"/>
        <xsl:with-param name="count" select="@level"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
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

<xsl:template match="cm:strong">
    <xsl:text>*</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>*</xsl:text>
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
