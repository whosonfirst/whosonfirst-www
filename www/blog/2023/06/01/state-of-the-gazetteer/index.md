---
layout: page
title: State of the WOF Gazetteer in 2023
published: true
date: 2023-06-01
permalink: /blog/2023/06/01/state-of-the-wof-gazetteer-2023/
category: blog
excerpt: "Short summary"
authors: [nvkelso]
image: "images/1527852859_LFfdzGSIqfJVdMVgBsyYITpcVkFXswn7_b.jpg)"
tag: [whosonfirst,wof]
---
[![](images/1527852859_LFfdzGSIqfJVdMVgBsyYITpcVkFXswn7_b.jpg)](https://collection.sfomuseum.org/objects/1511941919/#1527852859)

<div style="font-size:small;font-style:italic;text-align:center;">
Catalog: John S. Cox & Son, aeronautical supplies c. 1934. Purchase. <a href="https://collection.sfomuseum.org/objects/1511941919">Collection of SFO Museum</a>. 2002.064.041 a e
</div>


<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 0; WARNINGs: 0; ALERTS: 23.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>
<a href="#gdcalert2">alert2</a>
<a href="#gdcalert3">alert3</a>
<a href="#gdcalert4">alert4</a>
<a href="#gdcalert5">alert5</a>
<a href="#gdcalert6">alert6</a>
<a href="#gdcalert7">alert7</a>
<a href="#gdcalert8">alert8</a>
<a href="#gdcalert9">alert9</a>
<a href="#gdcalert10">alert10</a>
<a href="#gdcalert11">alert11</a>
<a href="#gdcalert12">alert12</a>
<a href="#gdcalert13">alert13</a>
<a href="#gdcalert14">alert14</a>
<a href="#gdcalert15">alert15</a>
<a href="#gdcalert16">alert16</a>
<a href="#gdcalert17">alert17</a>
<a href="#gdcalert18">alert18</a>
<a href="#gdcalert19">alert19</a>
<a href="#gdcalert20">alert20</a>
<a href="#gdcalert21">alert21</a>
<a href="#gdcalert22">alert22</a>
<a href="#gdcalert23">alert23</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>


## State of the Gazetteer in 2023

The Who’s On First (WOF) gazetteer is a big list of places, each with a stable identifier, and a set of common and optional descriptive properties about that location. Like any product, Who’s On First is made by people, and we’ve collectively spent about “20 years” building WOF as an original work and as an aggregation of many other open data projects.

Since we [launched](https://whosonfirst.org/blog/2015/08/18/who-s-on-first/) in 2015, the project has grown in coverage, complexity, and supported applications. In this this post I will summarize Who’s On First’s key advantages, offer a comparative analysis of WOF and other open gazetteers, quantify our global coverage by [placetype](https://github.com/whosonfirst/whosonfirst-placetypes), offer score cards by country, dive into name localization, look at internationalization through the lens of disputed territories, and quantify geometry types and sources of those polygon and points, hold hands with and thank our [sources](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md), and invite collaboration.

WOF gazetteer’s focus on [localities](https://en.wikipedia.org/wiki/Human_settlement) and unique identifiers sets us apart from many other projects. We choose to approach geography at a personal level – starting with the `**locality`** (or populated place) where people play, study, work, and sleep – and `**countries`** for when people need a passport to cross a frontier and experience something new and exciting.

Between those “top” and “bottom” placetypes in the administrative hierarchy, countries choose to order their geography in many varied and nested subdivisions. Who’s On First doesn’t judge, but we do align them into common “region” (1st order subdivisions, tracked by the ISO), “county” (2nd order subdivisions), and “localadmin” (municipalities) placetypes. Most localities aren’t legally incorporated, and may or may not be coincidental with a parent localadmin. Many urban localities are further subdivided into boroughs and neighbourhoods. There are even more optional [placetypes](https://github.com/whosonfirst/whosonfirst-placetypes) to allow for intermediate levels and other edge cases.

This common structure allows us to track all the places in the world. Or at least those places we’ve learned about thus far. We hope it provides you an easier mental model to integrate the data into your own application.

_Eager to play with the data yourself? Jump to the [downloads]() section below…_


## Who’s On First gazetteer at a glance

* A single source of truth across a minimalist common set of [placetypes](https://github.com/whosonfirst/whosonfirst-placetypes), spanning the entire globe, and supplemented as-needed on a regional level
* Global coverage for 5M (million) administrative places, including 4.5M localities
* More than 25M additional places are available, including: 3.9M postal codes, 7K (thousand) constituencies, and 21M venues
* 452K features have detailed polygons, with complete coverage at country, region, and county placetypes and exhaustive coverage for localadmin and large localities in major industrialized economies, with exhaustive coverage as point geometries for remaining features. We store 447K alternate geometries.
* Names are localized into hundreds of languages, using internet standard language codes
* Population values, min_zoom ranking, and polygon label centroids enable sophisticated map designs with beautiful and informative cartography
* Internationalized with disputed territory boundaries for global audiences and compliance with local regulations
* Includes original work and data aggregated from [360+ authoritative sources](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md). Our source data licenses have been vetted by multiple corporate attorneys at large, publicly traded companies.
* Holds hands with 60+ datasets via linked unique identifiers to allow crosswalk across 6.5M feature-level concordances.
* Open license (CC-BY attribution) means you’re free to use the data for commercial purposes, including derivative rights, as long as you credit the project and our sources
* Spelunker web app for viewing formatted data with a map  ([browse New York city record](https://spelunker.whosonfirst.org/id/85921881/))
* Write Field web editor for quick property edits  ([edit New York city record](https://writefield.nextzen.org/place/edit?url=https://raw.githubusercontent.com/whosonfirst-data/whosonfirst-data-admin-us/master/data/859/775/39/85977539.geojson)) with human review
* View raw data on Github ([view New York city example](https://github.com/whosonfirst-data/whosonfirst-data-admin-us/blob/master/data/859/218/81/85921881.geojson))
* Downloadable SQLite and Shapefile distributions from geocode.earth (thanks!)
* Collaborative project started in 2015 and remains active, including contributions from Snapchat
* The Who’s On First project is hosted by the Linux Foundation


## Comparative Analysis of Open Gazetteers

We recognize our WOF gazetteer is one of many open gazetteers, let’s look at five, including Who’s On First:

* **[Who’s On First](https://whosonfirst.org/):** Open data project with both administrative and non-administrative data like postal codes, constituencies, and venues. The CC-BY license allows commercial use. Includes polygons, fully localized names, disputed territory handling for reverse geocoding, navigation centroids, and unique IDs to capture value from metrics. The data is used in applications with over 300 million monthly active users.
* **[GeoNames](https://www.geonames.org/):** Commercial project across a range of administrative and non-administrative placetypes including postal codes and venues. Premium polygons can be licensed for a fee. Great locality coverage!
* **[geoBoundaries](https://www.geoboundaries.org/): **Academic project focused exclusively on administrative hierarchy. A complicated license that mixes in ODbL and other non-commercial data sources with CC-BY data. Names are not localized, no disputed territories, no label centroids, and no unique IDs.
* **[GADM](https://gadm.org/):** Academic project focused exclusively on administrative hierarchy. Non-commercial use license although a custom commercial license is available on request. Names include latin, variants, and local script but not in a machine readable way. No disputed territories, no label centroids, and no unique IDs.
* **[All The Places](https://www.alltheplaces.xyz/):** Open data project with CC-0 license focused exclusively on venues.

LEGEND for tables below

* ✅ Great coverage and usability
* ☑️ Basic coverage or usability
* ❌ No coverage or usability (unless noted)
* L10n = Localized names
* i18n = Internationalized features
* Links = Concordance 🔗with other gazetteer projects

#### Gazetteer data competitive analysis table

<table>
  <tr>
   <td>
   </td>
   <td>Started
   </td>
   <td>License
   </td>
   <td>Admin records
   </td>
   <td>Locality subtotal
   </td>
   <td>Other records
   </td>
   <td>Unique IDs (stable)
   </td>
   <td>L10n
   </td>
   <td>i18n
   </td>
   <td>Admin polygons
   </td>
   <td>Admin points
   </td>
   <td>Links
   </td>
  </tr>
  <tr>
   <td><a href="https://whosonfirst.org/">Who’s On First</a>
   </td>
   <td>2015
   </td>
   <td>CC-BY
   </td>
   <td>5.0M
   </td>
   <td>4.5M
   </td>
   <td>25.0M
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>☑️
   </td>
   <td>✅0.4M
   </td>
   <td>✅4.6M
   </td>
   <td>✅
   </td>
  </tr>
  <tr>
   <td><a href="https://www.geonames.org/">GeoNames</a>
   </td>
   <td>2005
   </td>
   <td>CC-BY
   </td>
   <td>5.1M
   </td>
   <td>4.6M
   </td>
   <td>5.8M
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>❌
   </td>
   <td>❌ $$$ \
💰0.5M
   </td>
   <td>✅4.6M
   </td>
   <td>✅
   </td>
  </tr>
  <tr>
   <td><a href="https://www.geoboundaries.org/">geoBoundaries</a>
   </td>
   <td>2017
   </td>
   <td>License varies, can be ODbL
   </td>
   <td>1.0M
   </td>
   <td>0.0M
   </td>
   <td>0.0M
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>✅1.0M
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
  </tr>
  <tr>
   <td><a href="https://gadm.org/">GADM</a>
   </td>
   <td>2009
   </td>
   <td>CC-BY-NC
   </td>
   <td>0.4M
   </td>
   <td>0.0M
   </td>
   <td>0.0M
   </td>
   <td>❌
   </td>
   <td>☑️
   </td>
   <td>❌
   </td>
   <td>✅0.4M
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
  </tr>
  <tr>
   <td><a href="https://www.alltheplaces.xyz/">All The Places</a>
   </td>
   <td>2017
   </td>
   <td>CC-0
   </td>
   <td>0.0M
   </td>
   <td>0.0M
   </td>
   <td>2.5M
   </td>
   <td>☑️
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>☑️
   </td>
  </tr>
  <tr>
   <td>OpenStreetMap
   </td>
   <td>2004
   </td>
   <td>ODbL
   </td>
   <td>5.9M
   </td>
   <td>5.1M
   </td>
   <td>n/a
   </td>
   <td>☑️
   </td>
   <td>✅
   </td>
   <td>❌
   </td>
   <td>✅0.8M
   </td>
   <td>✅5.1M
   </td>
   <td>☑️
   </td>
  </tr>
</table>


_NOTE: The above table represents a good faith effort to compare open gazetteer projects with nominally CC-BY and more permissive licenses in May 2023. Each project has its own motivations, use cases, and update frequencies. Major respect for everyone involved (and to [OpenStreetMap](https://www.openstreetmap.org/) and their ODbL effort)._


#### Gazetteer applications competitive analysis table


<table>
  <tr>
   <td>
   </td>
   <td>Search
   </td>
   <td>Reverse Geocoding
   </td>
   <td>Map Display
   </td>
   <td>Routing
   </td>
   <td>Metrics logging
   </td>
   <td>Venues
   </td>
   <td>Postcodes
   </td>
   <td>Constituencies
   </td>
   <td>Tooling
   </td>
  </tr>
  <tr>
   <td><a href="https://whosonfirst.org/">Who’s On First</a>
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>☑️21M
   </td>
   <td>✅3.9M
   </td>
   <td>☑️7K
   </td>
   <td>Web & CLI
   </td>
  </tr>
  <tr>
   <td><a href="https://www.geonames.org/">GeoNames</a>
   </td>
   <td>✅
   </td>
   <td>❌ $$$
   </td>
   <td>☑️
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>☑️1.1M
   </td>
   <td>✅1.5M
   </td>
   <td>❌
   </td>
   <td>API
   </td>
  </tr>
  <tr>
   <td><a href="https://www.geoboundaries.org/">geoBoundaries</a>
   </td>
   <td>☑️
   </td>
   <td>☑️
   </td>
   <td>☑️
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>Web & API
   </td>
  </tr>
  <tr>
   <td><a href="https://gadm.org/">GADM</a>
   </td>
   <td>☑️
   </td>
   <td>☑️
   </td>
   <td>☑️
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
  </tr>
  <tr>
   <td><a href="https://www.alltheplaces.xyz/">All The Places</a>
   </td>
   <td>✅
   </td>
   <td>❌
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>☑️
   </td>
   <td>✅2.5M
   </td>
   <td>❌
   </td>
   <td>❌
   </td>
   <td>Web
   </td>
  </tr>
  <tr>
   <td>OpenStreetMap
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>✅
   </td>
   <td>☑️
   </td>
   <td>☑️???
   </td>
   <td>☑️???
   </td>
   <td>❌
   </td>
   <td>Web & CLI
   </td>
  </tr>
</table>


_NOTE: geoBoundaries has a great web viewer to [compare data](https://www.geoboundaries.org/geoContrast.html?country=BHR&mainSource=geoBoundaries+%28Open%29&comparisonSource=Natural+Earth+v5.0.1&mainLevel=1&comparisonLevel=1) for countries and their subdivisions across projects – including those here in WOF and from the lower geometry precision [Natural Earth](https://www.naturalearthdata.com/)._


## Who’s On First global coverage deep dive

Who’s On First has 5M administrative places, including 4.5M localities. Detailed breakdowns by placetype, geometry type, country & etc are available farther down in the “By Geometry Type” section.


<table>
  <tr>
   <td>placetype
   </td>
   <td>count
   </td>
  </tr>
  <tr>
   <td>locality
   </td>
   <td><p style="text-align: right">
4,498,136</p>

   </td>
  </tr>
  <tr>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
233,712</p>

   </td>
  </tr>
  <tr>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
203,513</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
47,431</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
5,139</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
232</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
104</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
43</p>

   </td>
  </tr>
  <tr>
   <td>(other admin)
   </td>
   <td><p style="text-align: right">
29,934</p>

   </td>
  </tr>
  <tr>
   <td>TOTAL
   </td>
   <td><p style="text-align: right">
5,018,244</p>

   </td>
  </tr>
</table>


Additional coverage is available in the WOF gazetteer for 3.9M postal codes, 7K constituencies, and 21M venues, but they are largely excluded from the “administrative” tables below, although descriptions and coverage maps are provided.


### Coverage by placetype


#### Locality coverage

Localities form the bulk of place records in the WOF gazetteer. Of those 4.5 million records, 95% have point geometries and 5% have polygons. Distribution of our localities follows population density. See the “Scorecards” section below for a description of which countries have locality polygon coverage.



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")



#### Primary administrative hierarchy coverage

Gazetteer projects must decide how to set up 1st order administrative divisions around the world, and this decision has repercussions in calculating the depth of administrative levels in a country.

Take for example the United Kingdom of Great Britain and Northern Ireland. Are the 4 “constituent countries” of the U.K. the 1st order subdivisions or are their 334 subdivisions? Are the 101 provinces of France the 1st order subdivisions, or the 29 regions? Are the “overseas” regions and provinces of France part of the main country or different countries? What about the United Kingdom, France, and other country’s dependencies? What about Belgium and its federal system? Or the United States and it’s dependencies?

Who’s On First tracks `countries` and `dependencies` as equal top-level placetypes and group them into `empires` as appropriate. WOF chooses to represent all ISO 1st order subdivisions as “region” placetype features in a continuous fabric of global coverage. When the ISO also provides groupings of those, as reported by the country itself for administrative (versus statistical) use, we import those as an optional `macroregion` with complete in-country coverage but sparse global coverage. This situation (and others like in Belgium) impact over a dozen countries globally.

“[What are…](https://www.jeopardy.com/jbuzz/behind-scenes/what-are-some-questions-about-jeopardy)” in WOF: the United Kingdom has 4 `macroregion` and 334 `region` records; France has 29 `macroregion` and 101 `region` records; the United States has 51 `region` records (including the [District of Columbia](https://spelunker.whosonfirst.org/id/85688741/) which is marked in `label:eng_x_preferred_placetype` as a “federal district”). Puerto Rico is a dependency of the United States empire. Naming placetypes in inherently controversial so we also provide an optional and localized “[label:{lang}_x_preferred_placetype](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/label/README.md#lang_x_preferred_placetype)” property on records that carries the specific word used for that place in its country and translated to English (including the region of [Riyadh](https://spelunker.whosonfirst.org/id/85676813/) in Arabic script, latinized Arabic, and English).

_NOTE: Feature counts for each placetype are included in the legend. Every feature on the map below has a polygon geometry, but is represented as a point for visualization purposes._



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")



#### Localadmin coverage

Most of the 230K localadmin placetype features have polygon geometries. See the “Depth of administrative levels”, “By geometry type”, and “Improving WOF data coverage and quality (a more detailed look)” sections below for more information.



<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")



#### Campus coverage

Most of the 24K campus placetype features are airports, but we include national park polygons in select countries, and in the USA there are ~ 20k mobile home parks.



<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")



#### Other core “administrative” placetypes coverage

Additional placetypes in the “admin” repos are included for convenience to name and/or reverse geocode for continents, oceans, marine areas, time zones, and more exotic features like empires and market areas. We’re also wondering what those 2 unknown features are!



<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")



#### Postalcode coverage

Who’s On First has a range of postalcode types and geometry types with a precision gradient:

1. Polygons for fully qualified postalcodes (e.g. “[95501](https://spelunker.whosonfirst.org/id/554784877/)” in the United States sourced from the US Census Zip code tabulation areas, and also available in Australia, Australia, Finland, France, and Switzerland)
2. Polygons for postal aggregation areas (Canada, Netherlands). Think “955” in the United States which is useful for calculating regional statistics.
3. Point locations for specific delivery routes, like “[SW1A 1AA](https://spelunker.whosonfirst.org/id/487748609/)” in the United Kingdom (think ZIP+4 in the United States) which have a precise location (the same situation is true for Japan) or an approximate location mapped to the nearest available polygon centroid (like in Canada which has a combination of precise and official 3-character “forward sorting area” aggregation polygons and approximate centroids for the 6-character postal codes).
4. In the Netherlands we also have a 4th type of polygon created from the alphashape of the postalcode attributes on WOF venue point locations.

A sizable number of postal codes exist in other countries – but their locations are approximate (or [are visiting](https://spelunker.whosonfirst.org/nullisland/) [Null Island](https://www.wsj.com/articles/if-you-cant-follow-directions-youll-end-up-on-null-island-1468422251)) and are not shown in the map below based on the [shapefile distribution](https://geocode.earth/data/whosonfirst/) – but they are included in the [SQLite distribution](https://geocode.earth/data/whosonfirst/). If you’re interested in mapping postalcodes to the post office / locality names, we provide that for the United States in the `mz:postal_locality` property. If you need global mapping, see [Pelias’ postal cities](https://github.com/pelias/postal-cities) project.

_NOTE: The United Kingdom and Australia receive regular updates, the rest are an older vintage and could use a refresh. _

Several detailed map views are provided farther below for the more unusual cases.


<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")


##### Vancouver, Canada postalcodes

When precise locations for postalcodes (like the “[V5K 1A2](https://spelunker.whosonfirst.org/id/521319439/)” delivery route) are not available they are sometimes mapped to the polygon centroids of their parent postal area (e.g. “[V5K](https://spelunker.whosonfirst.org/id/504805001/)” postal aggregation area) in Vancouver, Canada shown below.



<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")



##### London postalcodes

Detailed point locations for specific delivery routes like “[SW1A 1AA](https://spelunker.whosonfirst.org/id/487748609/)” are available in the United Kingdom, updated approximately quarterly, with the London metro area shown below.



<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")



##### Tokyo, Japan postalcodes

Similar point geometries are available in Japan, with the Tokyo metro area shown below.



<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")



##### Amsterdam, Netherlands postalcodes

Several experiments have created [alphashapes](https://en.wikipedia.org/wiki/Alpha_shape) from WOF venues address data, including in the Netherlands. These approximate polygons are marked “[mz:is_approximate](https://github.com/whosonfirst/whosonfirst-properties/tree/main/properties/mz#is_approximate)” and capture the bounding box extent of the zipcode and the label centroid in search and even reverse geocoding, but are not suitable for display in a thematic map.



<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")



#### Constituency coverage

For national and regional legislative bodies, including upper and lower chamber indication via “[wof:association](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/wof/README.md#association)”. These will need a refresh for the 2023 redistricting in the United States. Canada includes data in British Columbia only.



<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")



#### Venue coverage

Back in 2015 and 2016 we imported 21 million venues in 63 countries from the [SimpleGeo CC0 venues](https://web.archive.org/web/20120314172738/http://blog.simplegeo.com/2011/08/01/august-updates/) dataset. We added place hierarchy by reverse geocoding these points against the WOF administrative polygons, and otherwise normalized them into the WOF schema. But venues come and go – they are more ephemeral than administrative data – especially the last few years during the COVID pandemic. So the WOF venue coverage will lack newer businesses and still include businesses that have closed IRL. A separate analysis of WOF venues is available in an [earlier blog post](https://whosonfirst.org/blog/2017/10/24/whosonfirst-sotmus-2017/).


### By Geometry Type

Nearly 10% of Who’s On First’s 5 million administrative records have polygons, with complete global coverage at the `country` and `dependency` (collectively the “top administrative level”), and `region` (1st order administrative subdivision) levels. Nearly continuous global coverage is provided at the `county` (2nd order administrative subdivision) level. Many countries also include complete polygon coverage at the `localadmin` level.

Countries with any coloring in the “Country scorecards” map in the next section include complete locality polygon coverage. Other “gray” colored countries in that map will only include approximate locality polygons for the country capital and a handful of other regionally important localities.

The WOF gazetteer also stores nearly 0.5 million alternate geometries. This can occur when we upgrade point geometries to polygons, have multiple polygons to choose from but we designate just one the default and store the others as alternates, deal with coastline clipping for display versus territorial waters for reverse geocoding, or need to manually curate a custom polygon (and store the original as an alternate geometry).

Every default polygon feature includes a [label centroid](https://github.com/whosonfirst/whosonfirst-properties/tree/main/properties/lbl) geometry suitable for beautiful cartographic labeling derived either from [MapShaper](https://github.com/mbloch/mapshaper) or manual curation. Sometimes [navigation](https://github.com/whosonfirst/whosonfirst-properties/tree/main/properties/nav), [reverse geocoding](https://github.com/whosonfirst/whosonfirst-properties/tree/main/properties/reversegeo), and other specialized centroids are also provided.

_(below) The count of WOF features grouped by placetype, how many of those have default point or polygon geometry, how many have alternate geometries (and the ratio of alternate geometries to the count of features in that placetype), a point area indicates an WOF error mostly from us add or remove neighbourhood polygon geometries, the polygon area in equal area square kilometers, and the ratio of that area compared with the scope of the globe the placetype should cover. _


<table>
  <tr>
   <td>Order
   </td>
   <td>Placetype
   </td>
   <td>Total Features
   </td>
   <td>Points
   </td>
   <td>Multi + Polygons
   </td>
   <td>Alt geoms
   </td>
   <td>Alt %
   </td>
   <td>Point Areas
   </td>
   <td>Poly Area SQ KM
   </td>
   <td>Area %
   </td>
   <td>Area Denom
   </td>
   <td>Area Scope
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>country
   </td>
   <td><p style="text-align: right">
232</p>

   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
227</p>

   </td>
   <td><p style="text-align: right">
670</p>

   </td>
   <td><p style="text-align: right">
288.8%</p>

   </td>
   <td><p style="text-align: right">
0.0K</p>

   </td>
   <td><p style="text-align: right">
147.0M</p>

   </td>
   <td><p style="text-align: right">
99.9%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
2</p>

   </td>
   <td>dependency
   </td>
   <td><p style="text-align: right">
43</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
43</p>

   </td>
   <td><p style="text-align: right">
52</p>

   </td>
   <td><p style="text-align: right">
120.9%</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
83.3K</p>

   </td>
   <td><p style="text-align: right">
0.1%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
3</p>

   </td>
   <td>disputed
   </td>
   <td><p style="text-align: right">
104</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
104</p>

   </td>
   <td><p style="text-align: right">
110</p>

   </td>
   <td><p style="text-align: right">
105.8%</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
1.2M</p>

   </td>
   <td><p style="text-align: right">
0.8%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
4</p>

   </td>
   <td>macroregion
   </td>
   <td><p style="text-align: right">
117</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
117</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td><p style="text-align: right">
0.9%</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
3.3M</p>

   </td>
   <td><p style="text-align: right">
29.8%</p>

   </td>
   <td><p style="text-align: right">
10.9M</p>

   </td>
   <td>countries in ('AU', 'DE', 'FR', 'GF', 'TW')
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
5</p>

   </td>
   <td>region
   </td>
   <td><p style="text-align: right">
5,139</p>

   </td>
   <td><p style="text-align: right">
169</p>

   </td>
   <td><p style="text-align: right">
4,970</p>

   </td>
   <td><p style="text-align: right">
2,404</p>

   </td>
   <td><p style="text-align: right">
46.8%</p>

   </td>
   <td><p style="text-align: right">
0.0K</p>

   </td>
   <td><p style="text-align: right">
150.0M</p>

   </td>
   <td><p style="text-align: right">
102.0%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
6</p>

   </td>
   <td>macrocounty
   </td>
   <td><p style="text-align: right">
482</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
482</p>

   </td>
   <td><p style="text-align: right">
21</p>

   </td>
   <td><p style="text-align: right">
4.4%</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
882.5K</p>

   </td>
   <td><p style="text-align: right">
10.0%</p>

   </td>
   <td><p style="text-align: right">
8.8M</p>

   </td>
   <td>countries in ('AZ', 'BE', 'BR', 'ES', 'FI', 'FR', 'GB', 'HK', 'HU', 'IT', 'RS', 'TW')
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
7</p>

   </td>
   <td>county
   </td>
   <td><p style="text-align: right">
47,431</p>

   </td>
   <td><p style="text-align: right">
2,412</p>

   </td>
   <td><p style="text-align: right">
45,019</p>

   </td>
   <td><p style="text-align: right">
7,292</p>

   </td>
   <td><p style="text-align: right">
15.4%</p>

   </td>
   <td><p style="text-align: right">
0.0K</p>

   </td>
   <td><p style="text-align: right">
125.7M</p>

   </td>
   <td><p style="text-align: right">
85.5%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
8</p>

   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
203,513</p>

   </td>
   <td><p style="text-align: right">
73,198</p>

   </td>
   <td><p style="text-align: right">
130,315</p>

   </td>
   <td><p style="text-align: right">
107,619</p>

   </td>
   <td><p style="text-align: right">
52.9%</p>

   </td>
   <td><p style="text-align: right">
0.0K</p>

   </td>
   <td><p style="text-align: right">
18.1M</p>

   </td>
   <td><p style="text-align: right">
12.3%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
9</p>

   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
4,498,136</p>

   </td>
   <td><p style="text-align: right">
4,274,056</p>

   </td>
   <td><p style="text-align: right">
224,080</p>

   </td>
   <td><p style="text-align: right">
200,106</p>

   </td>
   <td><p style="text-align: right">
4.4%</p>

   </td>
   <td><p style="text-align: right">
0.5K</p>

   </td>
   <td><p style="text-align: right">
7.1M</p>

   </td>
   <td><p style="text-align: right">
4.8%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
10</p>

   </td>
   <td>borough
   </td>
   <td><p style="text-align: right">
467</p>

   </td>
   <td><p style="text-align: right">
18</p>

   </td>
   <td><p style="text-align: right">
449</p>

   </td>
   <td><p style="text-align: right">
9</p>

   </td>
   <td><p style="text-align: right">
1.9%</p>

   </td>
   <td><p style="text-align: right">
0.0K</p>

   </td>
   <td><p style="text-align: right">
16.0K</p>

   </td>
   <td><p style="text-align: right">
0.2%</p>

   </td>
   <td><p style="text-align: right">
7.1M</p>

   </td>
   <td>locality
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
11</p>

   </td>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
1,272</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
1,268</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td><p style="text-align: right">
0.2%</p>

   </td>
   <td><p style="text-align: right">
0.0K</p>

   </td>
   <td><p style="text-align: right">
15.9K</p>

   </td>
   <td><p style="text-align: right">
0.2%</p>

   </td>
   <td><p style="text-align: right">
7.1M</p>

   </td>
   <td>locality
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
12</p>

   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
233,712</p>

   </td>
   <td><p style="text-align: right">
194,713</p>

   </td>
   <td><p style="text-align: right">
38,999</p>

   </td>
   <td><p style="text-align: right">
128,733</p>

   </td>
   <td><p style="text-align: right">
55.1%</p>

   </td>
   <td><p style="text-align: right">
94.8K</p>

   </td>
   <td><p style="text-align: right">
144.3K</p>

   </td>
   <td><p style="text-align: right">
2.0%</p>

   </td>
   <td><p style="text-align: right">
7.1M</p>

   </td>
   <td>locality
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
13</p>

   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
2,127</p>

   </td>
   <td><p style="text-align: right">
165</p>

   </td>
   <td><p style="text-align: right">
1,962</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td><p style="text-align: right">
0.1%</p>

   </td>
   <td><p style="text-align: right">
0.0K</p>

   </td>
   <td><p style="text-align: right">
1.9K</p>

   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
   <td><p style="text-align: right">
7.1M</p>

   </td>
   <td>locality
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
14</p>

   </td>
   <td>planet
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
510.1M</p>

   </td>
   <td><p style="text-align: right">
100.0%</p>

   </td>
   <td><p style="text-align: right">
510.1M</p>

   </td>
   <td>planet
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
16</p>

   </td>
   <td>ocean
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
293.1M</p>

   </td>
   <td><p style="text-align: right">
57.5%</p>

   </td>
   <td><p style="text-align: right">
510.1M</p>

   </td>
   <td>planet
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
15</p>

   </td>
   <td>continent
   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
62.5%</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
146.7M</p>

   </td>
   <td><p style="text-align: right">
28.8%</p>

   </td>
   <td><p style="text-align: right">
510.1M</p>

   </td>
   <td>planet
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
17</p>

   </td>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
402</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
402</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td><p style="text-align: right">
0.7%</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
72.7M</p>

   </td>
   <td><p style="text-align: right">
24.8%</p>

   </td>
   <td><p style="text-align: right">
293.1M</p>

   </td>
   <td>ocean
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
18</p>

   </td>
   <td>empire
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
47.2M</p>

   </td>
   <td><p style="text-align: right">
32.1%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
19</p>

   </td>
   <td>timezone
   </td>
   <td><p style="text-align: right">
376</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
376</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
134.4M</p>

   </td>
   <td><p style="text-align: right">
91.4%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
20</p>

   </td>
   <td>marketarea
   </td>
   <td><p style="text-align: right">
210</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
210</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
8.5M</p>

   </td>
   <td><p style="text-align: right">
86.3%</p>

   </td>
   <td><p style="text-align: right">
9.8M</p>

   </td>
   <td>countries in ('US')
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
21</p>

   </td>
   <td>campus
   </td>
   <td><p style="text-align: right">
24,452</p>

   </td>
   <td><p style="text-align: right">
21,916</p>

   </td>
   <td><p style="text-align: right">
2,536</p>

   </td>
   <td><p style="text-align: right">
33</p>

   </td>
   <td><p style="text-align: right">
0.1%</p>

   </td>
   <td><p style="text-align: right">
0.0K</p>

   </td>
   <td><p style="text-align: right">
346.8K</p>

   </td>
   <td><p style="text-align: right">
0.2%</p>

   </td>
   <td><p style="text-align: right">
147.1M</p>

   </td>
   <td>all country and dependency
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
22</p>

   </td>
   <td>unknown
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td><p style="text-align: right">
100.0%</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
   <td><p style="text-align: right">
510.1M</p>

   </td>
   <td>planet
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>TOTALS
   </td>
   <td><p style="text-align: right">
5,018,244</p>

   </td>
   <td><p style="text-align: right">
4,566,656</p>

   </td>
   <td><p style="text-align: right">
451,588</p>

   </td>
   <td><p style="text-align: right">
447,063</p>

   </td>
   <td><p style="text-align: right">
8.9%</p>

   </td>
   <td><p style="text-align: right">
95.3K</p>

   </td>
   <td><p style="text-align: right">
1.7B</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>


_NOTE: Postalcodes are not tracked in this table. See Postalcode coverage section above._


### By Geometry Source


#### Geometries directly imported by Who’s On First from source

Who’s On First both makes our own data and imports data directly from governments and other reputable sources. WOF tracks sources for each geometry in the “[src:geom](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/src/README.md#geom)” property, with values being a source’s “name” in the [sources](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md) repo, while imported property’s from that source will have their name prepended with the “prefix” in the source’s JSON file. Hyperlinks are provided in the table below directly to that source’s JSON file (while the sources link above is human readable formatted text).


<table>
  <tr>
   <td>directly by
   </td>
   <td>source
   </td>
   <td>count
   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/geonames.json">geonames</a>
   </td>
   <td><p style="text-align: right">
4192805</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/qs_pg.json">qs_pg</a>
   </td>
   <td><p style="text-align: right">
213815</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/quattroshapes.json">quattroshapes</a>
   </td>
   <td><p style="text-align: right">
202739</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/frgov.json">frgov</a>
   </td>
   <td><p style="text-align: right">
70551</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/unknown.json">unknown</a>
   </td>
   <td><p style="text-align: right">
70371</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/mz.json">mz</a>
   </td>
   <td><p style="text-align: right">
57396</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/whosonfirst.json">whosonfirst</a>
   </td>
   <td><p style="text-align: right">
47435</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/uscensus.json">uscensus</a>
   </td>
   <td><p style="text-align: right">
36473</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/meso.json">meso</a>
   </td>
   <td><p style="text-align: right">
27675</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/de-bkg.json">de-bkg</a>
   </td>
   <td><p style="text-align: right">
16290</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/cbsnl.json">cbsnl</a>
   </td>
   <td><p style="text-align: right">
14243</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/ro-ancpi.json">ro-ancpi</a>
   </td>
   <td><p style="text-align: right">
13753</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/ch-cadastre.json">ch-cadastre</a>
   </td>
   <td><p style="text-align: right">
6397</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/nz-linz.json">nz-linz</a>
   </td>
   <td><p style="text-align: right">
5942</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/ee-mamt.json">ee-mamt</a>
   </td>
   <td><p style="text-align: right">
5045</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/pl-gugik.json">pl-gugik</a>
   </td>
   <td><p style="text-align: right">
4658</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/zetashapes.json">zetashapes</a>
   </td>
   <td><p style="text-align: right">
4372</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/ourairports.json">ourairports</a>
   </td>
   <td><p style="text-align: right">
3326</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/pt-dgt.json">pt-dgt</a>
   </td>
   <td><p style="text-align: right">
3092</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/se-lant.json">se-lant</a>
   </td>
   <td><p style="text-align: right">
2813</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/austriaod.json">austriaod</a>
   </td>
   <td><p style="text-align: right">
2194</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/naturalearth.json">naturalearth</a>
   </td>
   <td><p style="text-align: right">
1858</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/wikidata.json">wikidata</a>
   </td>
   <td><p style="text-align: right">
1742</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/woedb.json">woedb</a>
   </td>
   <td><p style="text-align: right">
1472</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/esp-cicgc.json">esp-cicgc</a>
   </td>
   <td><p style="text-align: right">
950</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/ie-gov.json">ie-gov</a>
   </td>
   <td><p style="text-align: right">
816</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/au-capad.json">au-capad</a>
   </td>
   <td><p style="text-align: right">
716</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/amsgis.json">amsgis</a>
   </td>
   <td><p style="text-align: right">
695</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/no-geonorge.json">no-geonorge</a>
   </td>
   <td><p style="text-align: right">
493</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/us-nps.json">us-nps</a>
   </td>
   <td><p style="text-align: right">
419</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/hkigis.json">hkigis</a>
   </td>
   <td><p style="text-align: right">
409</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/sg-sggov.json">sg-sggov</a>
   </td>
   <td><p style="text-align: right">
396</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-edmdsd.json">can-edmdsd</a>
   </td>
   <td><p style="text-align: right">
333</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/figov.json">figov</a>
   </td>
   <td><p style="text-align: right">
323</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/begov.json">begov</a>
   </td>
   <td><p style="text-align: right">
308</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/baltomoit.json">baltomoit</a>
   </td>
   <td><p style="text-align: right">
288</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/statcan.json">statcan</a>
   </td>
   <td><p style="text-align: right">
272</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-abog.json">can-abog</a>
   </td>
   <td><p style="text-align: right">
264</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/pedia.json">pedia</a>
   </td>
   <td><p style="text-align: right">
254</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/atldpcd.json">atldpcd</a>
   </td>
   <td><p style="text-align: right">
235</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/svn-sma.json">svn-sma</a>
   </td>
   <td><p style="text-align: right">
224</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/lu-act.json">lu-act</a>
   </td>
   <td><p style="text-align: right">
216</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/za-mdb.json">za-mdb</a>
   </td>
   <td><p style="text-align: right">
213</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/wapo.json">wapo</a>
   </td>
   <td><p style="text-align: right">
213</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/zolk.json">zolk</a>
   </td>
   <td><p style="text-align: right">
207</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/aus-psma.json">aus-psma</a>
   </td>
   <td><p style="text-align: right">
193</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/mx-conanp.json">mx-conanp</a>
   </td>
   <td><p style="text-align: right">
182</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/dk-geodk.json">dk-geodk</a>
   </td>
   <td><p style="text-align: right">
179</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/azavea.json">azavea</a>
   </td>
   <td><p style="text-align: right">
158</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-calcai.json">can-calcai</a>
   </td>
   <td><p style="text-align: right">
152</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/esp-aytomad.json">esp-aytomad</a>
   </td>
   <td><p style="text-align: right">
151</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-wpgppd.json">can-wpgppd</a>
   </td>
   <td><p style="text-align: right">
148</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/sdgis.json">sdgis</a>
   </td>
   <td><p style="text-align: right">
136</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/tkugov.json">tkugov</a>
   </td>
   <td><p style="text-align: right">
129</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/oakced.json">oakced</a>
   </td>
   <td><p style="text-align: right">
124</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/ssuberlin.json">ssuberlin</a>
   </td>
   <td><p style="text-align: right">
108</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/tmpgov.json">tmpgov</a>
   </td>
   <td><p style="text-align: right">
106</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/oulugov.json">oulugov</a>
   </td>
   <td><p style="text-align: right">
106</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/porbps.json">porbps</a>
   </td>
   <td><p style="text-align: right">
102</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/sfgov.json">sfgov</a>
   </td>
   <td><p style="text-align: right">
96</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/os.json">os</a>
   </td>
   <td><p style="text-align: right">
91</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/seagv.json">seagv</a>
   </td>
   <td><p style="text-align: right">
88</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/denvercpd.json">denvercpd</a>
   </td>
   <td><p style="text-align: right">
87</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/torsdfa.json">torsdfa</a>
   </td>
   <td><p style="text-align: right">
85</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/nolagis.json">nolagis</a>
   </td>
   <td><p style="text-align: right">
83</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/esp-cartobcn.json">esp-cartobcn</a>
   </td>
   <td><p style="text-align: right">
83</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-gatsudd.json">can-gatsudd</a>
   </td>
   <td><p style="text-align: right">
74</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/fivgov.json">fivgov</a>
   </td>
   <td><p style="text-align: right">
70</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/arg-caba.json">arg-caba</a>
   </td>
   <td><p style="text-align: right">
65</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-mtlsmvt.json">can-mtlsmvt</a>
   </td>
   <td><p style="text-align: right">
61</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-saskodp.json">can-saskodp</a>
   </td>
   <td><p style="text-align: right">
55</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/kuogov.json">kuogov</a>
   </td>
   <td><p style="text-align: right">
47</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-clab.json">can-clab</a>
   </td>
   <td><p style="text-align: right">
47</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/lacity.json">lacity</a>
   </td>
   <td><p style="text-align: right">
40</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-dnvgov.json">can-dnvgov</a>
   </td>
   <td><p style="text-align: right">
37</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-ons.json">can-ons</a>
   </td>
   <td><p style="text-align: right">
36</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/minitenders.json">minitenders</a>
   </td>
   <td><p style="text-align: right">
35</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/gbr-datalondon.json">gbr-datalondon</a>
   </td>
   <td><p style="text-align: right">
33</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/santabar.json">santabar</a>
   </td>
   <td><p style="text-align: right">
32</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-bbygov.json">can-bbygov</a>
   </td>
   <td><p style="text-align: right">
32</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/eu-cdda.json">eu-cdda</a>
   </td>
   <td><p style="text-align: right">
27</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-qcodp.json">can-qcodp</a>
   </td>
   <td><p style="text-align: right">
27</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/bra.json">bra</a>
   </td>
   <td><p style="text-align: right">
27</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/hk-gov.json">hk-gov</a>
   </td>
   <td><p style="text-align: right">
21</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/burritojustice.json">burritojustice</a>
   </td>
   <td><p style="text-align: right">
19</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/wikipedia.json">wikipedia</a>
   </td>
   <td><p style="text-align: right">
16</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/stpaulgov.json">stpaulgov</a>
   </td>
   <td><p style="text-align: right">
16</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/wof.json">wof</a>
   </td>
   <td><p style="text-align: right">
15</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/SIJ.json">SIJ</a>
   </td>
   <td><p style="text-align: right">
15</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/ni-os.json">ni-os</a>
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-rodca.json">can-rodca</a>
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/mapzen.json">mapzen</a>
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/ausstat.json">ausstat</a>
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/uk-datagov.json">uk-datagov</a>
   </td>
   <td><p style="text-align: right">
10</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/canvec-hydro.json">canvec-hydro</a>
   </td>
   <td><p style="text-align: right">
9</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-nwds.json">can-nwds</a>
   </td>
   <td><p style="text-align: right">
9</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/vanpds.json">vanpds</a>
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/camgov.json">camgov</a>
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-surgis.json">can-surgis</a>
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/us-dshiu.json">us-dshiu</a>
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/sjp.json">sjp</a>
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/sfomuseum.json">sfomuseum</a>
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/can-lvlsu.json">can-lvlsu</a>
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/quattroshapes_pg.json">quattroshapes_pg</a>
   </td>
   <td><p style="text-align: right">
2</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/nullisland.json">nullisland</a>
   </td>
   <td><p style="text-align: right">
2</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/simplegeo.json">simplegeo</a>
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>whosonfirst
   </td>
   <td><a href="https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/ccsf-sfo.json">ccsf-sfo</a>
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
</table>



#### Quattroshapes geometries imported to WOF from aggregator

These are the [OG](https://www.urbandictionary.com/define.php?term=OG) polygons that WOF launched with in 2015 thanks to Foursquare’s open data Quattroshapes gazetteer. They range across all administrative placetypes from country to locality to neighbourhood.

Who’s On First indicates if a geometry is from an aggregator in the main “[src:geom](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/src/README.md#geom)” property, and lists out those sources the [sources](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md) repo. Per record fidelity is available by dipping into the “[qs:source](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/qs/README.md#qssource)” property; we plan to promote that information into a new and generic top-level WOF property.


<table>
  <tr>
   <td>source
   </td>
   <td>src_via
   </td>
   <td>count
   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Australia Census
   </td>
   <td><p style="text-align: right">
558</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Australian Bureau Of Statistics
   </td>
   <td><p style="text-align: right">
8253</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Australian Bureau Of Statistics: state suburbs file selection
   </td>
   <td><p style="text-align: right">
4175</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Australian Bureau Of Statistics: state suburbs file with customization
   </td>
   <td><p style="text-align: right">
232</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Australian Bureau Of Statistics: urban areas and localities selection
   </td>
   <td><p style="text-align: right">
925</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Brasil IBGE
   </td>
   <td><p style="text-align: right">
35559</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Canada Census
   </td>
   <td><p style="text-align: right">
5771</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Custom EuroGlobalMap + UMZ Urban Polygons + Geonames + GeoPlanet
   </td>
   <td><p style="text-align: right">
30639</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>EuroGlobalMap
   </td>
   <td><p style="text-align: right">
2000</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>France IGN
   </td>
   <td><p style="text-align: right">
5502</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>GlobalMap
   </td>
   <td><p style="text-align: right">
4970</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Italy IGN
   </td>
   <td><p style="text-align: right">
8223</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Mexico IGN
   </td>
   <td><p style="text-align: right">
7028</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Natural Earth
   </td>
   <td><p style="text-align: right">
1741</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>NBC Gov
   </td>
   <td><p style="text-align: right">
152</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>New Zealand LINZ
   </td>
   <td><p style="text-align: right">
19</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>NLD Kadaster
   </td>
   <td><p style="text-align: right">
119</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>quattroshapes
   </td>
   <td><p style="text-align: right">
4824</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Spain IGN
   </td>
   <td><p style="text-align: right">
7318</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>SwissTopo
   </td>
   <td><p style="text-align: right">
604</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>UK OS
   </td>
   <td><p style="text-align: right">
14550</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>Unknown (multiple sources)
   </td>
   <td><p style="text-align: right">
8378</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>US Census
   </td>
   <td><p style="text-align: right">
20089</p>

   </td>
  </tr>
  <tr>
   <td>quattroshapes
   </td>
   <td>US State Department, with Natural Earth mods
   </td>
   <td><p style="text-align: right">
171</p>

   </td>
  </tr>
</table>



#### Mesoshapes geometries imported to WOF from aggregator

These are mostly `county` placetype default geometries.

Who’s On First indicates if a geometry is from an aggregator in the main “[src:geom](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/src/README.md#geom)” property, and lists out those sources the [sources](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md) repo. Per record fidelity is available by dipping into the “[meso:source](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/meso/README.md#source)” property; we plan to promote that information into a new and generic top-level WOF property.


<table>
  <tr>
   <td>source
   </td>
   <td>src_via
   </td>
   <td>via_name
   </td>
   <td>count
   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>ACE
   </td>
   <td>Armenia: Acopian Center for the Environment
   </td>
   <td><p style="text-align: right">
913</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>AOTM
   </td>
   <td>Global: Art of the Mappable (AOTM) for Mapzen
   </td>
   <td><p style="text-align: right">
14785</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>CLNC
   </td>
   <td>Chilean National Library of Congress
   </td>
   <td><p style="text-align: right">
51</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>DATAMEET
   </td>
   <td>India: DataMeet
   </td>
   <td><p style="text-align: right">
607</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>DGEEC
   </td>
   <td>Paraguay: DGEEC
   </td>
   <td><p style="text-align: right">
246</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>EGM
   </td>
   <td>Europe: Euro Global Map (EGM)
   </td>
   <td><p style="text-align: right">
155</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>ESOC
   </td>
   <td>Global: Empirical Study of Conflict (ESOC)
   </td>
   <td><p style="text-align: right">
109</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>ESRI_OPEN
   </td>
   <td>Global and Costa Rica: ESRI Open Data (Daticos)
   </td>
   <td><p style="text-align: right">
81</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>FIGN
   </td>
   <td>France: French IGN (FIGN)
   </td>
   <td><p style="text-align: right">
22</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>GSIJ
   </td>
   <td>Japan: Geospatial Information Authority of Japan (GSI)
   </td>
   <td><p style="text-align: right">
3063</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>IDE_EFP
   </td>
   <td>Bolivia: IDE-EPB GeoBolivia data portal (IDE_EPB)
   </td>
   <td><p style="text-align: right">
198</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>ISCGM
   </td>
   <td>Global, Azerbaijan, Georgia, Honduras, Indonesia, Mauritius, Mozambique, Nicaragua, Papua, Togo: International Steering Committee for Global Mapping (ISCGM)
   </td>
   <td><p style="text-align: right">
854</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>meso
   </td>
   <td>Mapzen
   </td>
   <td><p style="text-align: right">
6</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>mz
   </td>
   <td>Mapzen
   </td>
   <td><p style="text-align: right">
22</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>NISR
   </td>
   <td>Rwanda: National Institute of Statistics of Rwanda (NISR)
   </td>
   <td><p style="text-align: right">
30</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>NREL
   </td>
   <td>Bangladesh: National Renewable Energy Laboratory (NREL)
   </td>
   <td><p style="text-align: right">
64</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>OCHA_OPEN
   </td>
   <td>Global: OCHA_OPEN
   </td>
   <td><p style="text-align: right">
1608</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>SAMDB
   </td>
   <td>South Africa: South Africa Municipal Demarcation Board (SAMDB)
   </td>
   <td><p style="text-align: right">
52</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>SH
   </td>
   <td>Colombia: Sala Humanitaria (SH)
   </td>
   <td><p style="text-align: right">
1122</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>SNZ
   </td>
   <td>New Zealand: Statistics New Zealand (SNZ)
   </td>
   <td><p style="text-align: right">
67</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>STATOIDS
   </td>
   <td>Global: Statoids
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>TNBS
   </td>
   <td>Tanzania: Tanzania National Bureau of Statistics (TNBS)
   </td>
   <td><p style="text-align: right">
169</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>TNLSMC
   </td>
   <td>Asia: National Land Surveying and Mapping Center (TNLSMC)
   </td>
   <td><p style="text-align: right">
30</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>USAID
   </td>
   <td>Global: USAID - GIST with USAID as originator, Egypt: USAID via FOIA, Ethiopia, Liberia: USAID
   </td>
   <td><p style="text-align: right">
445</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>WRI
   </td>
   <td>Global: World Resource Institute (WRI), Cameroon, Ethiopia: WRI
   </td>
   <td><p style="text-align: right">
103</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>ZIMSTAT
   </td>
   <td>Zimbabwe: Zimbabwe Central Statistics Office (ZimStat)
   </td>
   <td><p style="text-align: right">
44</p>

   </td>
  </tr>
  <tr>
   <td>meso
   </td>
   <td>
   </td>
   <td>Multiple sources
   </td>
   <td><p style="text-align: right">
2828</p>

   </td>
  </tr>
</table>



## WOF Gazetteer Data Scorecards


### Country scorecards

** \
**We rate 87 countries with good to great polygon coverage at both locality and parent administrative subdivisions, including country, region (state/province), and county, in the **A-AA-AAA-AAAA** range. Our `disputed` territory polygon coverage also falls in this “great” data grouping.

We rate 177 countries that are mostly limited to point locality coverage and basic polygon administrative subdivisions in the **B-BB-BBB-BBBB** range. We almost always have “complete” coverage in these countries, however, often tens of thousands and sometimes with hundreds of thousands of features are point geometries only.

_Breakdowns of each of these classes are available below the map…_



<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")



#### A range coverage by country

**AAAA:** Starting in 2017, we have rebuilt priority countries by importing authoritative, polygon-based records at all placetypes from region down to locality to provide **AAAA data quality** and coverage in: _Australia, Austria, Canada, Estonia, France, Germany, Hong Kong, Italy, Netherlands, New Zealand, Poland, Romania, Singapore, Spain, Switzerland, United Kingdom, and United States._

**AAA: **Other countries in North America, Europe, Middle East, Asia, and elsewhere have had selective rebuilds at a mix of placetypes to provide **AAA data quality** and coverage using national mapping agency data – though possibly of an older vintage that may not reflect all recent administrative updates. _These include: Akrotiri Sovereign Base Area, Aland, Albania, Bahrain, Belgium, Brazil, Bulgaria, Croatia, Cyprus, Czechia, Denmark, Dhekelia Sovereign Base Area, Faroe Islands, Finland, Greece, Greenland, Guernsey, Hungary, Iceland, Ireland, Isle of Man, Kuwait, Latvia, Liechtenstein, Lithuania, Luxembourg, Moldova, North Macedonia, Northern Cyprus, Norway, Portugal, Puerto Rico, Qatar, San Marino, Saudi Arabia, Slovakia, Slovenia, South Africa, Sweden, Turkey, Ukraine, United Arab Emirates, and Vatican._

**AA: **WOF provides **AA data quality** with extensive (but not universal) polygon coverage at locality level in _Chile, India, Indonesia, Iraq, Israel, Mexico, Morocco, Nigeria, Pakistan, Palestine, Philipeans, South Korea, and Taiwan._ These polygons often date back to 2013 and represent the largest urban settlements.

**A: **WOF provides **A data quality** with approximate locality polygons in _China, Japan, Malaysia, Russia, and Thailand_. Several countries with extensive and higher quality point locality coverage, including: _Columbia and Honduras_.


#### B range coverage by country

**BBBB:** WOF provides BBBB quality data with dense point locality coverage in _Afghanistan, Argentina, Bangladesh, Baykonur, Bolivia, Iran, Kazakhstan, Mozambique, Myanmar, Nepal, Paraguay, Peru, Tanzania, Venezuela, and Vietnam._

**BBB:** WOF provides BBB quality data with dense point locality coverage in  _Angola, Belarus, Bosnia and Herzegovina, Congo (DRC), Costa Rica, Gabon, Madagascar, Mongolia, North Korea, Rwanda, Uganda, and Yemen._

**BB:** WOF provides BB quality date with medium density point locality coverage in _Armenia, Burkina Faso, Burundi, Cambodia, Cameroon, Central African Republic, Congo (ROC), Cuba, Dominican Republic, Ecuador, Egypt, Ethiopia, Ghana, Guatemala, Haiti, Ivory Coast, Kosovo, Kyrgyzstan, Laos, Mali, Montenegro, Namibia, Panama, Papua New Guinea, Serbia, Sierra Leone, South Sudan, Sri Lanka, Sudan, Syria, Tunisia, Uruguay, and Zambia._

**B:** WOF provides B quality date with basic density point locality coverage in_ Algeria, Azerbaijan, Belize, Benin, Bhutan, Botswana, Chad, Djibouti, El Salvador, Equatorial Guinea, Eritrea, eSwatini, Gambia, Georgia, Guinea, Guinea-Bissau, Guyana, Jamaica, Jordan, Kenya, Lesotho, Liberia, Libya, Malawi, Mauritania, Nicaragua, Niger, Oman, Senegal, Somalia, Somaliland, Suriname, Tajikistan, Togo, Turkmenistan, Uzbekistan, and Zimbabwe. This category also includes several smaller island countries._

NOTE: We still provide detailed region and county polygon coverage for all these to generate full administrative hierarchies, except counties in _Namibia, Botswana, Belarus, Bulgaria, Turkmenistan, and Uzbekistan_. _Greenland, Iceland, and Western Sahara do not have county subdivisions IRL._


### Data size by country



<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")


_NOTE: Methodology: [https://data.geocode.earth/wof/dist/shapefile/inventory.json](https://data.geocode.earth/wof/dist/shapefile/inventory.json) to get sizes per country._

 \
Even though most countries are limited to locality points past the county polygon level, those features (and their properties including name localizations) can add up to sizable downloads, especially when mixed in with the polygon features.


### Features by country

Looking at “administrative” placetype features by country (country code), the trend mostly follows population density.


<table>
  <tr>
   <td>rank
   </td>
   <td>country
   </td>
   <td>count
   </td>
   <td>
   </td>
   <td>rank
   </td>
   <td>country
   </td>
   <td>count
   </td>
   <td>
   </td>
   <td>rank
   </td>
   <td>country
   </td>
   <td>count
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>China (CN)
   </td>
   <td><p style="text-align: right">
679,207</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
21</p>

   </td>
   <td>Bangladesh (BD)
   </td>
   <td><p style="text-align: right">
48,696</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
41</p>

   </td>
   <td>Austria (AT)
   </td>
   <td><p style="text-align: right">
23,458</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
2</p>

   </td>
   <td>India (IN)
   </td>
   <td><p style="text-align: right">
509,567</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
22</p>

   </td>
   <td>Philippines (PH)
   </td>
   <td><p style="text-align: right">
45,819</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
42</p>

   </td>
   <td>Iraq (IQ)
   </td>
   <td><p style="text-align: right">
22,900</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
3</p>

   </td>
   <td>United States (US)
   </td>
   <td><p style="text-align: right">
293,571</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
23</p>

   </td>
   <td>Morocco (MA)
   </td>
   <td><p style="text-align: right">
45,577</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
43</p>

   </td>
   <td>Mozambique (MZ)
   </td>
   <td><p style="text-align: right">
22,782</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
4</p>

   </td>
   <td>Indonesia (ID)
   </td>
   <td><p style="text-align: right">
256,068</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
24</p>

   </td>
   <td>Viet Nam (VN)
   </td>
   <td><p style="text-align: right">
41,889</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
44</p>

   </td>
   <td>Bosnia & Herz. (BA)
   </td>
   <td><p style="text-align: right">
22,147</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
5</p>

   </td>
   <td>Mexico (MX)
   </td>
   <td><p style="text-align: right">
232,389</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
25</p>

   </td>
   <td>Spain (ES)
   </td>
   <td><p style="text-align: right">
41,443</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
45</p>

   </td>
   <td>Netherlands (NL)
   </td>
   <td><p style="text-align: right">
21,912</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
6</p>

   </td>
   <td>Russia (RU)
   </td>
   <td><p style="text-align: right">
203,058</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
26</p>

   </td>
   <td>Peru (PE)
   </td>
   <td><p style="text-align: right">
40,653</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
46</p>

   </td>
   <td>Malaysia (MY)
   </td>
   <td><p style="text-align: right">
21,102</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
7</p>

   </td>
   <td>Germany (DE)
   </td>
   <td><p style="text-align: right">
167,516</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
27</p>

   </td>
   <td>Myanmar (MM)
   </td>
   <td><p style="text-align: right">
39,287</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
47</p>

   </td>
   <td>Portugal (PT)
   </td>
   <td><p style="text-align: right">
20,519</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
8</p>

   </td>
   <td>Pakistan (PK)
   </td>
   <td><p style="text-align: right">
135,126</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
28</p>

   </td>
   <td>Yemen (YE)
   </td>
   <td><p style="text-align: right">
39,204</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
48</p>

   </td>
   <td>Lithuania (LT)
   </td>
   <td><p style="text-align: right">
19,988</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
9</p>

   </td>
   <td>France (FR)
   </td>
   <td><p style="text-align: right">
122,484</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
29</p>

   </td>
   <td>Congo (CD)
   </td>
   <td><p style="text-align: right">
36,677</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
49</p>

   </td>
   <td>Taiwan (TW)
   </td>
   <td><p style="text-align: right">
18,687</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
10</p>

   </td>
   <td>Thailand (TH)
   </td>
   <td><p style="text-align: right">
87,191</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
30</p>

   </td>
   <td>Ukraine (UA)
   </td>
   <td><p style="text-align: right">
35,145</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
50</p>

   </td>
   <td>Sri Lanka (LK)
   </td>
   <td><p style="text-align: right">
17,956</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
11</p>

   </td>
   <td>Nepal (NP)
   </td>
   <td><p style="text-align: right">
80,713</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
31</p>

   </td>
   <td>Colombia (CO)
   </td>
   <td><p style="text-align: right">
33,723</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
51</p>

   </td>
   <td>Czechia (CZ)
   </td>
   <td><p style="text-align: right">
17,341</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
12</p>

   </td>
   <td>Iran (IR)
   </td>
   <td><p style="text-align: right">
78,355</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
32</p>

   </td>
   <td>Afghanistan (AF)
   </td>
   <td><p style="text-align: right">
32,419</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
52</p>

   </td>
   <td>Romania (RO)
   </td>
   <td><p style="text-align: right">
16,666</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
13</p>

   </td>
   <td>Brazil (BR)
   </td>
   <td><p style="text-align: right">
76,335</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
33</p>

   </td>
   <td>Sweden (SE)
   </td>
   <td><p style="text-align: right">
31,859</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
53</p>

   </td>
   <td>Angola (AO)
   </td>
   <td><p style="text-align: right">
16,585</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
14</p>

   </td>
   <td>Italy (IT)
   </td>
   <td><p style="text-align: right">
73,273</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
34</p>

   </td>
   <td>Korea (DPR) (KP)
   </td>
   <td><p style="text-align: right">
31,755</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
54</p>

   </td>
   <td>Greece (GR)
   </td>
   <td><p style="text-align: right">
15,855</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
15</p>

   </td>
   <td>Japan (JP)
   </td>
   <td><p style="text-align: right">
56,979</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
35</p>

   </td>
   <td>Australia (AU)
   </td>
   <td><p style="text-align: right">
28,204</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
55</p>

   </td>
   <td>Bolivia (BO)
   </td>
   <td><p style="text-align: right">
15,495</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
16</p>

   </td>
   <td>Nigeria (NG)
   </td>
   <td><p style="text-align: right">
55,893</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
36</p>

   </td>
   <td>Canada (CA)
   </td>
   <td><p style="text-align: right">
28,097</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
56</p>

   </td>
   <td>South Africa (ZA)
   </td>
   <td><p style="text-align: right">
15,402</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
17</p>

   </td>
   <td>Türkiye (TR)
   </td>
   <td><p style="text-align: right">
54,420</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
37</p>

   </td>
   <td>Switzerland (CH)
   </td>
   <td><p style="text-align: right">
25,691</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
57</p>

   </td>
   <td>Laos (LA)
   </td>
   <td><p style="text-align: right">
15,262</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
18</p>

   </td>
   <td>Korea (KR)
   </td>
   <td><p style="text-align: right">
53,030</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
38</p>

   </td>
   <td>Belarus (BY)
   </td>
   <td><p style="text-align: right">
25,276</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
58</p>

   </td>
   <td>Finland (FI)
   </td>
   <td><p style="text-align: right">
15,143</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
19</p>

   </td>
   <td>United Kingdom (GB)
   </td>
   <td><p style="text-align: right">
52,950</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
39</p>

   </td>
   <td>Madagascar (MG)
   </td>
   <td><p style="text-align: right">
24,260</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>Others
   </td>
   <td><p style="text-align: right">
659,904</p>

   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
20</p>

   </td>
   <td>Poland (PL)
   </td>
   <td><p style="text-align: right">
51,522</p>

   </td>
   <td>
   </td>
   <td><p style="text-align: right">
40</p>

   </td>
   <td>Venezuela (VE)
   </td>
   <td><p style="text-align: right">
23,819</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>TOTAL
   </td>
   <td><p style="text-align: right">
5,018,244</p>

   </td>
  </tr>
</table>



### Depth of administrative levels by country



<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")


Who’s On First tracks 1st and 2nd order administrative divisions for most countries and dependencies (so three levels deep including county, region, and county). A handful only have 1st order divisions (2 levels). Around 39 countries include 4 to 7 administrative levels. Around 24 of those include features at the municipality (“localadmin”) level. We have point records only for “localadmin” in another 19 countries, and anticipate polygon features for this placetype can be imported for another 53 countries (see “Future Directions” section below).


### Vintage of data by country



<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")


While 2013-era Quattroshapes is the skeleton for Who’s On First, we’ve substantially updated the gazetteer in the last decade. In 2015, we imported the original Quattroshapes polygon features to normalize them and otherwise clean them up. In 2016, we added polygons for 2nd order administrative divisions (“county”) for almost every country and dependency in the world. In 2017, we imported Quattroshapes point gazetteer and GeoNames “locality” points to provide global coverage at that placetype in all countries. Most country and dependency capitals and major metropolitan centers were updated with approximate polygons in 2021. Select countries have been rebuilt in whole or partially since 2017, including 42 countries in North America, Europe, and elsewhere.

Most of the **AAAA** and **AAA** countries (see section above) have a 5- or 10-year census, and we attempt to incorporate polygon data from their most recent census &/or INSPIRE-related open data efforts. Some eastern European countries have earlier 2013 vintage locality polygons. Generally region and county level changes less per year, with the localadmin level experiencing more consolidation and occasional splits on an annual basis (~1% change per year).

When Who’s On First observes a change in a country’s administrative subdivisions we add the new or changed features with an [inception](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/edtf/README.md#inception) date, and mark the old ones with a [cessation](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/edtf/README.md#cessation) date using the expressive U.S. [Library of Congress' Extended Date/Time Format](https://github.com/whosonfirst/whosonfirst-dates) (EDTF) syntax. When possible, we also point back and forth between new and old with [supersedes](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/wof/README.md#supersedes) and [supersedes_by](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/wof/README.md#superseded_by) properties. This allows older administrative units to be queried within a date range in the SQLite distribution (while the Shapefile distribution excludes non-current records). We’ve also experimented with the same for countries, like the former [Yugoslavia](https://whosonfirst.org/blog/2017/06/29/tackling-space-and-time-in-whosonfirst/), which we discussed in an earlier blog post, and for the 2016 French “region” level consolidation (for example the WOF `macroregion` of [Rhone-Alpes](https://spelunker.whosonfirst.org/id/404227439/) was consolidated into the new  [Auvergne-Rhone-Alpes](https://spelunker.whosonfirst.org/id/1108826389/) WOF `macroregion`).


### Select data properties


##### Population by placetype

By tracking population (and the related population_rank), similarly named places can be ranked and disambiguated in search and visually distinguished in map display. For example, there are many places named [San Francisco](https://spelunker.whosonfirst.org/search/?q=san+francisco) in the world, but only [one](https://spelunker.whosonfirst.org/id/85922583/) with an exact name match also with the largest population located in the California region of the United States.

For global coverage placetypes like continent, country (and dependency), region, county, and locality the population should eventually sum to the planet’s population – modulo import vintage and population growth and the “per global” provides an coverage &/or accuracy scoring. For other placetypes like macroregion and localadmin they should sum to the population in the covered countries (not included in the table). Other placetypes are not available globally so the “per global” indicates the global significance of that placetype when viewed by population instead of feature count.

_(below) This chart sums available population values on WOF records grouped by placetype. Some placetypes that have global coverage should sum to the current “per global” population estimate of 7.888 billion people but currently may not because (a) the vintage of per feature population estimates either lags behind actual population growth or may over-estimate population and (b) some features lack population entirely. _


<table>
  <tr>
   <td>placetype
   </td>
   <td>population
   </td>
   <td>per global
   </td>
  </tr>
  <tr>
   <td>borough
   </td>
   <td><p style="text-align: right">
29,474,816</p>

   </td>
   <td><p style="text-align: right">
0.4%</p>

   </td>
  </tr>
  <tr>
   <td>campus
   </td>
   <td><p style="text-align: right">
133,650</p>

   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
  </tr>
  <tr>
   <td>continent
   </td>
   <td><p style="text-align: right">
7,627,184,440</p>

   </td>
   <td><p style="text-align: right">
96.7%</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
7,175,089,564</p>

   </td>
   <td><p style="text-align: right">
91.0%</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
4,934,055,579</p>

   </td>
   <td><p style="text-align: right">
62.6%</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
16,724,919</p>

   </td>
   <td><p style="text-align: right">
0.2%</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
461,098,876</p>

   </td>
   <td><p style="text-align: right">
5.8%</p>

   </td>
  </tr>
  <tr>
   <td>empire
   </td>
   <td><p style="text-align: right">
2,009,661,518</p>

   </td>
   <td><p style="text-align: right">
25.5%</p>

   </td>
  </tr>
  <tr>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
963,706,749</p>

   </td>
   <td><p style="text-align: right">
12.2%</p>

   </td>
  </tr>
  <tr>
   <td>locality
   </td>
   <td><p style="text-align: right">
5,717,437,257</p>

   </td>
   <td><p style="text-align: right">
72.5%</p>

   </td>
  </tr>
  <tr>
   <td>macrocounty
   </td>
   <td><p style="text-align: right">
231,167</p>

   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
  </tr>
  <tr>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
4,034,954</p>

   </td>
   <td><p style="text-align: right">
0.1%</p>

   </td>
  </tr>
  <tr>
   <td>macroregion
   </td>
   <td><p style="text-align: right">
94,515,886</p>

   </td>
   <td><p style="text-align: right">
1.2%</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
  </tr>
  <tr>
   <td>marketarea
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
  </tr>
  <tr>
   <td>microhood
   </td>
   <td><p style="text-align: right">
51,741</p>

   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
  </tr>
  <tr>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
411,640,484</p>

   </td>
   <td><p style="text-align: right">
5.2%</p>

   </td>
  </tr>
  <tr>
   <td>ocean
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
  </tr>
  <tr>
   <td>planet
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
9,300,891,860</p>

   </td>
   <td><p style="text-align: right">
117.9%</p>

   </td>
  </tr>
  <tr>
   <td>timezone
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
  </tr>
  <tr>
   <td>unknown
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0.0%</p>

   </td>
  </tr>
</table>



##### Zoom ranges by placetype

Some records should be displayed earlier on a map and some later, and not all features within the same placetype are equal. For example, region subdivisions in the United States are large geographically compared regions in Albania so the former should be shown earlier and the latter shown later. This is especially true of localities where most localities can be labeled on a zoom 12 map – but only a few shown on a zoom 2 map (especially considering name translations within a limited vector tile budget).

A few areas stand out for future work: county zooms should be spread out (mostly increasing them from zoom 6 to later zooms and as an offset for their parent region’s zoom), some localadmin are visible too early, some macrohood are visible too late, and some neighbourhood and microhood are visible too early – this can be mitigated in application logic when using the data but we should clean it up at the source.

_(below) This chart counts available min_zoom values on WOF records grouped by placetype. Course placetypes group features that are suitable for labeling on a low-zoom world map as “countries” or their 1st and 2nd order subdivisions, generally from zooms 0 thru 8 (though some counties should label later). Settlement placetypes include both locality and localadmin and are rarely labeled at low zooms, typically coming in the mid-zooms of 9, 10, 11, 12, and 13. Neighbourhood placetypes are subdivisions of settlements and generally should only be displayed at high-zooms of 11 thru 17._


<table>
  <tr>
   <td>Course placetypes
   </td>
   <td>min_zoom
   </td>
   <td>count
   </td>
   <td>
   </td>
   <td>Settlement \
placetypes
   </td>
   <td>min_zoom
   </td>
   <td>count
   </td>
   <td>
   </td>
   <td>Neighbourhoodplacetypes
   </td>
   <td>min_zoom
   </td>
   <td>count
   </td>
  </tr>
  <tr>
   <td>continent
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td>
   </td>
   <td>borough
   </td>
   <td><p style="text-align: right">
9</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
  </tr>
  <tr>
   <td>continent
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
50</p>

   </td>
   <td>
   </td>
   <td>borough
   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td><p style="text-align: right">
204</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
4.7</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>borough
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td><p style="text-align: right">
63</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
1.7</p>

   </td>
   <td><p style="text-align: right">
19</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
60</p>

   </td>
   <td>
   </td>
   <td>borough
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
60</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td><p style="text-align: right">
26</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
5.1</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>borough
   </td>
   <td><p style="text-align: right">
13</p>

   </td>
   <td><p style="text-align: right">
39</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
2.5</p>

   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
5.6</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td>
   </td>
   <td>borough
   </td>
   <td><p style="text-align: right">
14</p>

   </td>
   <td><p style="text-align: right">
20</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td><p style="text-align: right">
54</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
6</p>

   </td>
   <td><p style="text-align: right">
182</p>

   </td>
   <td>
   </td>
   <td>borough
   </td>
   <td><p style="text-align: right">
15</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
60</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
6.7</p>

   </td>
   <td><p style="text-align: right">
13</p>

   </td>
   <td>
   </td>
   <td>borough
   </td>
   <td><p style="text-align: right">
18</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
4.5</p>

   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
297</p>

   </td>
   <td>
   </td>
   <td>borough
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
34</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td><p style="text-align: right">
681</p>

   </td>
   <td>
   </td>
   <td>campus
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
6</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
9</p>

   </td>
   <td><p style="text-align: right">
2054</p>

   </td>
   <td>
   </td>
   <td>campus
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
165</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td><p style="text-align: right">
2302</p>

   </td>
   <td>
   </td>
   <td>campus
   </td>
   <td><p style="text-align: right">
13</p>

   </td>
   <td><p style="text-align: right">
22705</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
5.6</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td><p style="text-align: right">
26558</p>

   </td>
   <td>
   </td>
   <td>campus
   </td>
   <td><p style="text-align: right">
14</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
6</p>

   </td>
   <td><p style="text-align: right">
37206</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
68889</p>

   </td>
   <td>
   </td>
   <td>campus
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
6.1</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>localadmin
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td><p style="text-align: right">
9</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
6.7</p>

   </td>
   <td><p style="text-align: right">
6</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
1.7</p>

   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td>
   </td>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
78</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
9</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td>
   </td>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
13</p>

   </td>
   <td><p style="text-align: right">
970</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td><p style="text-align: right">
33</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
2.1</p>

   </td>
   <td><p style="text-align: right">
14</p>

   </td>
   <td>
   </td>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
14</p>

   </td>
   <td><p style="text-align: right">
89</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
8.7</p>

   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
2.5</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td>
   </td>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
15</p>

   </td>
   <td><p style="text-align: right">
46</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
9</p>

   </td>
   <td><p style="text-align: right">
76</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
2.7</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td>
   </td>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
16</p>

   </td>
   <td><p style="text-align: right">
9</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td><p style="text-align: right">
112</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td><p style="text-align: right">
34</p>

   </td>
   <td>
   </td>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
17</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
3.7</p>

   </td>
   <td><p style="text-align: right">
30</p>

   </td>
   <td>
   </td>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
21</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
312</p>

   </td>
   <td>
   </td>
   <td>macrohood
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
4.7</p>

   </td>
   <td><p style="text-align: right">
27</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
3.5</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
450</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
14</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
5.1</p>

   </td>
   <td><p style="text-align: right">
165</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
13</p>

   </td>
   <td><p style="text-align: right">
81</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
4.5</p>

   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
5.6</p>

   </td>
   <td><p style="text-align: right">
400</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
14</p>

   </td>
   <td><p style="text-align: right">
255</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
5.7</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
15</p>

   </td>
   <td><p style="text-align: right">
604</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
6.5</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
6</p>

   </td>
   <td><p style="text-align: right">
1787</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
16</p>

   </td>
   <td><p style="text-align: right">
1021</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
6.1</p>

   </td>
   <td><p style="text-align: right">
563</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
17</p>

   </td>
   <td><p style="text-align: right">
33</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
6.7</p>

   </td>
   <td><p style="text-align: right">
2044</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
18</p>

   </td>
   <td><p style="text-align: right">
25</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td><p style="text-align: right">
35</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
2512</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td><p style="text-align: right">
19</p>

   </td>
   <td><p style="text-align: right">
89</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
3.7</p>

   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td><p style="text-align: right">
3294</p>

   </td>
   <td>
   </td>
   <td>microhood
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
9</p>

   </td>
   <td><p style="text-align: right">
12118</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td><p style="text-align: right">
70</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
4.7</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td><p style="text-align: right">
10441</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td><p style="text-align: right">
2</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
16</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td><p style="text-align: right">
295462</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
2.5</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
6</p>

   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
3845767</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
6.7</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
13</p>

   </td>
   <td><p style="text-align: right">
73875</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
34</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
14</p>

   </td>
   <td><p style="text-align: right">
84</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
15</p>

   </td>
   <td><p style="text-align: right">
110</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
5.1</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
  </tr>
  <tr>
   <td>empire
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
16</p>

   </td>
   <td><p style="text-align: right">
9</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
5.6</p>

   </td>
   <td><p style="text-align: right">
4</p>

   </td>
  </tr>
  <tr>
   <td>macrocounty
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
148</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
17</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
6</p>

   </td>
   <td><p style="text-align: right">
6</p>

   </td>
  </tr>
  <tr>
   <td>macrocounty
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
20</p>

   </td>
   <td><p style="text-align: right">
792</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
6.1</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>macroregion
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td><p style="text-align: right">
78</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td><p style="text-align: right">
30</p>

   </td>
   <td><p style="text-align: right">
18702</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
6.7</p>

   </td>
   <td><p style="text-align: right">
11</p>

   </td>
  </tr>
  <tr>
   <td>macroregion
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td>
   </td>
   <td>locality
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
15</p>

   </td>
  </tr>
  <tr>
   <td>macroregion
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td><p style="text-align: right">
16</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td><p style="text-align: right">
24</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
9</p>

   </td>
   <td><p style="text-align: right">
79</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
32</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td><p style="text-align: right">
43</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
13</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td><p style="text-align: right">
741</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
5.7</p>

   </td>
   <td><p style="text-align: right">
44</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
14937</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
6</p>

   </td>
   <td><p style="text-align: right">
74</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
13</p>

   </td>
   <td><p style="text-align: right">
11515</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
13</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
14</p>

   </td>
   <td><p style="text-align: right">
21666</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
7.6</p>

   </td>
   <td><p style="text-align: right">
59</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
14.5</p>

   </td>
   <td><p style="text-align: right">
189</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
7.7</p>

   </td>
   <td><p style="text-align: right">
36</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
15</p>

   </td>
   <td><p style="text-align: right">
162012</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
7.8</p>

   </td>
   <td><p style="text-align: right">
23</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
15.2</p>

   </td>
   <td><p style="text-align: right">
776</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
15.5</p>

   </td>
   <td><p style="text-align: right">
350</p>

   </td>
  </tr>
  <tr>
   <td>marketarea
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
16</p>

   </td>
   <td><p style="text-align: right">
6556</p>

   </td>
  </tr>
  <tr>
   <td>ocean
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
16.5</p>

   </td>
   <td><p style="text-align: right">
761</p>

   </td>
  </tr>
  <tr>
   <td>planet
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
17</p>

   </td>
   <td><p style="text-align: right">
1499</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
2</p>

   </td>
   <td><p style="text-align: right">
72</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
18</p>

   </td>
   <td><p style="text-align: right">
372</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
3</p>

   </td>
   <td><p style="text-align: right">
28</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
19</p>

   </td>
   <td><p style="text-align: right">
279</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
4</p>

   </td>
   <td><p style="text-align: right">
121</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
20</p>

   </td>
   <td><p style="text-align: right">
71</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
4.5</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
21</p>

   </td>
   <td><p style="text-align: right">
17</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
4.6</p>

   </td>
   <td><p style="text-align: right">
112</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
26</p>

   </td>
   <td><p style="text-align: right">
1</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
4.7</p>

   </td>
   <td><p style="text-align: right">
83</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>neighbourhood
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
5</p>

   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
6</p>

   </td>
   <td><p style="text-align: right">
130</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
6.6</p>

   </td>
   <td><p style="text-align: right">
335</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
6.7</p>

   </td>
   <td><p style="text-align: right">
301</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
272</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
7.7</p>

   </td>
   <td><p style="text-align: right">
516</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td><p style="text-align: right">
821</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
8.7</p>

   </td>
   <td><p style="text-align: right">
323</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
9</p>

   </td>
   <td><p style="text-align: right">
503</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
10</p>

   </td>
   <td><p style="text-align: right">
715</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
11</p>

   </td>
   <td><p style="text-align: right">
647</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
18</p>

   </td>
   <td><p style="text-align: right">
113</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>timezone
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>unknown
   </td>
   <td>
   </td>
   <td><p style="text-align: right">
0</p>

   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>


_NOTE: The zoom ranges in the table above are for standard 256 px sized tiles, which map to the following [natural scales](https://kelsocartography.com/blog/?p=2407) and match Leaflet and Google Maps. When viewed in the Mapbox or MapLibre rendering library the zooms will be offset by 1 due to their assumption about 512 px size._


### Improving WOF data coverage and quality

As human population grows (and declines) so the world’s heart beats, and so our work as gazetteer maintainers carries on – by both “[repainting](https://www.goldengate.org/bridge/bridge-maintenance/painting-the-bridge/)” and “touching up” the data.

Our top two priorities in 2023 are:



1. Improve locality coverage in India, and
2. expand localadmin coverage globally

We expect to land the India locality coverage by June this year with polygons for most localities and points for smaller rural villages.

Our localadmin efforts are largely focused on achieving complete coverage in Europe, introducing localadmin coverage in Africa, and expand localadmin coverage in Asia and South America.

Priority countries (blue outlines below) include: Indonesia, Mexico, Ireland, Portugal, Belgium, and Luxembourg. An additional 26 countries (black outlines below) have been prioritized for minor edits or more complete imports &/or rebuilds. Please reach out to help :)



<p id="gdcalert16" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image16.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert17">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image16.png "image_tooltip")



#### Detailed plan for 2023

We have sourced for import in 2023 new data from national mapping agencies in 12 countries, potential NMA data in another 7 countries, 39 countries at the localadmin level via the geoBoundaries project, and need to review licenses on another 17 localadmin geoBoundaries countries. We’re still searching for data in several priority countries, including Costa Rica, Egypt, Peru, and Thailand.



<p id="gdcalert17" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image17.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert18">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image17.png "image_tooltip")



## For densely populated countries with complex administrative subdivisions (like in China and India), we may consider adding an optional `microcounty` placetype between county and localadmin.


## While we don’t have concrete plans for expanding `postalcode` or `constituency` coverage, if those are important to you please reach out. Two tractable problems are importing newer open polygon data for `postalcode` features in Europe and rescuing point geometry `postalcode` records that are visiting Null Island.


## Localization

Who’s On First includes name localizations ([L10n](https://en.wikipedia.org/wiki/Internationalization_and_localization)) into 494 languages. Individual language coverage ranges from rich to sparse. Major cities like [New York](https://spelunker.whosonfirst.org/id/85977539/) are translated into most of the languages, but a rural locality is probably only provided in the local language and translated into English and/or the latin character set.

While the source GeoJSON and SQLite distribution include all languages, for Shapefiles we provide a more ergonomic experience by pre-joining the SPR to the names table to include the default and 25 more localized names, when available, for:



* _Arabic, Bengali, Chinese (simplified and/or traditional), Dutch, English, Farsi, French, German, Greek, Hebrew, Hindi, Hungarian, Indonesian, Italian, Japanese, Korean, Polish, Portuguese, Russian, Spanish, Swedish, Turkish, Ukrainian, Urdu, and Vietnamese_

Who’s On First [uses](https://github.com/whosonfirst/whosonfirst-names#rfc-5646-bcp-47-comformance) the RFC 5646 / BCP-47 [language indications](https://www.loc.gov/standards/iso639-2/php/code_list.php) for names to specify a 3-character code for the name translations, like `name:{language}_x_preferred` in the GeoJSON and `name_{locale}` in the Shapefiles. For example, English is stored as `name:eng_x_preferred` in the GeoJSON and `name_eng` in the Shapefiles.

The list of supported Shapefile languages is adapted from [Natural Earth](https://github.com/nvkelso/natural-earth-vector/tree/master/tools/wikidata#supported-languages--now-26) and [Tilezen's](https://github.com/tilezen/vector-datasource/blob/master/docs/SEMANTIC-VERSIONING.md#languages-are-not-versioned) list of core languages. Arabic, Chinese, English, French, Russian and Spanish are used by the United Nations for meetings and official documents. The other languages listed are either proposed as an official language of the United Nations (Bengali, Hindi, Portuguese, and Turkish) or frequently used in OpenStreetMap, Who's On First, or Wikipedia.

If you need to discern the “local” name for a given place record, the parent `country` record indicates [official](https://github.com/whosonfirst/whosonfirst-properties/tree/main/properties/wof#lang_x_official) and/or [spoken language](https://github.com/whosonfirst/whosonfirst-properties/tree/main/properties/wof#lang_x_spoken) codes. In some countries the parent `region` (or `macroregion`) record will also indicate language preferences (like [Catalonia](https://spelunker.whosonfirst.org/id/404227379/) in [Spain](https://spelunker.whosonfirst.org/id/85633129/)), which can allow for local variations.

By current WOF convention, a feature’s default name is stored in ASCII-7 English. For latin script based languages you can maximize localized name coverage by coalescing `name:{lang}_x_preferred`, `name:eng_x_preferred`, and `wof:name`. Specific coalesce logic depends on your application and the locale(s) used by your audience.


### Localized name coverage by placetype

By convention, Who’s On First tracks a single “preferred” name spelling per language for a place. Because of the many different ways to [translate and/or transliterate](https://www.oneskyapp.com/blog/translation-vs-transliteration-vs-transcription/#:~:text=The%20sole%20purpose%20of%20translation,that%20make%20up%20each%20word.) a place’s name from one language into another WOF also allows multiple “variant” names per language. Some languages have formalized rules for transliterating into another, but those rules can evolve over longer spans of time (e.g. romanization of [Chinese](https://en.wikipedia.org/wiki/Romanization_of_Chinese)) and generate time and system variants. Languages without formalized transliteration rules can organically generate even more variants.

The large variation in names is one of the reasons gazetteers like Who’s On First assign unique IDs for our features and, when we discern a match in another gazetteer, provide ID crosswalk between the “this is the same as that” features.


<table>
  <tr>
   <td>placetype
   </td>
   <td>feature count
   </td>
   <td>Preferred names in all locales
   </td>
   <td>Preferred in Shapefile locales
   </td>
   <td>Alternate names in all locales
   </td>
   <td>Alternate names in Shapefile locales
   </td>
  </tr>
  <tr>
   <td>borough
   </td>
   <td><p style="text-align: right">
467</p>

   </td>
   <td><p style="text-align: right">
5,897</p>

   </td>
   <td><p style="text-align: right">
3,225</p>

   </td>
   <td><p style="text-align: right">
881</p>

   </td>
   <td><p style="text-align: right">
847</p>

   </td>
  </tr>
  <tr>
   <td>campus
   </td>
   <td><p style="text-align: right">
24,452</p>

   </td>
   <td><p style="text-align: right">
106,282</p>

   </td>
   <td><p style="text-align: right">
75,138</p>

   </td>
   <td><p style="text-align: right">
39,862</p>

   </td>
   <td><p style="text-align: right">
39,066</p>

   </td>
  </tr>
  <tr>
   <td>continent
   </td>
   <td><p style="text-align: right">
8</p>

   </td>
   <td><p style="text-align: right">
1,887</p>

   </td>
   <td><p style="text-align: right">
270</p>

   </td>
   <td><p style="text-align: right">
91</p>

   </td>
   <td><p style="text-align: right">
22</p>

   </td>
  </tr>
  <tr>
   <td>country
   </td>
   <td><p style="text-align: right">
232</p>

   </td>
   <td><p style="text-align: right">
53,977</p>

   </td>
   <td><p style="text-align: right">
7,756</p>

   </td>
   <td><p style="text-align: right">
13,493</p>

   </td>
   <td><p style="text-align: right">
4,218</p>

   </td>
  </tr>
  <tr>
   <td>county
   </td>
   <td><p style="text-align: right">
47,431</p>

   </td>
   <td><p style="text-align: right">
1,046,479</p>

   </td>
   <td><p style="text-align: right">
481,357</p>

   </td>
   <td><p style="text-align: right">
125,178</p>

   </td>
   <td><p style="text-align: right">
108,200</p>

   </td>
  </tr>
  <tr>
   <td>dependency
   </td>
   <td><p style="text-align: right">
43</p>

   </td>
   <td><p style="text-align: right">
5,228</p>

   </td>
   <td><p style="text-align: right">
1,214</p>

   </td>
   <td><p style="text-align: right">
1,702</p>

   </td>
   <td><p style="text-align: right">
908</p>

   </td>
  </tr>
  <tr>
   <td>disputed
   </td>
   <td><p style="text-align: right">
104</p>

   </td>
   <td><p style="text-align: right">
6,088</p>

   </td>
   <td><p style="text-align: right">
2,379</p>

   </td>
   <td><p style="text-align: right">
914</p>

   </td>
   <td><p style="text-align: right">
604</p>

   </td>
  </tr>
  <tr>
   <td>empire
   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
2,370</p>

   </td>
   <td><p style="text-align: right">
237</p>

   </td>
   <td><p style="text-align: right">
12</p>

   </td>
   <td><p style="text-align: right">
12</p>

   </td>
  </tr>
  <tr>
   <td>localadmin
   </td>
   <td><p style="text-align: right">
203,513</p>

   </td>
   <td><p style="text-align: right">
2,170,698</p>

   </td>
   <td><p style="text-align: right">
1,187,815</p>

   </td>
   <td><p style="text-align: right">
259,808</p>

   </td>
   <td><p style="text-align: right">
243,505</p>

   </td>
  </tr>
  <tr>
   <td>locality
   </td>
   <td><p style="text-align: right">
4,498,136</p>

   </td>
   <td><p style="text-align: right">
22,396,047</p>

   </td>
   <td><p style="text-align: right">
12,908,288</p>

   </td>
   <td><p style="text-align: right">
6,869,767</p>

   </td>
   <td><p style="text-align: right">
5,000,119</p>

   </td>
  </tr>
  <tr>
   <td>macrocounty
   </td>
   <td><p style="text-align: right">
482</p>

   </td>
   <td><p style="text-align: right">
13,908</p>

   </td>
   <td><p style="text-align: right">
6,965</p>

   </td>
   <td><p style="text-align: right">
1,281</p>

   </td>
   <td><p style="text-align: right">
1,251</p>

   </td>
  </tr>
  <tr>
   <td>macrohood
   </td>
   <td><p style="text-align: right">
1,272</p>

   </td>
   <td><p style="text-align: right">
10,067</p>

   </td>
   <td><p style="text-align: right">
5,882</p>

   </td>
   <td><p style="text-align: right">
1,641</p>

   </td>
   <td><p style="text-align: right">
1,616</p>

   </td>
  </tr>
  <tr>
   <td>macroregion
   </td>
   <td><p style="text-align: right">
117</p>

   </td>
   <td><p style="text-align: right">
9,227</p>

   </td>
   <td><p style="text-align: right">
2,600</p>

   </td>
   <td><p style="text-align: right">
789</p>

   </td>
   <td><p style="text-align: right">
418</p>

   </td>
  </tr>
  <tr>
   <td>marinearea
   </td>
   <td><p style="text-align: right">
402</p>

   </td>
   <td><p style="text-align: right">
16,438</p>

   </td>
   <td><p style="text-align: right">
7,264</p>

   </td>
   <td><p style="text-align: right">
1,609</p>

   </td>
   <td><p style="text-align: right">
1,063</p>

   </td>
  </tr>
  <tr>
   <td>marketarea
   </td>
   <td><p style="text-align: right">
210</p>

   </td>
   <td><p style="text-align: right">
4,771</p>

   </td>
   <td><p style="text-align: right">
1,577</p>

   </td>
   <td><p style="text-align: right">
433</p>

   </td>
   <td><p style="text-align: right">
433</p>

   </td>
  </tr>
  <tr>
   <td>microhood
   </td>
   <td><p style="text-align: right">
2,127</p>

   </td>
   <td><p style="text-align: right">
9,316</p>

   </td>
   <td><p style="text-align: right">
6,669</p>

   </td>
   <td><p style="text-align: right">
2,910</p>

   </td>
   <td><p style="text-align: right">
2,859</p>

   </td>
  </tr>
  <tr>
   <td>neighbourhood
   </td>
   <td><p style="text-align: right">
233,712</p>

   </td>
   <td><p style="text-align: right">
1,482,405</p>

   </td>
   <td><p style="text-align: right">
852,647</p>

   </td>
   <td><p style="text-align: right">
318,119</p>

   </td>
   <td><p style="text-align: right">
288,618</p>

   </td>
  </tr>
  <tr>
   <td>ocean
   </td>
   <td><p style="text-align: right">
7</p>

   </td>
   <td><p style="text-align: right">
1,504</p>

   </td>
   <td><p style="text-align: right">
238</p>

   </td>
   <td><p style="text-align: right">
107</p>

   </td>
   <td><p style="text-align: right">
37</p>

   </td>
  </tr>
  <tr>
   <td>planet
   </td>
   <td><p style="text-align: right">
1</p>

   </td>
   <td><p style="text-align: right">
258</p>

   </td>
   <td><p style="text-align: right">
26</p>

   </td>
   <td><p style="text-align: right">
29</p>

   </td>
   <td><p style="text-align: right">
17</p>

   </td>
  </tr>
  <tr>
   <td>region
   </td>
   <td><p style="text-align: right">
5,139</p>

   </td>
   <td><p style="text-align: right">
269,007</p>

   </td>
   <td><p style="text-align: right">
109,135</p>

   </td>
   <td><p style="text-align: right">
33,508</p>

   </td>
   <td><p style="text-align: right">
23,478</p>

   </td>
  </tr>
  <tr>
   <td>timezone
   </td>
   <td><p style="text-align: right">
376</p>

   </td>
   <td><p style="text-align: right">
753</p>

   </td>
   <td><p style="text-align: right">
752</p>

   </td>
   <td><p style="text-align: right">
380</p>

   </td>
   <td><p style="text-align: right">
380</p>

   </td>
  </tr>
  <tr>
   <td>TOTALS
   </td>
   <td><p style="text-align: right">
5,018,243</p>

   </td>
   <td><p style="text-align: right">
27,612,607</p>

   </td>
   <td><p style="text-align: right">
15,661,434</p>

   </td>
   <td><p style="text-align: right">
7,672,514</p>

   </td>
   <td><p style="text-align: right">
5,717,671</p>

   </td>
  </tr>
</table>



### Localized name coverage by language

The most common language in Who’s On First is English, followed by Chinese, and French. Rounding out the top 10 in ranked order are Russian, German, Dutch, Swedish, Spanish, Italian, and Polish.

The table below only includes the top 37 languages. A total of 63 languages have more than 100,000 preferred names. Another 45 languages have more than 50,000 preferred names.



<p id="gdcalert18" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image18.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert19">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image18.png "image_tooltip")


_NOTE: The default language for `wof:name` is English, so almost all records include an implicit default English name and many also include an explicit localized English name. The Cebuano localizations are largely from a Wikipedia bot and are suspect so not included in the stats above. The Norwegian language uses multiple codes, including: `nno`, `nob`, and `nor`. _


## Internationalization

For internationalization ([i18n](https://en.wikipedia.org/wiki/Internationalization_and_localization)), we track 104 “disputed” territories (polygons between countries for contested areas) around the world, and Who’s On First hold hands with Natural Earth allowing you to make use of their extensive catalog of pairwise points-of-view.

Disputed placetype records include an optional [`mz:hieararchy_label`](https://github.com/whosonfirst/whosonfirst-properties/tree/main/properties/mz#hierarchy_label)” property (and related properties for each ancestor level in the placetype hierarchy) to indicate if place records that reverse geocode within the disputed area should include full, any, or partial text strings for that record's ancestors. For example, [Western Sahara](https://spelunker.whosonfirst.org/id/1159339507/) which, assuming a reverse geocoder like Pelias has implemented the flag, won’t include text for country or region ancestors but will allow showing locality names. We recommend using the Natural Earth point-of-views to localize the hierarchy label properties (e.g. to allow viewers within Morocco to also see country and region ancestor details).


<p id="gdcalert19" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image19.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert20">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image19.png "image_tooltip")



## Open Data

Who’s On First’s permissive, [attribution required](https://github.com/whosonfirst-data/whosonfirst-data/blob/master/LICENSE.md) ([CC-BY](https://creativecommons.org/licenses/by/4.0/) equivalent) open license means you can use the data however you want (including for commercial purposes), as long as you provide credit somewhere in your map or app.

Crediting the Who's On First project is required because some of the open data projects that WOF aggregates require attribution. Linking back to the License is required in [hypermedia](https://en.wikipedia.org/wiki/Hypermedia) projects.

For example, on a website or in an app’s about page, you should also include the License hyperlink:

> Data from Who's On First. [License](https://whosonfirst.org/docs/licenses/).

For example, in a web map’s sources (displayed on the map), hyperlinked to the License:

> [Who's On First](https://whosonfirst.org/docs/licenses/)

Where the “License” text (or project name) hyperlinks either to the whosonfirst.org hosted license page, or to a detailed data licenses page (or section of your terms of service) on your web site or in your app. At that location, you must credit the Who’s On First sources that require attribution. It may be more practical to credit both Who’s On First and all of our sources – it’s the kind thing to do.

For stand alone print maps, a simple text credit to the project will suffice:

> Who's On First

If the map is included in a book or atlas publication then the data credits section should also repeat the Who’s On First credit and the web link (https://whosonfirst.org/docs/licenses/).


## Sources

The Who's On First dataset is both an original work and a modification of existing open data. The WOF gazetteer includes data from 360 sources. There are 139 primary sources, 188 additional sources via Quattroshapes, Mesoshapes, and other aggregators, and 33 concordance-only sources.

Sources include national mapping agencies in: [United States](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#united-states-census-bureau) (US Census), [Australia](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#australian-government-open-data-portal) (PSMA and ABS), [Austria](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#austria-open-data), [Belgium](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#voorlopig-referentiebestand-gemeentegrenzen) (Geopunt), Brazil (IBGE via [Quattroshapes](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#quattroshapes)), Canada (multiple, including Census Canada and Statistics Canada), [Denmark](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#geodanmark), [Estonia](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#republic-of-estonias-land-board-geoportal) (Land Board), [Finland](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#nls-national-land-survey-of-finland) (National Land Survey), [France](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#open-data-france) (IGN), [Germany](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#bundesamt-fur-kartographie-und-geodasie) (BKG), [Ireland](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#ordnance-survey-ireland) (Ordnance Survey), Italy (IGN via [Quattroshapes](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#quattroshapes)), [Japan](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#mesoshapes) (GSI), [Mexico](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#instituto-nacional-de-estad%C3%ADstica-y-geograf%C3%ADa-inegi) (INEGI and IGN), [Netherlands](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#centraal-bureau-voor-de-statistiek) (CBS and NLD Kadaster), [New Zealand](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#land-information-new-zealand) (LINZ), [Norway](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#geonorge-norway) (Geonorge), [Poland](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#office-of-geodesy-and-cartography-poland) (GUGIK), [Portugal](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#directorate-general-for-the-territorial-development-of-portugal) (DG Territorio), [Romania](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#romanian-national-agency-for-cadastre-and-land-registration-ancpi) (ANCPI), Spain (IGN via [Quattroshapes](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#quattroshapes)), [Sweden](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#lantmateriet-sweden) (Lantmateriet), [Singapore](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#singapore-open-data-portal), [Slovenia](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#surveying-and-mapping-authority-of-the-republic-of-slovenia) (EPG), [South Africa](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#the-municipal-demarcation-board-of-south-africa) (NBC and Municipal Demarcation Board), [Switzerland](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#swisstopo) (SwissTopo), and [United Kingdom](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#ordnance-survey) (Ordnance Survey).

Other global sources include: [GeoNames](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#geonames), Yahoo’s [GeoPlanet](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#yahoo-geoplanet), Foursquare’s [Quattroshapes](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#quattroshapes), and Mapzen’s [Mesoshapes](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md#mesoshapes). Several of our founders and core contributors were instrumental in these other projects.

We detail all sources and their specific license, usage, and vintage metadata in the full [sources list](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md).


## Concordances

WOF includes a large number of concordances to allow our project to “hold hands” with other datasets – individual WOF records link to specific features in other open and closed gazetteer projects.

Not all sources include concordances, but when they do we indicate in the condances section the dataset prefix (like `gn` for GeoNames and `wd` for Wikidata) and the name of the unique identifier that project uses (mostly `id`, so put together `gn:id` and `wd:id` fully qualified property names).

Who’s On First tracks our sources in the [sources](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md) repo. Besides the concordances, WOF also notes the source for each geometry in the “[src:geom](https://github.com/whosonfirst/whosonfirst-properties/blob/main/properties/src/README.md#geom)” property (using the JSON “name” of the source) and imported properties from that source will have their name prepended with the “prefix” in the source’s JSON file. This is _mostly_ machine readable today and we’re working to make it fully machine readable soon.

_(below) Use the [sources list](https://github.com/whosonfirst/whosonfirst-sources/blob/main/sources/README.md) to decode the source project prefixes used in the following table._



<p id="gdcalert20" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image20.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert21">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image20.png "image_tooltip")



## Applications

When the Who’s On First (WOF) gazetteer started in 2015 we partnered closely with **[Pelias](https://pelias.io/)**, another [Mapzen](https://www.mapzen.com/) project, to ensure our big list of places could power:

* **Search** for forward geocoding based on full name string input and type-ahead “autocomplete” based on partial string matching per keystroke
* **Hierarchy** lookup allowing a place’s parent and other ancestors to be reverse geocoding from a given latitude, longitude input. Specific attention was paid to disputed territories and which hierarchy components should be masked in a reverse geocoding lookup.
* **Single feature display** with label centroids for polygons, label bounding boxes, detailed polygons.
* **Metrics logging** is possible because of WOF’s stable unique IDs – to turn data exhaust into insights about customer usage patterns.

The results of a search can then be pipped to **[Valhalla](https://valhalla.github.io/valhalla/)**, another [Mapzen](https://www.mapzen.com/) project for:

* **Routing** with polygon navigation and label “centroids” that are close to a place’s urban center rather than the math centroid of the polygon, and guaranteed to be on land.

All these [Mapzen](https://www.mapzen.com/) projects ([Who’s On First](https://www.whosonfirst.org/), [Pelias](https://pelias.io/), and [Valhalla](https://valhalla.github.io/valhalla/)) are now part of the [Linux Foundation](https://www.linuxfoundation.org/) and are free for anyone to use and adapt.


### Future applications looking for collaboration and funding

* **Map display for label points**
    * **Label min zoom and label max zooms** exist but can to be fine tuned for global, multi-zoom basemaps (especially for county and locality placetypes)
    * **Population estimate** coverage expansion to determine relative label zoom and townspot size grading
* **Map display for thematic polygons**
    * **Min zoom and max zoom **variable per placetype and per country with area grading for a composite global, multi-zoom basemap
    * **Vector tilesets** (global and per placetype) with newer tools like [Tippicanoe](https://github.com/felt/tippecanoe) and [Planetiler](https://github.com/onthegomap/planetiler) delivered as serverless [PMTiles](https://protomaps.com/docs/pmtiles) archives
    * **Edge matching **of boundaries between countries
    * **Land clipping** of boundaries inside countries for terrestrial land mass. This is a partially addressed problem in the USA for data from the US Census, and sometimes occurs in Europe
    * **Quality checks** to ensure no feature dupes between placetypes (e.g. `localadmin` paired with `locality,` and `neighbourhood` paired with `localadmin`) and that historical features are marked not current
* **Single feature display**
    * **Preview polygons** with pre-cached, small “200 kb” display ready alternate geometries as existing default polygon geometries vary widely in size from a few KB to more than 50 MB. These are useful for displaying search results with a polygon (not just with a centroid zoomed to the bounding box).
* **Hierarchy**
    * **Disputed point-of-view:** For administrative hierarchy, further work to power “point-of-view” on the hierarchy masks, can be adapted from [Natural Earth](https://github.com/nvkelso/natural-earth-vector)’s efforts for automated reverse geocoding so users in various countries get locally adjusted polygon data instead of globally masked data
* **Routing**
    * **Intersect with urbanized landcover** to ensure feature point geometries are inside urban areas and polygon feature’s navigation points are in the place’s urban center (ideally downtown)
* **Placetypes**
    * Expand **localadmin** placetypes globally (see section above)
    * Update **United States** placetypes for Census 2020 data releases
    * Update **European** placetypes for newer data releases, including in Germany, France, and Netherlands.
    * Add **Indonesia** placetypes for newer data releases
    * Add **Vietnam** placetypes for newer data releases
    * Update **Brazil** placetypes for newer data releases
    * Update **Mexico** placetypes for newer data releases
    * Expand **postalcode** polygon coverage using latest open map data, especially in Europe
    * Expand **constituency** coverage outside of the USA using latest open map data
    * Add **statistical aggregations** like NUTS and US Census
    * Add **metropolitan/micropolitan/rural area** globally using original research
    * Add **colloquial areas** (like [Outer Banks](https://en.wikipedia.org/wiki/Outer_Banks)) via crowdsourcing


### Example applications by placetype

When decomposing address data into placetypes (using [libPostal](https://www.mapzen.com/blog/inside-libpostal/), an [OpenAI prompt](https://help.openai.com/en/articles/6654000-best-practices-for-prompt-engineering-with-openai-api), or another tool), it can be helpful to think how those strings can geo match to Who’s On First records.


<table>
  <tr>
   <td><strong>Decomposing Data…</strong>
   </td>
   <td><strong>… into Data Sources</strong>
   </td>
  </tr>
  <tr>
   <td>

<p id="gdcalert21" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image21.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert22">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image21.png" width="" alt="alt_text" title="image_tooltip">
<strong> \
<em>(note alt text)</em></strong>
   </td>
   <td>

<p id="gdcalert22" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image22.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert23">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image22.png" width="" alt="alt_text" title="image_tooltip">

<p>
<em>(note alt text)</em>
   </td>
  </tr>
</table>


Who’s On First is a “coarse” geocoder meaning it doesn’t provide street level features. But WOF data can be complemented (as [Pelias](https://pelias.io/) does) with data from other open data projects, including: [OpenAddresses](https://openaddresses.io/), [All The Places](https://www.alltheplaces.xyz/), [Natural Earth](https://www.naturalearthdata.com/), and even the ODbL licensed [OpenStreetMap](https://www.openstreetmap.org/) for a complete geocoding solution.

If you need to process and deduplicate venue data using latitude, longitude, name, and address information we also recommend **Lieu** ([code repo](https://www.google.com/url?q=https://github.com/openvenues/lieu&sa=D&source=docs&ust=1683617097731000&usg=AOvVaw2SUCPfeg6V2psGlnlqVhpV) and [blog post](https://www.google.com/url?q=https://www.mapzen.com/blog/whosonfirst-sotmus-2017/&sa=D&source=docs&ust=1683617042484978&usg=AOvVaw1tGT3BA6tT-9cyb-aqOwsb)).


<table>
  <tr>
   <td><strong>Source</strong>
   </td>
   <td><strong>Precision</strong>
   </td>
   <td><strong>Component</strong>
   </td>
   <td><strong>Example</strong>
   </td>
  </tr>
  <tr>
   <td><strong>Who’s On First</strong> and  \
All The Places and
<p>
OpenStreetMap
   </td>
   <td>Exact
   </td>
   <td><p style="text-align: right">
Venue</p>

   </td>
   <td>Some Business
   </td>
  </tr>
  <tr>
   <td>OpenAddresses and \
All The Places and
<p>
OpenStreetMap
   </td>
   <td>Exact
   </td>
   <td><p style="text-align: right">
Street number</p>

   </td>
   <td>155
   </td>
  </tr>
  <tr>
   <td>OpenStreetMap
   </td>
   <td>Fine
   </td>
   <td><p style="text-align: right">
Street name</p>

   </td>
   <td>9th Street
   </td>
  </tr>
  <tr>
   <td><strong>Who’s On First</strong>
   </td>
   <td>Course
   </td>
   <td><p style="text-align: right">
Locality</p>

   </td>
   <td>San Francisco
   </td>
  </tr>
  <tr>
   <td><strong>Who’s On First</strong> and \
Natural Earth
   </td>
   <td>Course
   </td>
   <td><p style="text-align: right">
Region</p>

   </td>
   <td>CA \
(short code for California)
   </td>
  </tr>
  <tr>
   <td> <strong>Who’s On First</strong>
   </td>
   <td>Course
   </td>
   <td><p style="text-align: right">
Postcode</p>

   </td>
   <td>94131
   </td>
  </tr>
  <tr>
   <td>OpenAddresses
   </td>
   <td>Fine
   </td>
   <td><p style="text-align: right">
Postcode+4</p>

   </td>
   <td>0123
   </td>
  </tr>
  <tr>
   <td><strong>Who’s On First</strong> and \
Natural Earth
   </td>
   <td>Course
   </td>
   <td><p style="text-align: right">
Country</p>

   </td>
   <td>USA \
(short code for United States of America)
   </td>
  </tr>
</table>


_NOTE: While our WOF gazetteer does include 21M venue records they are of an older vintage and do not reflect closed venues or recently opened venues. Depending on your needs, it may be better to use _[All The Places](https://www.alltheplaces.xyz/)_ (scraper project for international, national, and regional chains), _[OpenStreetMap](https://www.openstreetmap.org/)_ (caveat ODbL license restrictions), or license data from proprietary sources including [Foursquare](https://foursquare.com/)_, _[SafeGraph](https://www.safegraph.com/)_, [TripAdvisor](https://www.tripadvisor.com/) or [others](https://www.safegraph.com/guides/openstreetmap-api-alternative). Postalcode polygon country coverage can be augmented with proprietary sources like [MBI](https://www.mbi-geodata.com/en/area-boundaries/postcode-zip-boundary-maps/).


## Collaboration

Most people engage with the project by downloading and “reading” the data. In the course of using the data, you might find a few tools helpful both for finding specific records and for editing them to fix small problems in the data (like a misspelled name).



<p id="gdcalert23" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image23.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert24">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image23.png "image_tooltip")



### View Who’s On First records

The **[Spelunker](https://spelunker.whosonfirst.org/)** is a web tool for browsing Who’s On First and includes search functionality. For example: [view New York](https://spelunker.whosonfirst.org/id/85977539/) city.

You can also View raw data on **[Github](https://github.com/whosonfirst-data/)**. Because navigating the many `whosonfirst-data` repos can be overwhelming, each individual WOF record self describes in which repo it can be found. For example, [view New York](https://github.com/whosonfirst-data/whosonfirst-data-admin-us/blob/master/data/859/775/39/85977539.geojson) city as raw GeoJSON.


### Editing of Who’s On First records

We use **[Write Field](https://writefield.nextzen.org/)** for quick property data edits. For example, [load New York city for editing](https://writefield.nextzen.org/place/edit?url=https://raw.githubusercontent.com/whosonfirst-data/whosonfirst-data-admin-us/master/data/859/775/39/85977539.geojson). This requires a Github account to create a pull request which can be reviewed by the WOF team.

For more complex and bulk imports we use **[QGIS](https://qgis.org/)** and scripts to iterate over files managed in git. This workflow is described in more detail in our recent Shapefiles blog post.


## Accessibility

Who’s On First data is available to download in several formats, including:



* [Shapefiles](https://geocode.earth/data/whosonfirst/) - for GIS mappers in applications like QGIS and ArcGIS
* [SQLite](https://geocode.earth/data/whosonfirst/) - for database driven applications

_Thanks to [Geocode Earth](https://geocode.earth/) for sponsoring processing and hosting of the downloads._

While we manage Who’s On First place records as individual text files in git repos hosted on Github, from the early days we’ve made “bundled” distributions available. Those distributions were more geared for software engineers than for a more general audience of map makers and cartographers.

**[Shapefile](https://geocode.earth/data/whosonfirst/)** downloads for the Who’s On First gazetteer were added in April 2023 as per-country ZIP archives including admin (country, region, county, locality, neighbourhood & more), postalcode, and constituency placetypes. They only contain basic properties, names, and geometries.

**[SQLite](https://geocode.earth/data/whosonfirst/)** databases contain the full firehose of Who's On First data, including mixed geometry types and full set of nested GeoJSON properties. Unlike the raw GeoJSON files in the git repos, data in the SQLite databases are organized into several tables, including: _spr, names, concordances, ancestors, and geojson_. Geometries (default and alternate) are stored as properties in the _geojson_ table. The field layout of the spr table is explained in the Standard Place Response section of this blog post.


## Sponsor Who’s On First

A large project like Who’s On First relies on good will to function, some amount of organization to sustain it year to year, and funding to pay data curation, engineering development, and internet server bills.

If you or your organization relies on Who’s On First please considering sponsoring us with a recurring or one-time donation:



* [Open Collective](https://opencollective.com/whosonfirst)
* [Github Sponsorship](https://github.com/sponsors/whosonfirst)
* [Linux Foundation Crowdfunding](https://crowdfunding.lfx.linuxfoundation.org/projects/whosonfirst) can also process custom corporate donations


## Contact Who’s On First

If you have feedback, please submit a [new issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/new) or [discussion](https://github.com/whosonfirst-data/whosonfirst-data/discussions/new/choose) topic via Github.

[Subscribe to WOF Announcements](http://eepurl.com/ipOxd2) for "big news", via Mailchimp. Frequency is a few times per year. Subscribe now and you'll be first to know about our big India locality data drop!

Join our new [WOF Gazetteer discussion group](https://groups.google.com/g/wof-gazetteer) on Google to ask questions and share updates on your country's latest changes to its internal administrative subdivisions. If you're a geography geek, this one's for you.


## Conclusion

Open gazetteers, including Who’s On First, have come a long way in the last 10 years – largely because of the success of the global open data movement. To the many people who have advocated with your local or national government to “free” this bounty of data, thank you!

Administrative borders are rarely “visible on the ground” and gazetteers that aggregate this data remain relevant by providing important and broad access to this type of map data. Each open gazetteer project has its particular license that reflects origin stories and day-to-day workflows. At Who’s On First we’re proud to offer our data as CC-BY attribution allows both read access and commercial use – with polygons, localization, and internationalization.

Who’s On First holds hands with 360 datasets, has great name translations, with unique IDs, and has been confirmed to work in a wide range of applications, several of which have more than 300 million monthly active users globally.

While we can and will add even more data, we think there’s enough in Who’s On First for you to get started making a map or building an app today. We’re excited to see what you build!
