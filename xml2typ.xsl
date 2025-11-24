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
    <xsl:text>#par[</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>]</xsl:text>
    <xsl:text>&#10;</xsl:text>
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

<xsl:template match="cm:linebreak">
    <xsl:text>\&#10;</xsl:text>
</xsl:template>

<xsl:template match="cm:code">
    <xsl:text>`</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>`</xsl:text>
</xsl:template>

<xsl:template match="cm:code_block">
    <xsl:text>```</xsl:text>
    <xsl:value-of select="@info"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>```&#10;</xsl:text>
</xsl:template>

<xsl:template match="cm:list">
    <xsl:choose>
        <xsl:when test="@type='ordered'">
            <xsl:call-template name="ordered-list"/>
        </xsl:when>
        <xsl:when test="@type='bullet'">
            <xsl:call-template name="bullet-list"/>
        </xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template name="ordered-list">
    <xsl:text>#enum(tight:</xsl:text>
    <xsl:value-of select="@tight"/>
    <xsl:text>,&#10;</xsl:text>
        
    <xsl:variable name="start" select="@start"/>
    <xsl:for-each select="cm:item">
        <xsl:text>  enum.item(</xsl:text>
        <xsl:value-of select="position() + $start - 1"/>
        <xsl:text>)[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>],&#10;</xsl:text>
    </xsl:for-each>
    <xsl:text>)&#10;</xsl:text>
</xsl:template>

<xsl:template name="bullet-list">
    <xsl:text>#list(tight:</xsl:text>
    <xsl:value-of select="@tight"/>
    <xsl:text>,&#10;</xsl:text>
        
    <xsl:for-each select="cm:item">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>],&#10;</xsl:text>
    </xsl:for-each>
    <xsl:text>)&#10;</xsl:text>
</xsl:template>

<xsl:template match="cm:table">
    <xsl:text>#table(columns:</xsl:text>
    <xsl:value-of select="count(cm:table_header/cm:table_cell)"/>
    <xsl:text>,&#10;</xsl:text>
        <xsl:apply-templates/>
    <xsl:text>)&#10;</xsl:text>
</xsl:template>

<xsl:template match="cm:table_header">
    <xsl:text>table.header(</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>),&#10;</xsl:text>
</xsl:template>

<xsl:template match="cm:table_row">
    <xsl:apply-templates/>
    <xsl:text>&#10;</xsl:text>
</xsl:template>

<xsl:template match="cm:table_header/cm:table_cell">
    <xsl:text>[</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>],</xsl:text>
</xsl:template>

<xsl:template match="cm:table_row/cm:table_cell">
    <xsl:variable name="pos" select="count(preceding-sibling::cm:table_cell) + 1"/>
    <xsl:variable name="headerCell" select="../../cm:table_header/cm:table_cell[$pos]"/>
    <xsl:variable name="align" select="string($headerCell/@align)"/>
    <xsl:variable name="effectiveAlign">
        <xsl:choose>
            <xsl:when test="$align"><xsl:value-of select="$align"/></xsl:when>
            <xsl:otherwise>left</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:text>table.cell(align:</xsl:text>
    <xsl:value-of select="$effectiveAlign"/>
    <xsl:text>)[</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>],</xsl:text>
</xsl:template>

<!-- Vacuum up all inter-tag whitespace -->
<xsl:template match="text()[parent::cm:document or
    parent::cm:heading or
    parent::cm:paragraph or
    parent::cm:table or
    parent::cm:table_header or
    parent::cm:table_row or
    parent::cm:table_cell or
    parent::cm:strong or
    parent::cm:emph or
    parent::cm:item]"/>

</xsl:stylesheet>
