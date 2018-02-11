<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/Items">
        <xsl:element name="Items">
            <xsl:for-each select="Item">
                <xsl:call-template name="UpdateQualityItem">
                    <xsl:with-param name="Item" select="self::node()"/>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <xsl:template name="UpdateQualityItem">
        <xsl:param name="Item"/>
        <xsl:variable name="Quality">
            <xsl:value-of select="$Item/@quality"/>
        </xsl:variable>
        <xsl:variable name="SellIn">
            <xsl:value-of select="$Item/@sell_in"/>
        </xsl:variable>
        <xsl:variable name="Name">
            <xsl:value-of select="$Item/@name"/>
        </xsl:variable>
        <xsl:variable name="NewQuality">
            <xsl:choose>
                <xsl:when test="$Name != 'Aged Brie' and $Name != 'Backstage passes to a TAFKAL80ETC concert'">
                    <xsl:choose>
                        <xsl:when test="$Quality &gt; 0">
                            <xsl:choose>
                                <xsl:when test="$Name != 'Sulfuras, Hand of Ragnaros'">
                                    <xsl:value-of select="$Quality - 1"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$Quality"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$Quality"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$Quality &lt; 50">
                    <xsl:variable name="QualityMod">
                        <xsl:choose>
                            <xsl:when test="$Name = 'Backstage passes to a TAFKAL80ETC concert'">
                                <xsl:choose>
                                    <xsl:when test="$SellIn &lt; 11">
                                        <xsl:choose>
                                            <xsl:when test="$Quality &lt; 49">
                                                <xsl:variable name="Mod2">
                                                    <xsl:choose>
                                                        <xsl:when test="$SellIn &lt; 6">
                                                            <xsl:choose>
                                                                <xsl:when test="$Quality &lt; 48">1</xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:value-of select="0"/>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="0"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:variable>
                                                <xsl:value-of select="$Mod2 + 1"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="0"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="0"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="0"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:value-of select="$Quality + 1 + $QualityMod"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$Quality"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="NewSellIn">
            <xsl:choose>
                <xsl:when test="$Name != 'Sulfuras, Hand of Ragnaros'">
                    <xsl:value-of select="$SellIn - 1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$SellIn"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$NewSellIn &lt; 0">
                <xsl:choose>
                    <xsl:when test="$Name != 'Aged Brie'">
                        <xsl:choose>
                            <xsl:when test="$Name != 'Backstage passes to a TAFKAL80ETC concert'">
                                <xsl:choose>
                                    <xsl:when test="$NewQuality &gt; 0">
                                        <xsl:choose>
                                            <xsl:when test="$Name != 'Sulfuras, Hand of Ragnaros'">
                                                <xsl:element name="Item">
                                                    <xsl:attribute name="name">
                                                        <xsl:value-of select="$Name"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="sell_in">
                                                        <xsl:value-of select="$NewSellIn"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="quality">
                                                        <xsl:value-of select="$NewQuality - 1"/>
                                                    </xsl:attribute>
                                                </xsl:element>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:element name="Item">
                                                    <xsl:attribute name="name">
                                                        <xsl:value-of select="$Name"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="sell_in">
                                                        <xsl:value-of select="$NewSellIn"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="quality">
                                                        <xsl:value-of select="$NewQuality"/>
                                                    </xsl:attribute>
                                                </xsl:element>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="Item">
                                            <xsl:attribute name="name">
                                                <xsl:value-of select="$Name"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="sell_in">
                                                <xsl:value-of select="$NewSellIn"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="quality">
                                                <xsl:value-of select="$NewQuality"/>
                                            </xsl:attribute>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="Item">
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="$Name"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="sell_in">
                                        <xsl:value-of select="$NewSellIn"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="quality">
                                        <xsl:value-of select="$NewQuality - $NewQuality"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$NewQuality &lt; 50">
                                <xsl:element name="Item">
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="$Name"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="sell_in">
                                        <xsl:value-of select="$NewSellIn"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="quality">
                                        <xsl:value-of select="$NewQuality + 1"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="Item">
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="$Name"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="sell_in">
                                        <xsl:value-of select="$NewSellIn"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="quality">
                                        <xsl:value-of select="$NewQuality"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="Item">
                    <xsl:attribute name="name">
                        <xsl:value-of select="$Name"/>
                    </xsl:attribute>
                    <xsl:attribute name="sell_in">
                        <xsl:value-of select="$NewSellIn"/>
                    </xsl:attribute>
                    <xsl:attribute name="quality">
                        <xsl:value-of select="$NewQuality"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
