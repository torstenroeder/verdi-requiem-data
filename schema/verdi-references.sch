<?xml version="1.0" encoding="UTF-8"?>
<sch:schema queryBinding="xslt2" xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

	<sch:ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>

	<sch:let name="listBibl" value="document('../teiList/listBibl.xml')"/>
	<sch:let name="listEvent" value="document('../teiList/listEvent.xml')"/>
	<sch:let name="listMusic" value="document('../teiList/listMusic.xml')"/>
	<sch:let name="listOrg" value="document('../teiList/listOrg.xml')"/>
	<sch:let name="listPerson" value="document('../teiList/listPerson.xml')"/>
	<sch:let name="listPlace" value="document('../teiList/listPlace.xml')"/>
	<sch:let name="glossary" value="document('../teiList/glossary.xml')"/>

	<sch:pattern id="biblRelatedItems">
		<sch:rule context="tei:bibl//tei:relatedItem">
			<sch:assert test="@target">Bezug nicht explizit gesetzt</sch:assert>
			<sch:assert test="id(substring(@target, 2))">Eintrag '<sch:value-of select="@target"/>'
				nicht gefunden</sch:assert>
		</sch:rule>
	</sch:pattern>

	<sch:pattern id="eventKey">
		<sch:rule context="tei:rs[@type = 'event']">
			<sch:assert test="$listEvent//id(current()/@key)">Aufführung '<sch:value-of
					select="@key"/>' nicht gefunden</sch:assert>
		</sch:rule>
	</sch:pattern>

	<sch:pattern id="musicKey">
		<sch:rule context="tei:text//tei:title[@type = 'mus'][@key][@n]">
			<sch:assert test="$listMusic//id(current()/@key)//tei:span[@n = current()/@n]">Stelle
					'<sch:value-of select="@n"/>' im Musikwerk '<sch:value-of select="@key"/>' nicht
				gefunden</sch:assert>
		</sch:rule>
		<sch:rule context="tei:text//tei:title[@type = 'mus'][@key]">
			<sch:assert test="$listMusic//id(current()/@key)">Musikwerk '<sch:value-of select="@key"
				/>' nicht gefunden</sch:assert>
		</sch:rule>
	</sch:pattern>

	<sch:pattern id="orgKey">
		<sch:rule context="tei:orgName[not(parent::tei:org)]">
			<sch:assert test="$listOrg//id(current()/@key) or $listBibl//id(current()/@key)"
				>Körperschaft '<sch:value-of select="@key"/>' nicht gefunden</sch:assert>
		</sch:rule>
	</sch:pattern>

	<sch:pattern id="persKey">
		<sch:rule context="tei:persName[not(parent::tei:person)]">
			<sch:assert test="$listPerson//id(current()/@key)">Person '<sch:value-of select="@key"
				/>' nicht gefunden</sch:assert>
		</sch:rule>
	</sch:pattern>

	<sch:pattern id="placeKey">
		<sch:rule context="tei:placeName[not(parent::tei:place)]">
			<sch:assert test="$listPlace//id(current()/@key)">Ort '<sch:value-of select="@key"/>'
				nicht gefunden</sch:assert>
		</sch:rule>
	</sch:pattern>

	<sch:pattern id="termKey">
		<sch:rule context="tei:term[@key]">
			<sch:assert test="$glossary//id(current()/@key)">Glossareintrag '<sch:value-of
					select="@key"/>' nicht gefunden</sch:assert>
		</sch:rule>
	</sch:pattern>

</sch:schema>
