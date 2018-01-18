---
layout: page
date: 2017-09-19
published: true
permalink: /blog/2017/09/19/introducing-statoids/
title: Statoids, Mesoshapes, and Who's On First	
category: blog
excerpt: Check out our recent additions to the Who's On First gazetteer, including our partnership with Statoids!
authors: [stepps00, nvkelso]
image: "images/main_photo.jpg"
tag: [whosonfirst, data]
---

<div style="margin: 0 auto; width:640px;">
<a href="images/main_photo.jpg"><img src="images/main_photo.jpg" height="360" width="640" /></a>
</div>

Recently, we've been working with two datasets, **Mesoshapes**, which we've [previewed before](https://mapzen.com/blog/mesoshapes/), and **Statoids**, the premier encyclopedia of administrative subdivisions. 

We are happy to announce a partnership with Statoids to allow their data to be included in Who's On First and [Mapzen Places](https://mapzen.com/pricing/) under generous CC-BY terms. Both these datasets have been merged with existing (and new) Who's On First records and provide nearly complete global coverage at the `region` and `county` placetypes and bring in additional properties like population values and localized placetype names. Please have a read and explore our new additions!

## Mesoshapes

We previously [wrote about](https://mapzen.com/blog/mesoshapes/) our work of increasing county coverage in the [Who's On First](https://whosonfirst.mapzen.com) gazetteer. This work involved importing new, more detailed geometries for secondary administrative divisions around the globe, as well as importing more place-specific properties for each record. We have since wrapped up the Mesoshapes work and are proud to now maintain just over **46,500** `county` records in Who's On First!

This isn't all we've done; we were also able to update records for primary divisions in each country (`region` records), too. We verified and increased the accuracy of `region` records in Who's On First for each of the 110+ countries delivered by Mesoshapes, adding them to the `county` records already in Who's On First!

Recently, we've joined this work with a new dataset, [Statoids](http://www.statoids.com/), to substantially enhance our records with _many_ new properties that we would like to outline below.

## Statoids

### What exactly _is_ Statoids?

Statoids is an online database that organizes the primary and secondary administrative divisions for all countries, dependencies, and disputed areas of the world. These divisions have unique identifiers, which we call the `hasc:id` (you can read more about HASC, [here](http://www.statoids.com/ihasc.html)). The Mesoshapes import included many `hasc:id` values; by linking the HASC concordance values, we imported this encyclopedia of geographic data into Who's On First.

We've long admired Statoids for its global coverage and attention to detail. For over 15 years Gwillim Law was the force behind the printed version of [Statoids](https://www.amazon.com/exec/obidos/ASIN/0786407298/) followed by copious updates on [Statoids.com](http://www.statoids.com). We were saddened to hear of Gwillim's [passing](http://www.statoids.com/mgtletter.html) August 31, 2016. 

In talking to Gwillim's daughter Shirley over the last year we came up with a way to memorialize his work: We are happy to announce a partnership with Statoids to allow their data to be included in Who's On First under generous CC-BY terms. We hope Gwillim's work finds an even larger audience, and together we can continue the work he started. The full terms are in our [sources](https://github.com/whosonfirst/whosonfirst-sources/blob/master/sources/README.md#statoids) repo.

### What does Statoids contain?

The Statoids database has plenty of useful data that Who's On First was able to harvest. This data comes in the form of data tables, separated by parent country and administrative division; take a look at the [Statoids page for secondary divisions in Norway](http://www.statoids.com/yno.html), for an example. After crafting various Python scripts to handle the Statoids data tables, we were able to bring in a variety of new properties and concordances to Who's On First.
Below is a list of harvested data we were able to pull into Who's On First from Statoids:

**Concordances** to:

  - [Dial codes](https://en.wikipedia.org/wiki/List_of_country_calling_codes)
  - [Distinguishing sign codes](http://www.unece.org/trans/welcome.html)
  - [FIFA codes](http://www.rsssf.com/miscellaneous/fifa-codes.html)
  - [GAUL (Food and Agriculture Organization)](http://www.fao.org/geonetwork/srv/en/metadata.show?id=12691)
  - [International Olympic Committee](https://www.olympic.org/the-ioc)
  - [ISO](https://www.iso.org/home.html)
  - [Identity Radio Transmitter](https://www.itu.int/online/mm/scripts/gensel8) codes
  - [**MA**chine-**R**eadable **C**ataloging codes](http://www.loc.gov/marc/countries/cou_home.html) (MARC) from the Library of Congress
  - [World Meteorlogical Organization](http://icoads.noaa.gov/metadata/wmo47/wmo_quarterly/47CodeTables9903.html)
  - Unique identifiers (see our [whosonfirst-sources](https://github.com/whosonfirst/whosonfirst-sources) repository for more information on the `hasc:id`)
  
Properties, including:

  - Names
  - Population counts
  - Names of Capital cities and areas
  - Historical notes about each place
  - Timezones
  - Translations
  - Area (kilometers and miles, squared)
  - A brief overview of each placetype "set" per country
  - Dates of the most recent Census figures
  - Local terms for the administrative division

### Property Specifics...

We can store each property as a top-level `statoids:` property (see our [whosonfirst-property](https://github.com/whosonfirst/whosonfirst-properties) repository for detailed information on each `statoids:*` property), harvest new `name:*` properties, link capital cities to their parent(s), link timezone records to the administrative division, and build population and population-related properties from the official population counts in Statoids. 

A list of newly harvested Statoids properties, below:

- `src:population`
- `statoids:area_km`
- `statoids:area_mi`
- `statoids:capital`
- `statoids:country`
- `statoids:as_of_date`
- `statoids:hasc`
- `statoids:name`
- `statoids:population`
- `statoids:statoid`
- `statoids:timezone`
- `statoids:type`
- `wof:population`
- `wof:population_rank`
- `src:population`
- `wof:placetype_local`
- various `name:*` properties

Below you can see HASC codes and populations for Panama, Yemen, and the Central African Republic, showing the HASC code and population for both `region` and `county`, along with the localized name for the `county`. Color intensity is relative to the `region` and `county` population data. Note that we're filtering and revealing data and labels at different zoom levels -- zoom in to explore, and [open full-screen for variable zoom](/resources/blog/statoids/index.html)!

<div class="demo-wrapper" id="bike">
    <iframe src="/resources/blog/statoids/index.html"></iframe>
</div>

_[Open full-screen](/resources/blog/statoids/index.html) and [check out the scene file in Tangram Play](https://mapzen.com/tangram/play/?api=22/1018#6.167/7.403/20.723) to see how we built it. We aggregated this data using the [Who's On First Descender](https://whosonfirst.mapzen.com/spelunker/download/85632499/?exclude=nullisland)._

### Now, an example...

Let's take a look at the Who's On First record for [Queensland, Australia](https://whosonfirst.mapzen.com/spelunker/id/85681463/). Queensland gained both top-level `statoids:*` properties, as well as `wof:*`, `src:*`, and concordance properties.

Here are the new Statoids properties and how they apply to Queensland:

| Property Name | Description|
|:--|:--|
|`"statoids:country":"AU"`| The country code used by Statoids for the record's parent country (in this case, [Australia](https://whosonfirst.mapzen.com/spelunker/id/85632793/))|
|`"statoids:gec":"AS04"`| The `gec` identifier for Queensland (also stored in concordances)|
|`"statoids:hasc":"AU.QL"`| The `hasc:id` for Queensland (also stored in concordances)|
|`"statoids:iso":"QLD"`| The ISO alpha-3 code for Queensland (also stored in concordances)|
|`"statoids:name":"Queensland"`| The English, UTF-8 name for this record in Statoids|
|`"statoids:population":"4332739"`| The catalogued population for Queensland, see below|
|`"statoids:type":"state"`| What locals call this administrative division, see below|
|`"statoids:tz":"+10"`| The timezone of Queensland, represented by the difference from GMT|
|`"wof:placetype_local":"state"`| A top-level `wof:*` property, harvested from the `statoids:type` property|
|`"wof:population":4332739`| A top-level `wof:*` property, harvested from the `statoids:population` property|
|`"wof:population_rank":12`| A top-level `wof:*` property, an integer value (0-18), built from `wof:population`|
|`"src:population":"statoids"`| The source used to build `wof:population`|

## Results

As of today, Who's On First has added properties for **256** top-level administrative entities (`country` and `dependency` records). Additionally, **3,811** primary administrative divisions were updated with new properties and concordances and **22,993** secondary administrative divisions were updated with new properties and concordances.  Take a look at the new `statoids:*` properties and all the concordances we now have! Links to selected updated records at the `country`, `region`, and `county` placetypes are below.

### A few examples, by placetype

**Country** 

A few top-level countries that received new `statoids:*` properties and concordances:

- [Lesotho](https://whosonfirst.mapzen.com/spelunker/id/85632173)
- [Myanmar](https://whosonfirst.mapzen.com/spelunker/id/85632181)
- [Qatar](https://whosonfirst.mapzen.com/spelunker/id/85632299)

**Region**

Some primary divisions that received new `statoids:*` properties and concordances:

- [South Chungcheong, South Korea](https://whosonfirst.mapzen.com/spelunker/id/85673203/)
- [Addis Ababa, Ethiopia](https://whosonfirst.mapzen.com/spelunker/id/85671149/)
- [San José, Costa Rica](https://whosonfirst.mapzen.com/spelunker/id/85670391/)

**County**

Examples of secondary divisions that received new `statoids:*` properties and concordances:

- [Tariat, Arhangay, Mongolia](https://whosonfirst.mapzen.com/spelunker/id/1092041727/)
- [Paktha, Bokeo, Laos](https://whosonfirst.mapzen.com/spelunker/id/1092030459/)
- [Vlorë, Sarandë, Albania](https://whosonfirst.mapzen.com/spelunker/id/421179955/)

## Next Steps?

This work is far from over. Follow-up issues to untangle recent administrative changes in all countries have been filed, and additional concordance work will be done to improve our records with more top-level properties, more names, more detailed geometries and alt-geometries, and add even more concordances. We are working to import more properties from [GeoNames](https://www.geonames.com), [Wikidata](https://www.wikidata.com), and [Natural Earth](https://www.naturalearth.com). Stay tuned for more!

If you would like to contribute, file a new issue in the [whosonfirst-data](https://github.com/whosonfirst-data/whosonfirst-data/issues/new) repository or [drop us a line](mailto:hello@mapzen.com)!

_Photo Credit: [sagesolar. (Flickr, CC BY 2.0)](https://flic.kr/p/SacxZh)_
