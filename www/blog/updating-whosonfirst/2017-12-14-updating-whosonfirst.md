---
layout: page
title: Whos On First Updates, 2017
category: blog
excerpt: Outlining a few one-offs, changes, and edits that were made to Who's On First in 2017
authors: [stepps00]
image: "https://mapzen-assets.s3.amazonaws.com/images/wof-updates/eraser.jpg"
tag: [whosonfirst, data]
---

<div style="margin: 0 auto; width:640px;">
<a href="https://mapzen-assets.s3.amazonaws.com/images/wof-updates/eraser.jpg"><img src="https://mapzen-assets.s3.amazonaws.com/images/wof-updates/eraser.jpg" height="360" width="640" /></a>
</div>

## So, what's new in Who's On First?

Before the year's end, I wanted to take a few moments to describe three issues that we've recently tackled in Who's On First. While many of the data issues in Who's On First can be complex, each issue has to be addressed with a unique set of tools, a specific workflow, and should follow simple rules that we've outlined to ensure our changes and adjustments can be added to the database.

We've tackled many large-scale issues in 2017, from the [Statoids and Mesoshapes imports](https://mapzen.com/blog/introducting-statoids/), to [updating neighbourhood records](https://mapzen.com/blog/neighbourhood-updates-two/), to the [GeoNames name localization](https://mapzen.com/blog/summer-2017-wof/) work. I wanted to outline a few of the smaller issues we've dealt with in the past few months, and describe what it took to fix the issues.

The issues are below, each with a brief description of the problem and solution. Take a look and enjoy!


## Santa Barbara Neighbourhoods

In October, [a user reported](https://github.com/whosonfirst-data/whosonfirst-data/issues/997) that the record for the neighbourhood of Midco in California had [a _large_ geometry](https://github.com/whosonfirst-data/whosonfirst-data/blob/028f288cc2a2995edb819a90d395a73c553017b0/data/420/552/455/420552455.geojson). So large, in fact, the geometry spanned some 50+ miles, from Santa Maria, CA to Santa Barbara, CA. This geometry was causing the [Who's On First API](https://mapzen.com/blog/whosonfirst-api/) to return peculiar hierarchy results for this area. 

This geometry issue was two-fold; first, we needed to shrink the size of the Midco neighbourhood geometry down to a size that actually represents Midco and secondly, we needed to find a source for new neighbourhood records in Santa Barbara (Midco covered the entire city of Santa Barbara). 

Once Midco was [cut down to size](https://whosonfirst.mapzen.com/spelunker/id/420552455/), [openly licensed](https://github.com/whosonfirst/whosonfirst-sources/blob/master/sources/santabar.json) neighbourhood data on [Santa Barbara's website](https://maps.santabarbaraca.gov/Html5Viewer/Index.html?configBase=/Geocortex/Essentials/REST/sites/City_of_Santa_Barbara__Public/viewers/SantaBarbaraPublic/virtualdirectory/Resources/Config/Default) was found. After downloading the neighbourhood data, I was able to mint new `wof:id` values (thank you, [Brooklyn Integers](www.brooklynintegers.com) for new Who's On First records), map the source properties into applicable Who's On First [properties](https://github.com/whosonfirst/whosonfirst-properties/tree/master/properties), and import them as new records! 

To download Santa Barbara neighbourhoods, use our Bundler tool, [here](https://whosonfirst.mapzen.com/spelunker/download/85921779/?exclude=nullisland) or take a look at the geometries below!

<div class="demo-wrapper" style="height: 60vh; width: 80vw; margin-left: calc(50% - 40vw);">
    <iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/wof-updates/santabarbara.yaml#12.0000/34.4331/-119.7546">
    Your browser doesn't support iframe, <a href="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/wof-updates/santabarbara.yaml#12.0000/34.4331/-119.7546" target="_blank">click here to see demo</a></iframe>
</div>

_Above: New neighbourhood records for Santa Barbara, CA._

## Australia Regions

While the type of geometry and property updates in Australia are not new to Who's On First, they represent the type of updates that many Who's On First records have received in the past and what many records will receive in the future. In a [pull request](https://github.com/whosonfirst-data/whosonfirst-data/pull/688) in the `whosonfirst-data` repository, new geometries were added to the records for regions in Australia.

To do this, the source data from [Australia Open Data](https://github.com/whosonfirst/whosonfirst-sources/blob/master/sources/austriaod.json) was loaded into [QGIS](https://www.qgis.org/en/site/). A new property field was added to the source data with the corresponding `wof:id` for each feature; this is essentially allows us to "link" the new source data features to the existing Who's On First records. Then, using a simple Python script, the geometries for each Who's On First record were updated and existing geometries were saved as alt-geometry files.

And, just like that, Australia regions were updated!

An example of these geometry updates is shown below. Zooming out, you'll see the older, less detailed geometry we maintained for Christmas Island. Zooming in, you'll see the new, more detailed geometry - quite the improvement!

<div class="demo-wrapper" style="height: 60vh; width: 80vw; margin-left: calc(50% - 40vw);">
    <iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/wof-updates/christmasisland.yaml#12.0000/-10.4778/105.6241">
    Your browser doesn't support iframe, <a href="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/wof-updates/christmasisland.yaml#12.0000/-10.4778/105.6241" target="_blank">click here to see demo</a></iframe>
</div>

_Above: Comparison of region geometries for Christmas Island._

## Leningrad and St Petersburg

Piggy-backing on the historical administrative work we started in [Yugoslavia](https://whosonfirst.mapzen.com/spelunker/id/1108955789/), we adjusted records in and around [St. Petersburg, Russia](https://whosonfirst.mapzen.com/spelunker/id/1158857531/) to reflect the administrative changes in that area since the [Russian Revolution](https://en.wikipedia.org/wiki/Saint_Petersburg#Revolution_and_Soviet_Era_(1917–1941)). 

[An issue was filed](https://github.com/whosonfirst-data/whosonfirst-data/issues/948) in the `whosonfirst-data` repository, letting us know there were two distinct records in Who's On First for St. Petersburg - one for St. Petersburg and one for Leningrad. Upon further inspection, we actually had four duplicate records in that area, all of which were merged, superseded, and updated.

Take a look at the record for the St. Petersburg locality, [here](https://whosonfirst.mapzen.com/spelunker/id/1158857531/).


### Wrapping Up

And, with that, I hope this is given you insight into the daily workings of geometry and property issues in Who's On First!

As always, if you would like to contribute to Who's On First, file a new issue in the [whosonfirst-data](https://github.com/whosonfirst-data/whosonfirst-data/issues/new) repository or [drop us a line](mailto:hello@mapzen.com)! 

_Photo Credit: [Carol VanHook. (Flickr, CC BY 2.0)](https://flic.kr/p/mAYbSi)_
