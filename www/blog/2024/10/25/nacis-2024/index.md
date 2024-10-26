---
layout: page
title: Ready for map display: shapefiles, choropleths, and labels!
published: false
date: 2024-10-25
permalink: /blog/2024/10/25/more-shapefiles/
category: blog
excerpt: "An expanded slide deck presented at the annual NACIS map conference in Takoma, Washington on 2024-10-17"
authors: [nvkelso]
image: "images/88663_58c7addb90c5c93a_b.png"
tag: [shapefile,download,whosonfirst,wof,data]
---
<style type="text/css">
table { margin-top: 2rem; font-size: 17px; font-family: sans-serif; font-weight: 300; }
thead { border-bottom: solid thin; }
th { padding-bottom: 1rem; padding-right: 2rem; }
td { padding: 1rem; padding-left:0px !important; padding-right: 2rem !important; vertical-align: top; }
ol { font-family: sans-serif; font-weight: 300; font-size: 17px; margin-top: 2rem !important; list-style-type: decimal !important; }
ul { font-family: sans-serif; font-weight: 300;  }
</style>

[![](images/88663_58c7addb90c5c93a_b.jpg)](https://collection.cooperhewitt.org/objects/18647247/)

<div style="font-size:small;font-style:italic;text-align:center;">
Decretive border by Bellwether Design; screen printed; 1992 <a href="https://collection.cooperhewitt.org/objects/18412045/">Collection of Cooper Hewitt Museum</a>.</div>


## NACIS

At the recent NACIS cartography conference in Takoma, Washington I presented the Who’s On First gazetteer less as a database and more as a map exploring several kinds of visualizations that can now easily be made with the data. Now that WOF is available in the popular shapefile format, it’s now easy to load per-country distributions into desktop mapping apps like QGIS, make choropleths of population, and performantly display administrative place labels at all the zoom globally.

## New shapefile access methods

### First a recap of WOF

At Mapzen we built a gazetteer of places. Not quite all the places in the world but a whole lot of them and, we hoped, the kinds of places that we mostly share in common. 

A gazetteer is a big list of `places`, each with a `stable identifier` and some number of `descriptive properties` about that location. 

An interesting way to think about a gazetteer is to consider it as the space where debate about a place is managed but not decided. We call our gazetteer “Who’s On First” (or sometimes “WOF” for short).

#### Placetype hierarchy and sources

We’re interested not just in “Oakland” but that it’s the Oakland in California, United States. And “Takoma” in Washington, United States. Who’s On First’s hierarchy of placetypes enables that hierarchy to be represented in a structured way. And we have data for a lot of places, from hundreds of sources, including authoritative government sources like US Census and other national mapping agencies.

Authoritative Data
- 142 primary sources
- 197 'via' sources
- 34 concordance-only
 (373 total sources)

#### Compared with other open gazetteers

We firmly believe that Who’s On First should not be the only gazetteer of the world’s places. We endeavor to “hold hands” with other projects, including Wikidata by our links (or concordances), which is possible with GeoNames, but not the geoBoundaries or GADM projects because, while they include polygons don’t include unique and stable IDs.

#### Elephant in the room

OpenStretMap’s ODbL license (versus nominal CC-BY for rest of the datasets in the table) makes it challenging for some organizations to integrate. A coverage comparison between WOF and OSM is provided in the next slides.

* WARNING: geoBoundaries contains multiple sources, many of which are ODbL (especially via OSM) and some of which are CC-BY. Discretion is advised!

### Choropleths

Use WOF shapefiles to make choropleths with populations and concordance IDs

Let’s get practical and use Who’s On First to make a map of United States counties color coded by population count. That’s now possible because each WOF record can specify an “official” concordance ID (like `06023` for Humboldt county in California) and KEY (uscensus:geoid). We are able to prefill “wof:population” with recent counts from the US Census’s enumeration by joining the record’s concordance ID with statistical tables. Big thanks to CARTO for sponsoring this enhancement!

### Download WOF shapefiles

In 2024 we added the ability to download data, including shapefiles, directly from whosonfirst.org, via the Humanitarian Data Exchange (HDX), and in the QGIS desktop mapping app with the popular HCMGIS plugin. The data continues to be hosted by our friends at Geocode.Earth. This has led to a wider awareness of WOF, and an increase in downloads.

[Geocode.Earth](Geocode.Earth) (since 2023)

New in 2024:
In QGIS desktop mapping app with the popular [HCMGIS](https://plugins.qgis.org/plugins/HCMGIS/) plugin
Via the [Humanitarian Data Exchange](https://data.humdata.org/) (HDX) web platform
Direct from [whosonfirst.org](https://whosonfirst.org/download/)


### In QGIS using HMCGIS plugin

#### Install

Let’s walk thru how to install the QGIS plugin… see prior blog post…

#### Usage

### Results

Results in QGIS after loading United States placetypes (point + poly)

The ZIP archive is automatically expanded and loaded into the QGIS table of contents, in all it’s raw glory. 

### From 0 to 1 with populations and concordance IDs

WOF shapefiles quickly get you from 0 to 1 with populations and concordance IDs

#### New slide showing layer classification dialog in QGIS

Because many records include population counts, it’s possible to quickly rearrange the layers to enable just the counties (grey fills) and regions (black lines). 

Tk tk tk

## Map labels! 

In all the places; at all the zooms

While the choropleth map is great at showing patterns, it over relies on prior knowledge to associate shapes with names. Enter a new solution: a Who’s On First powered places vector layer for all the places, in all the place types, at all the zooms. The results of the server side collisions are stored into the database’s min_zoom properties, allowing performant and scale dependent compilation of labels in desktop GIS applications using basic SQL select statements. The XY positions have also been optimized for both coarse administrative place types like regions and counties where area type centered in the feature is appropriate, and localities where the townspot should instead be in the dense downtown.

[bit.ly/wofmap](https://pub-2529ca19de1a4544852a9532a0f978c9.r2.dev/style/wof-places-all.html#1/5.6/-63.3)

### Before we talk about map labels…

👏 After 10 years Who’s On First has “ubiquitous” human settlement coverage…

This new places vector tile layer has global coverage thanks to 10 years of effort in Who’s On First to aggregate data for human settlements. 

<< more here about open data movement…>>

### Ready for map display

WOF distributions include min_zoom; how is this calculated?

How do we calculate these min_zoom values? We combine manual human curation with heuristic-based candidate values, and then put them thru a server-side collision algorithm. We’ve updated the manual curation from Natural Earth to the latest pre-release version 6, which is good to zoom 7.

<< insert photo with lots of ladders, sort and tall >>

1. Extract features from WOF SQLite distribution as CSV
2. Manual curation (`ne:min_zoom`, `lbl:min_zoom`)
    - Natural Earth’s 10k min_zoom’s from z0 to z6
    - Zoom 7, z8, z9, and z10 using several other datasets
3. Placetype (`wof:placetype`)
    - Country, region, county, localadmin locality, neighbourhood
    - Feature Class (`ne:featurecla`)
    - Admin-0 capital, Admin-1 capital, Admin-2 capital, metro/micro central city, locality
4. Population (`wof:population`)
    - Ranked into 10 ladders per above placetype and feature classes, with 18 rungs each
5. GDAL with 3k line SQL statement produces GeoPackage

### Because WOF is missing capital designations and population counts for many features, especially outside of North America and Europe, we needed to bring in several new sources to improve the mid-zooms 8, 9, 10, and 11.

Gap between human curation and algorithmic placement zooms 7-11

<< logos >>

This included 3 new sources:

1. Global Urban Polygons and Points Dataset
    - [urbanspatial-guppd-v1-2024](https://sedac.ciesin.columbia.edu/data/set/urbanspatial-guppd-v1)
    - Columbia University, EC-JRC, NASA
    - 123k (107k with names) - zoom 10 and z11
2. 2015 Global Human Settlement (GHS) Urban Centre Database, 2019 update
    - [GHS_STAT_UCDB2015MT_GLOBE_R2019A_V1_2](https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_STAT_UCDB2015MT_GLOBE_R2019A/V1-2/)
    - European Commission’s Joint Research Centre
    - 13.1k (12.2k with names) - zoom 8 and z9
3. AFRICAPOLIS
    - [AFRICAPOLIS2020](https://africapolis.org/en/data?country=Angola&keyfigure=totalPop&type=abs&year=2015)
    - OECD/SWAC
    - 7.7k (7.7k with names - zoom 10, z11, z12)

This is satellite derived data with small pixel sizes, for dense cities, medium sized towns, and small rural villages. Most of it has names, although the names are sometimes lists of possible central cities rather than definitive names, and sometimes from OpenStreetMap with the ODbL license prevents import to WOF. So we used the urban polygons to confirm the existence of WOF places, and promote those places to the mid-zooms.

~60% match rate

While zoom 12+ globally is influenced by population, mostly the collision algorithm fills in with NULL population places

### Label centroids for polygons

<< slide >>

SQLite distribution only (not SHP)

1. Manual curation
    - Mapzen primarily
2. Alternate geometries
    - Quattroshapes point gazetteer
    - Geonames.org
    - Other WOF sources including NMA’s
3. Property based alt geoms
    - So weird, right?!
    
Who’s On First contains multitudes, in this case many different “alternate” geometries for places. A tiny minority are manually curated, most are generated from MapShaper as area text label points, but legacy data products from Quattroshapes and ultimately geonames.org often provide better label points for locality and neighborhoods than even yerbashapes. The SQL uses a list of fallbacks to select the “best” candidate, although it still sometimes gets it wrong.

<< show Arcata / Bayside alt point locations? >>

### Population min_zooms are candidates; final set from collision algo

After we have the candidates, we need to balance the content by both reducing density in some areas and promoting smaller places “up” the zoom stack in others to fill in empty areas. To do this we created a custom Planetiler profile.

1. Custom Planetiler profile
2. Quad tree of global tiles to zoom 15
3. For each tile, in each zoom:
    - Sort by candidate min_zoom (from population, placetype, and feature class) and name
    - Subdivide tile into “8x8” label grid, and for each cell in the grid allow 1 to 3 labels to export to MBTiles output file
4. GDAL to group result by wof_id, calculate min(zoom), and join result onto original data
5. Runs in < 20 minutes on laptop circa 2024

### Results

<< Insert Slippy map >>

Zoom 2 - NE v5
Zoom 3 - NE v5
Zoom 4 - NE v5
Zoom 5 - NE v5
Zoom 6 - NE v5
Zoom 7 - NE v6 new manual curation at zoom 7
Zoom 8 - WOF specific manual curation and correlation with the global urban raster products.
Zoom 9 - more WOF curation
Zoom 10 - more WOF curation
Zoom 11 - Algo and data all the way down
Zoom 12

### Let’s talk about (lack of) data

😲 1B people are unmapped (~1M localities), especially in Africa, South America, and Asia

I mentioned before how Africa had sparser data coverage and how the Acropolis data helped bridge that gap. But it doesn’t fill the void itself – on zoom in there just aren’t enough cities compared with all the urban areas one observes in the imagery. This pattern continues in South America, and even parts of Asia. 

Some back of the envelope math say 8.1 billion / 4.5M localities = 1,800 people per city, which is close to the urbanization threshold the US Census uses for demographic analysis. But the United States is relatively urbanized at X %. Let’s look at a few other counties…

<< image >>

#### Global patterns

This is a global problem that's especially acute in developing countries in Africa and the Americas where limited local capacity, outdated data (sometimes still analog), and sparsity of data are all challenges.

These regions have ~ 1.8B people and we estimate 1B are not mapped. (This ignores Asia which is generally better in WOF but could use additional work.)

Human settlements (localities / populated places) include both points and polygons often with population and building / household estimates. Related layers include sub-national admin division polygons to the state/province, county/prefecture, and local admin levels.

Let’s look Who’s On First data projects at India and Nigeria…

##### India deep dive

<< image >>

As anyone who’s searched for Indian map data knows… the sheer number of people and populated places, combined with the historic paucity of openly licensed and/or authoritative government data, has presented significant challenges

India recently surpassed China to become the most populous country on Earth with over 1.4 billion people. According to the World Bank, around 65% of people in India are spread out in hundreds of thousands of rural villages with populations less than 5,000; the remaining 35% urbanized population is concentrated in towns with incredible density themselves.

In 2023, Who’s On First released the best open data for India

Source: [WOF blog post](https://whosonfirst.org/blog/2023/06/19/introducting-karmashapes/) 2023

<< image >> 

When we added Karmashapes for India in 2023, there are 1.4B people but we only had 497k localities to start = 2800 people per locality. But we constantly received feedback we were missing locality coverage, and after the project merged we had gained 415k localities for a total of 915k or 1,500 people per locality. India is much more rural. STATS

1.4 billion people / 2.8k people per locality = 500k localities
                            / 2.0k people                    = 700k
                            / 1.5k people                    = 915k  (+415k)

##### Nigeria deep dive

Replicating the workflow in Nigeria, we’ve seen that urbanization threshold be more around 1,000 people per locality after 4xing the number of localities in WOF. STATS

<< image >>

- Who’s On First only had 53k places in Nigeria
- GRID3 has named settlement points for 292k places (5.5x)
- After conflating WOF and GRID3, 324k unique places were evaluated (6.1x)
- GRID3 also provided unnamed settlement polygons and those were used to give polygon extents to all but 17k of the 324k places, greatly augmenting WOF’s couple hundred locality and neighbourhood polygons (with population estimates!)
- 216k of GRID3 places retained as localities (4x) and 106k places reclassified as urban neighbourhoods
- 70% of resulting localities are rural with less than 5k people (still low)

218 million people / 4.1k people per locality = 53k localities
                              / 2.0k people                    = 109k
                              / 1.5k people                    = 145k
                              / 1.0k people                    = 216k  (+163k)

##### Africa patterns

Lagos conurbanization, Nigeria

Lagos neighbourhoods, Nigeria

Small villages, Nigeria

##### Types of missing localities

Cities and towns: dense urban centers and medium population; Rapid urbanization with poor or non-existent population estimates, conurbanization edge effects, dense city neighborhoods and slums, probably < 20,000 cities and towns missing globally.

Villages: low population density: 98%+ of missing places are are rural villages; Small village populations large in aggregate; Wide variety of languages, names, and spellings.

Cities: dense urban centers
- Rapid urbanization with poor or non-existent population estimates
- Conurbanization edge effects 
- Dense city neighborhoods and slums
- < 20,000 cities and towns missing

Towns: medium population density

Villages: low population density
- 98%+ of missing places are are rural villages
- Small village populations large in aggregate
- Wide variety of languages, names, and spellings

##### 1 BILLION: That’s a lot of people!

But we haven’t really mapped hundreds of countries in ages

- **WHY:** Open administrative and human settlement data helps organizations focus resources, benchmark return on investments, and can catalyze in-country communities and initiatives –especially around health, climate, and economic development – with higher quality data
- **PROGRESS:** As we mark 10 years of the open data movement, most of the easily openable data has already been integrated into projects like Who's On First and the Humanitarian Data Exchange (HDX)
- **MAXING OUT:** While a few more countries will open their data soon, in many more cases we need to create and/or update data with vintages 25 or 50 years old, especially for human settlements
- **WHAT’S NEXT:** New approaches are needed that leverage cloud native geospatial techniques, high resolution imagery, ML and AI processing, and crowdsourced human labeling

### Who’s On First (CC-BY)   vis-à-vis  OpenStreetMap (ODbL)

<< map >>

- WOF is better than OSM in 93 countries (green) 
    - Asia and southern Africa stand out here
- WOF is similar to OSM in 40 countries (light grey)
    - Hello cold war legacy from geonames.mil > geonames.org 
- OSM is slightly better than WOF in 63 countries (dark grey)
    - Advantage to OSM because of low population rural locality point imports in Europe and elsewhere
- OSM is much better than WOF in 30 countries (blue)
    - Mostly in Africa and South America – but both OSM and WOF are missing most places
- NOTE: Red outlined in 5 countries show a significant gap in locality count compared with country population: Israel, Ghana, Kenya, Tanzania, and eSwatini.

METHODOLOGY: Count of human settlements, by country, by source

### What’s next?

Finalizing and publishing the results; mapping 1B people!

1. Results will be published by end of 2024 (also SHP?); preview map available now
2. Improving WOF feature coverage in 2025+:
    - Estimate populations for existing WOF places (census grids and vector building)
    - Ingest recently opened public data (bulk data imports)
    - Work with local data partners to open new data (partnership + bulk data imports) 
    - Manual review to add and adjust data (bespoke)
    - Add data via crowdsourcing tool improvements and local partnerships (ala cart adds) 
    - Improve interoperability with similar projects GADM (non-commercial), geoBoundaries (ODbL and CC-BY), GeoNames (CC-BY with commercial polygons), Wikidata (CC-BY), and OpenStreetMap (ODbL)

#### Approaches

Vary according to data availability and local communities

- Country-based data projects to improve coverage (recall) and quality (precision)
- Continent-based data projects to improve quality (precision) and consistency 
- Software engineering solutions to improve the project’s technical levers and infrastructure

##### Per-country approaches

1. Improving feature coverage
    - Improving feature coverage:
    - Ingest recently opened public data (bulk data imports)
    - Work with local data partners to open new data (partnership + bulk data imports) 
    - Manual review to add and adjust data (bespoke)
    - Add data via crowdsourcing tool improvements and local partnerships (ala cart adds) 
    - Improve interoperability with similar projects GADM (non-commercial), geoBoundaries (ODbL and CC-BY), GeoNames (CC-BY with commercial polygons), and OpenStreetMap (ODbL)
2. Improve quality dimension of point and polygon geometries
    - Improve quality dimension of point and polygon geometries: 
    - Adjust point geometries towards feature center (upgrade old data) 
    - Adjust polygon geometries to align with coastline and country and region boundaries (upgrade old data)
    - Create synthetic locality polygons for features based on big data ML/AI approaches to mashing up high resolution satellite derived urbanized areas, recently released global open building data from Google and Microsoft, population grids from Columbia University, and settlement points (see 2023 India blog post).
    - Manual review to add and adjust data (bespoke)
3. Improve quality by adding data attributes
    - Add magnitude with population estimates backfill using statistical methods and open data 
    - Add missing name localization (manual and bulk via translation companies)
    - Manual review to add and adjust data (bespoke)

#### Cathedral and the bazaar

Adding crowdsourcing ethos and best practices to Who’s On First

**Cathedral:** Aggregating bulk data from global and country sources (including national census and national mapping agencies, and regional governments allowed Who’s On First to rapidly scale and achieve ubiquity.

**Bazaar:** The WOF project is in process of molting into a crowdsourced project by making it easy to view, download, edit, and add missing places, especially in Africa and the Americas where high quality authoritative data is not available.

Bazaar pilot projects: Active mapping communities in countries like Ghana, Kenya, and Tanzania (OTHERS), HOT, Missing Maps, etc:

Software engineering changes proposed in “v2” section of the Technical Levers slide

##### Technical levers

Varies according to data availability and local communities

- Current V1 public web tool allows search, view, and edit existing gazetteer data (Spelunker and Write Field)
    - Viewing and downloading are general access on the web
    - Edits via web tool require users authenticate with a free github.com account, where edits are reviewed, merged, and available for download within 6 hours (including via HDX)
- Proposed V2 new crowdsourcing improvements to the web tool would: 
    - Allow users to use tool in their local language – not just English (eg French, Spanish, and Arabic)
    - Allow users to add missing data for single features (eg add named location of missing city, town, or village)
    - Allow editing polygons from a licensed imagery layer (with derivative rights) – $ or in-kind donation
    - Enable easy data use in web maps and desktop GIS applications (download shapefiles and vector tile layers)
- Data consistency: Improve backend tooling for hierarchy updates and point-in-polygon queries (existing bottleneck)
- QA/QC: Improve backend tooling to validate and visualize data changes before they are reviewed and merged
- Speed: Improve backend tooling for conflation and concordances with other open data projects for lifecycle maintenance (like hierarchy PIP)
- Open access: Improve website so each place has a page in a place hierarchy with “encyclopedia” content pulled in linked data

##### Project Goals

Globally and by continent

- Focus on global human settlement (locality) data coverage as unique feature
- Play to data quality strengths in North America and Asia
- Invest in Europe and Australia by address geometry issues and low rural settlement point coverage
- Invest in South America by addressing poor polygon geometry issues and low rural settlement point coverage generally and in Brazil, Argentina, and Chile specifically
- Investigate Middle East and North Africa data play and partnerships
- Partner in Africa with GRID3, Columbia University, and geoBoundaries from William and Mary University

##### Budgets

How to fund the next decade?

- After 10 years, Who’s On First has an impressive collection of authoritative government open data and cold war vintage global coverage used by 100s of millions in major location services
- Thus far, 20 staff year equivalents have been contributed to WOF with around $4M direct investments
- We need new funding and sponsorship to fix gaps in locality coverage, refresh existing sources, add new tooling, and partner with local experts to fill other gaps
- Multi-year and multi-million dollar project to address known gaps
- Then maintenance mode with bursts for special projects

### Feedback

We hope you enjoy open data from the Who’s On First gazetteer!

If you have feedback please submit a [new issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/new) or [discussion](https://github.com/whosonfirst-data/whosonfirst-data/discussions/new/choose) topic via Github.

If you prefer email:

* [Subscribe to WOF Announcements](http://eepurl.com/ipOxd2) for “big news", via Mailchimp. Frequency is a few times per year. 
* Join our new [WOF Gazetteer discussion group](https://groups.google.com/g/wof-gazetteer) on Google to ask questions and share updates on your country’s latest changes to it’s internal administrative subdivisions. If you’re a geography geek, this one’s for you.

Or on social media:

* Follow us on Mastadon at [mapstodon/@whosonfirst](https://mapstodon.space/@whosonfirst)