<?xml version="1.0" encoding="UTF-8"?>
<sch:schema queryBinding="xslt2" xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

	<sch:ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
	<sch:let name="rendValues"
		value="'antiqua|lineale|fraktur|egypt|gotisch|kanzlei|bold|italic|straight|widespace|superscript|subscript|larger|smaller|underlined'"/>
	<sch:let name="rendRegEx" value="concat('^(', $rendValues, ')(\s*(', $rendValues, ')){0,5}$')"/>

	<sch:pattern id="hi">
		<sch:rule context="tei:hi">
			<sch:assert test="@rend">hi/@rend nicht gesetzt</sch:assert>
		</sch:rule>
		<sch:rule context="tei:hi/@rend">
			<sch:assert test="matches(., $rendRegEx)">hi/@rend ungültig, möglich sind: <sch:value-of
					select="$rendValues"/></sch:assert>
		</sch:rule>
	</sch:pattern>

	<sch:pattern id="note">
		<sch:rule context="tei:p//tei:note">
			<sch:assert test="@type">note/@type nicht gesetzt</sch:assert>
			<sch:assert test="@resp">note/@resp nicht gesetzt</sch:assert>
		</sch:rule>
		<sch:rule context="tei:p//tei:note/@resp">
			<sch:assert test=". = ('tr')">note/@resp ungültig</sch:assert>
		</sch:rule>
		<sch:rule context="tei:p//tei:note/@type">
			<sch:assert
				test=". = ('literatureLink', 'bibleLink', 'glossaryLink', 'textLink', 'musicLink', 'quoteLink', 'eventCommentary', 'commentary', 'translation')"
				>note/@type ungültig</sch:assert>
		</sch:rule>
	</sch:pattern>

	<!-- lists -->

	<sch:pattern id="listOrgItem">
		<sch:rule context="tei:listOrg/tei:org">
			<sch:assert role="warning" test="tei:name">kein Name vergeben</sch:assert>
			<sch:assert role="warning" test="tei:name[@type = 'index']">kein Indexname
				vergeben</sch:assert>
		</sch:rule>
	</sch:pattern>

	<sch:pattern id="listBiblItem">
		<sch:rule context="tei:listBibl[@type = 'listPeriodicals']/tei:bibl">
			<sch:assert role="warning" test="tei:name">kein Name vergeben</sch:assert>
			<sch:assert role="warning" test="tei:name[@type = 'index']">kein Indexname
				vergeben</sch:assert>
			<!--<sch:assert role="warning" test="tei:note[@type = 'frequency']">Frequenz nicht
				angegeben</sch:assert>-->
			<!--<sch:assert role="warning" test="tei:note[@type = 'pagination']">Paginierung nicht
				angegeben</sch:assert>-->
		</sch:rule>
	</sch:pattern>

</sch:schema>
