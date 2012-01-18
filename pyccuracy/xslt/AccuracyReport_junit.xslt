<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" version="1.0" encoding="iso-8859-1" indent="yes" />


  <xsl:template match="/">
	<xsl:element name="testsuites">
		<xsl:apply-templates select="/report/stories" />
	</xsl:element>  
</xsl:template>



  <xsl:template match="/report/stories">
            <xsl:apply-templates select="story" />
  </xsl:template>

  <xsl:template match="/report/stories/story">
	<xsl:element name="testsuite">
		<xsl:attribute name="name">[<xsl:value-of select ="@browser" />] Scenario <xsl:value-of select ="@index"/>: <xsl:value-of select ="@identity"/></xsl:attribute>
		<xsl:attribute name="tests"><xsl:value-of select ="@totalStories" /></xsl:attribute>
		<xsl:attribute name="errors">0</xsl:attribute>
		<xsl:attribute name="failures"><xsl:value-of select ="@failedScenarios" /></xsl:attribute>
		<xsl:attribute name="skip">0</xsl:attribute>
		
		<xsl:apply-templates select="scenario" />
	</xsl:element>
  </xsl:template>

  <xsl:template match="/report/stories/story/scenario">
	<xsl:element name="testcase">
		
		<xsl:attribute name="classname">[<xsl:value-of select ="@browser" />] <xsl:value-of select ="@identity"/><xsl:value-of select ="@description"/>
		</xsl:attribute>
		
		<xsl:attribute name="name">[<xsl:value-of select ="@browser" />] <xsl:value-of select ="@description"/></xsl:attribute>
		<xsl:attribute name="time">0.00</xsl:attribute>
		
		<xsl:if test ="@isSuccessful='false'">
			<xsl:element name="failure" >
				<xsl:attribute name="type">error</xsl:attribute>
				
				<xsl:attribute name="message">
					<xsl:value-of select ="@identity"/>
					<xsl:apply-templates select="action" />
				</xsl:attribute>
			</xsl:element>
		</xsl:if>
		<!--
		<xsl:element name="stacktrace">
			<xsl:value-of select ="@identity"/>
			<xsl:apply-templates select="action" />
		</xsl:element>
		-->
	</xsl:element>    
  </xsl:template>

  <xsl:template match="/report/stories/story/scenario/action">
		<br />
		      <xsl:value-of select ="@asA"/>
		      <br />
		      <xsl:value-of select ="@iWant"/>
		      <br />
		      <xsl:value-of select ="@soThat"/>
	
    <tr>
      <xsl:attribute name="class"><xsl:value-of select="@oddOrEven"/></xsl:attribute>
      <td>
        <xsl:attribute name="class"><xsl:value-of select="@type"/></xsl:attribute>
        <xsl:if test ="@type='action' and @index>1">
          <b>
            and
          </b>
        </xsl:if>
        <xsl:if test ="@type='condition'">
          <b>
            <xsl:value-of select ="@description"/>
          </b>
        </xsl:if>
        <xsl:if test ="@type='action'">
            <xsl:if test ="@status='FAILED'">
                <b>
                    <font color="red">
                        <xsl:value-of select ="@description"/>
                    </font>
                </b>
            </xsl:if>
            <xsl:if test ="@status='SUCCESSFUL'">
                <b>
                    <xsl:value-of select ="@description"/>
                </b>
            </xsl:if>
            <xsl:if test ="@status='UNKNOWN'">
                <b>
                    <font color="#555555">
                        <xsl:value-of select ="@description"/>
                    </font>
                </b>
            </xsl:if>
        </xsl:if>
      </td>
      <td>
        <xsl:if test ="@type='action'">
          <xsl:attribute name="class">actionTime</xsl:attribute>
          [<xsl:value-of select ="@actionTime"/>]
        </xsl:if>
        <xsl:if test ="@type='condition'">
          &#160;
        </xsl:if>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="/report/summary">
    
  </xsl:template>

  <xsl:template match="/report/header">
    
  </xsl:template>
  
  <xsl:template match="/report/footer">
    <![CDATA[<!--]]>
        Pyccuracy - Version <xsl:value-of select ="@version"/> - <a href="http://www.pyccuracy.org">http://www.pyccuracy.org</a>
      <![CDATA[-->]]>
  </xsl:template>
</xsl:stylesheet>
