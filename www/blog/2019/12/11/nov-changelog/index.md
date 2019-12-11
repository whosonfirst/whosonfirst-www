---
layout: page
title: Who's On First - Changelog
published: false
date: 2019-12-11
permalink: /blog/2019/12/11/nov-changelog/
category: blog
excerpt: "Who's On First Changelog - November 2019"
authors: [stepps00]
image: "images/globe.jpg"
tag: [whosonfirst,wof,data]
---

![](images/globe.jpg)

# The Who's On First Changelog - November 2019

We've updated the Who's On First [changelog](https://github.com/whosonfirst-data/whosonfirst-data/blob/master/CHANGELOG.md) to include updates completed through the month of November 2019.

In November, we began updating neighbourhood, macrohood, and borough records for various localities in India. We also curated new localized label values for regions in France, fixed various name translations of localities in eight countries, and adjusted neighbourhood geometries in Scotland.

Take a look below for a more detailed changelog. A special thanks to all of our contributors - enjoy!

## November 2019

#### INDIA
- Updated administrative records in select localities in India ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1593))
- Fixed by:
  - https://github.com/whosonfirst-data/whosonfirst-data-admin-in/pull/12
  - https://github.com/whosonfirst-data/whosonfirst-data-admin-in/pull/11
- This work is ongoing and will update **neighbourhood**, **borough**, **locality**, **county**, and **region** geometries in and around ten of the most populous localities in India. Two of the ten localities were updated this month, the remaining eight will be completed in December.
- Specific work included:
  - Updating geometries for **neighbourhood**, **borough**, **locality**, **county**, and **region** records in Chandigarh and Kolkata
  - Updating properties for these records, including name translations, `mz:` property flags, and `wof:` properties
  - PIP work to update `wof:hierarchy` and `wof:parent_id` properties for all records
  - Validating all geometries using osgeo, validating all records using Who's On First's `go-whosonfirst-validate` tool
  - Completing PIP work to updating or confirming all `wof:hierarchy` properties for all records in the India admin repository

#### FRANCE
- Updated French `label:` properties in **region** records ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1734))
- Fixed by: https://github.com/whosonfirst-data/whosonfirst-data-admin-fr/pull/18
  - Verifying and fixing each unique `"label:fra_x_preferred_longname"` property values for each of the 101 region records

#### SCOTLAND
- Updated **neighbourhood** geometries in Glasgow ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1724))
- Fixed by: https://github.com/whosonfirst-data/whosonfirst-data-admin-gb/pull/18
  - Clipping existing geometries to the Glasgow **locality** geometry
  - Flagging each updated record with a `mz:is_current` property value of `1`
  - Storing existing geometries in alt-geometry files

#### VARIOUS
- Fixed incorrect concordances and name translations in a **locality** record in **Norway** ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1730))
  - Fixed by: https://github.com/whosonfirst-data/whosonfirst-data-admin-no/pull/7
- Updated the **locality** geometry in **Honduras** ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1736)):
  - Fixed by: https://github.com/whosonfirst-data/whosonfirst-data-admin-hn/pull/6
- Minor updates to **locality** records in **Poland** ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1738))
  - Fixed by: https://github.com/whosonfirst-data/whosonfirst-data-admin-pl/pull/14
- Updated the properties of two **county** records in **Germany** ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1697))
  - Fixed by: https://github.com/whosonfirst-data/whosonfirst-data-admin-de/pull/17
- Updated name translations in various **locality** records ([issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/1743))
- Fixed **locality** records in the **Angola**, **Austria**, **Hungary**, **India**, **Lithuania**, **Poland**, **Spain**, and the **United States**.
  - See issue for PR fixes

#### Contributing

If you'd like to contribute to Who's On First or suggest a change, please [file an issue](https://github.com/whosonfirst-data/whosonfirst-data/issues/new) in our public data repository.

_Photo Credit: [Mike Linksvayer, flickr](https://www.flickr.com/photos/mlinksva/6117780887/in/photolist-ajBe7P-83KJEU-2ejsaLr-X6yNPo-22geH2d-C1j3WJ-C1Jhyw-2hpBDzR-5tRxQr-EeS51N-ieaMC7-hUdRX6-8v5Je2-hYEKWU-hPNmUu-Ssd8i7-VMho85-VMho97-ie4ru2-i7noZg-YgktBh-VAzC3C-RewTfh-Tcdio4-Wm9ZR4-mZYi5a-WvMyEt-ie2UwS-ie4Kmq-hVWAoG-oeZGW9-ouFUaw-ie4vLs-7Diy6S-id5hMp-wqNqnK-fm9u5i-8n1Zsd-i7eM3b-hPKmNF-EHhydv-7ZAfHB-idZ3jk-i8Pz3Y-oddVKH-f5LW4C-KnSWTe-7ebsgq-hPB2ei-i3h3gE/)_