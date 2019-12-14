---
layout: page
title: Who's On First - Changelog
published: false
date: 2019-11-18
permalink: /blog/2019/11/18/changelog/
category: blog
excerpt: "We've been busy updating Who's On First; now you can read about the updates in our changelog."
authors: [stepps00]
image: "images/globe.jpg"
tag: [changelog,whosonfirst,wof,data]
---

# Introducing the Who's On First Changlog

We've been busy updating Who's On First and, to outline the recent changes, have created a [changelog](https://github.com/whosonfirst-data/whosonfirst-data/blob/master/CHANGELOG.md). Going forward, this changelog will be updated monthly and give a simplified, bullet-point style description of updates and new additions to Who's On First for a given month.

October changes are listed below, which include administrative updates to Norway, France, and Poland, as well as updates to **postalcode** records in France.

A special thanks to all of our contributors - enjoy!

## Who's On First Changelog
_This is a human generated overview of significant changes to Who's On First place data 
across all repos. More recent changes are at the top, oldest changes at the bottom._

### 2019 October

#### NORWAY
- Updated **locality** and **neighbourhood** records in Norway ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/298))
- Fixed by: https://github.com/whosonfirst-data/whosonfirst-data-admin-no/pull/6
- This pull request includes changes at the **locality** and **neighbourhood** placetypes in Norway. In summary, each **locality** record was updated with new geometries, property flags, and name translations. In addition, other administrative placetypes were updated as needed.
- Specific work included:
  - Updating geometries for two records at the **region** placetype, ensuring Who's On First has the most recent admin1 boundaries in Norway
  - Updating geometries for many records at the **locality** placetype, clipping geometries along parent boundaries 
  - Updating **neighbourhood** records, converting some existing **locality** records to **neighbourhood** records, and curating new neighbouhrood geometries in a handful of cases
  - Resetting all `lbl:bbox` values for records that received new Polygon or MultiPolygon geometries
  - Validating all geometries using osgeo, validating all records using Who's On First's `go-whosonfirst-validate` tool
  - Adding Wikipedia and Wikidata-sourced name translations to any record without a name translation
  - Completing PIP work to updating or confirming all `wof:hierarchy` properties for all records in the Poland admin repository

#### FRANCE
- Corrected **postalcode** hierarchies in France ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1713))
- Fixed by: https://github.com/whosonfirst-data/whosonfirst-data-postalcode-fr/pull/2
  - Updating "county_id" and "localadmin_id" values in dozens of **postalcode** records' `wof:hierarchy` properties, also updating `wof:belongsto` and `wof:parent_id` values
  - New **postalcode** hierarchies in France now maintain the appropriate, current parent administrative records

#### ALTERNATE GEOMETRIES
- Addition of `src:alt_label` property to each alt file ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1714))
- Fixed by: Multiple, example: https://github.com/whosonfirst-data/whosonfirst-data-admin-ro/pull/9
  - In order for Who's On First to property publish public SQLite distribution files, each "alt" file in Who's On First needed a `src:alt_label` property added.
  - Alt files in each of the 260 per-country Who's On First repositories were given this property in a series of pull requests.

#### POLAND
- Updated **county**, **localadmin**, **locality**, **borough**, and **neighbourhood** records in Poland ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1131))
- Fixed by: https://github.com/whosonfirst-data/whosonfirst-data-admin-pl/pull/11
- This pull request includes various changes at five placetypes in Poland. In summary, each **localadmin** and **locality** record was updated with updated geometries, property flags, and name translations.
- Specific work included:
  - Adding new source geometries to each **localadmin** record
  - Adding new source geometries to some **locality** records, storing some source geometries as "alt" files
  - Adding source concordances to **region**, **county**, **localadmin** records
  - Flagging **localadmin** and **locality** as coterminous using the `wof:coterminous` property, as necessary
  - Demoting some **locality** records to the **neighbourhood** placetype, as needed
  - Adding new **borough** records to two localities in Poland - Krakow and Warsaw
  - Adding concordances to the `wof:concordances` propert
  - Validating all geometries using osgeo, validating all records using Who's On First's `go-whosonfirst-validate` tool
  - Adding Wikipedia and Wikidata-sourced name translations to any record without a name translation
  - Completing PIP work to updating or confirming all `wof:hierarchy` properties for all records in the Poland admin repository

_NOTE: This document was created 2019 November. Earlier changes have not been 
retroactively cataloged._

#### Contributing

If you'd like to contribute to Who's On First or suggest a change, please [file an issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/new) in our public data repository.

_Photo Credit: [Mike Linksvayer, flickr](https://www.flickr.com/photos/mlinksva/6117780887/in/photolist-ajBe7P-83KJEU-2ejsaLr-X6yNPo-22geH2d-C1j3WJ-C1Jhyw-2hpBDzR-5tRxQr-EeS51N-ieaMC7-hUdRX6-8v5Je2-hYEKWU-hPNmUu-Ssd8i7-VMho85-VMho97-ie4ru2-i7noZg-YgktBh-VAzC3C-RewTfh-Tcdio4-Wm9ZR4-mZYi5a-WvMyEt-ie2UwS-ie4Kmq-hVWAoG-oeZGW9-ouFUaw-ie4vLs-7Diy6S-id5hMp-wqNqnK-fm9u5i-8n1Zsd-i7eM3b-hPKmNF-EHhydv-7ZAfHB-idZ3jk-i8Pz3Y-oddVKH-f5LW4C-KnSWTe-7ebsgq-hPB2ei-i3h3gE/)_