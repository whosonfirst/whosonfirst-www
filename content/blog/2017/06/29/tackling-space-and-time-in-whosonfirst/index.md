---
layout: page
title: Tackling Space and Time in Who's On First
category: blog
excerpt: Using the Extended Date/Time Format to track historical records in Who's On First.
authors: [stepps00]
image: "images/main_photo.jpg"
tag: [whosonfirst, data]
---



##Let's start with Yugoslavia

Creating historical records in the [Who's On First](https://whosonfirst.mapzen.com/) gazetteer for Yugoslavia is an excellent test case in helping us answer the following question:

_How can Who's On First catalogue and preserve records for Yugoslavia, the former Soviet republics, and everything in between?_



##Introducing EDTF

The Library of Congress developed the [**Extended Date/Time Format (EDTF)**](https://www.loc.gov/standards/datetime/pre-submission.html), and is in the process of adding it as an extension to [**ISO 8601**](http://dotat.at/tmp/ISO_8601-2004_E.pdf). This date/time string is used to express the concept of a fixed or known date (`YYYY-MM-DD`, `YYYY-MM` or `YYYY`), as well as other semantic qualifiers like _"approximately the year 2017"_ (`YYYY~`) and _"approximately 2003, but that is uncertain"_ (`2003?~`).

This format is perfectly suited to tracking historical administrative records, specifically "places" in [dispute and contention](https://whosonfirst.mapzen.com/spelunker/placetypes/disputed/#4/-1.32/112.73). Being able to catalogue a place with as many moving pieces as Yugoslavia allows us to use "soft" beginning and end dates. 



##The how

Who's On First uses this format for several [properties](https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/edtf.md), including:

####edtf:inception:

> _Indicates the date when a place was first created or established._

####edtf:cessation:

> _Indicates when a place stopped being a "going concern". The semantics for something ceasing may vary from placetype to placetype. For example, a venue may cease operations or a country may split in to multiple countries._

####edtf:deprecated:

> _Indicates the date when a place was determined to be invalid (was never a "going concern")._

####edtf:superseded:

> _Indicates the date when a record was superseded by another record._



##The why

The Extended Date/Time Format is a useful method to categorize "soft dates" for Who's On First, one example being the record for the country of Croatia as it relates to Yugoslavia. At the start of 1990, Croatia was a socialist republic within Yugoslavia. That same year, the government was dissolved in favor of a multi-party democracy and, soon after, an independence referendum was held. Independence from Yugoslavia was favored and within a month, Croatia declared independence. 

This leaves us with a few questions. _Do we use the date of the independence vote as the inception date for Yugoslavia?_  _Do we use the date of declared independence as the inception date?_ _Is Croatia actually a separate "place" from Yugoslavia?_ The answer to these questions is, well... yes, yes, and yes.

We can use _both_ the date of the independence vote and the date of declared independence for Croatia's inception date using the Extended Date/Time Format. We know Croatia succeeded Yugoslavia, but the debate lies at _when_ this took place. Using the date/string below allows us to be flexible, but still catalogue the "place" of Croatia:

`"edtf:inception":"1991-05~/1991-06~"`

That flexibility let's Who's On First to note the times around both dates related to Croatia's independence.



##Let's take a stroll through history

## 1918-12~ to 1945-11-29

In December 1918, the [Kingdom of Yugoslavia](https://whosonfirst.mapzen.com/spelunker/id/1108955789) came into existence after the dissolution of the Kingdom of Serbia and the Austro-Hungarian Empire. Also known as the "Kingdom of Serbs, Croats, and Slovenes" or simply "Yugoslavia", the country was a combination of six republics: Bosnia & Herzegovina, Croatia, Macedonia, Montenegro, Serbia (including Kosovo), and Slovenia. 

<div class="demo-wrapper" id="map_one">
<iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_1.yaml#6/44.292/-341.644"></iframe>
</div>
<p style="text-align: center"  class='caption'><br><a style="font-weight:normal" href="https://tangrams.github.io/tangram-frame/?url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_1.yaml#6/44.292/-341.644">Click to view in full screen ➹</a> <br></p>


## 1945-11-29 to 1991-06~

Following an [invasion and control by Axis powers](https://en.wikipedia.org/wiki/World_War_II_in_Yugoslavia) between April 6, 1941 (1941-04-06) and November 29, 1945 (1945-11-29), the Kingdom of Yugoslavia was renamed the Federal People's Republic of Yugoslavia, then renamed the [Socialist Federal Republic of Yugoslavia](https://whosonfirst.mapzen.com/spelunker/id/1126113567).

<div class="demo-wrapper" id="map_two">
<iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_2.yaml#6/44.292/-341.644"></iframe>
</div>
<p style="text-align: center"  class='caption'><br><a style="font-weight:normal" href="https://tangrams.github.io/tangram-frame/?url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_2.yaml#6/44.292/-341.644">Click to view in full screen ➹</a> <br></p>


## 1991-06~ to 1991-09~

Around June 1991, the former socialist republics of [Slovenia](https://whosonfirst.mapzen.com/spelunker/id/85633779) and [Croatia](https://whosonfirst.mapzen.com/spelunker/id/85633229) broke from the [Socialist Federal Republic of Yugoslavia](https://whosonfirst.mapzen.com/spelunker/id/1108955787) to [form countries of their own](https://en.wikipedia.org/wiki/Breakup_of_Yugoslavia#Independence_of_Slovenia_and_Croatia).

<div class="demo-wrapper" id="map_three">
<iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_3.yaml#6/44.292/-341.644"></iframe>
</div>
<p style="text-align: center"  class='caption'><br><a style="font-weight:normal" href="https://tangrams.github.io/tangram-frame/?url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_3.yaml#6/44.292/-341.644">Click to view in full screen ➹</a> <br></p>


## 1991-09~ to 1992-03~

Around September 1991, the former socialist republic of [Macedonia](https://whosonfirst.mapzen.com/spelunker/id/85632373) broke from the [Socialist Federal Republic of Yugoslavia](https://whosonfirst.mapzen.com/spelunker/id/1108955785)) to [form a country of its own](https://en.wikipedia.org/wiki/Breakup_of_Yugoslavia#Independence_of_the_Republic_of_Macedonia_and_Bosnia_and_Herzegovina).

<div class="demo-wrapper" id="map_four">
<iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_4.yaml#6/44.292/-341.644"></iframe>
</div>
<p style="text-align: center"  class='caption'><br><a style="font-weight:normal" href="https://tangrams.github.io/tangram-frame/?url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_4.yaml#6/44.292/-341.644">Click to view in full screen ➹</a> <br></p>


## 1992-03~ to 2006

Around March 1992, the former socialist republic of [Bosnia & Herzegovina](https://whosonfirst.mapzen.com/spelunker/id/85632609) broke from the [Socialist Federal Republic of Yugoslavia](https://whosonfirst.mapzen.com/spelunker/id/1108955783) to [form a country of its own](https://en.wikipedia.org/wiki/Breakup_of_Yugoslavia#Independence_of_the_Republic_of_Macedonia_and_Bosnia_and_Herzegovina).

<div class="demo-wrapper" id="map_five">
<iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_5.yaml#6/44.292/-341.644"></iframe>
</div>
<p style="text-align: center"  class='caption'><br><a style="font-weight:normal" href="https://tangrams.github.io/tangram-frame/?url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_5.yaml#6/44.292/-341.644">Click to view in full screen ➹</a> <br></p>


## Present Day

The Socialist Federal Republic of Yugoslavia [dissolved in 2006](https://en.wikipedia.org/wiki/Breakup_of_Yugoslavia#Aftermath_in_Serbia_and_Montenegro) and, soon after, [Montenegro](https://whosonfirst.mapzen.com/spelunker/id/85632667) joined Slovenia, Croatia, and Bosnia and Herzegovina in being internationally recognized as independent nations. [Kosovo](https://whosonfirst.mapzen.com/spelunker/id/85633259) followed suit in 2008, with [Serbia](https://whosonfirst.mapzen.com/spelunker/id/85633755) remaining as the successor state to Socialist Federal Republic of Yugoslavia.

<div class="demo-wrapper" id="map_six">
<iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_dissolved.yaml#6/44.292/-341.644"></iframe>
</div>
<p style="text-align: center"  class='caption'><br><a style="font-weight:normal" href="https://tangrams.github.io/tangram-frame/?url=https://s3.amazonaws.com/mapzen-assets/images/whosonfirst-edtf/yaml/yugo_dissolved.yaml#6/44.292/-341.644">Click to view in full screen ➹</a> <br></p>

You'll notice `supersedes` and `superseded_by` entries in WOF records. These are pointers to other WOF records: a current record can supersede the record of a place that is no longer a going concern, and a record not longer a going concern can be superseded by a current record. Looking at Yugoslavia, this is effectively a linked list:

```
1108955789 superseded by 1126113567
1126113567 superseded by 1108955787, 85633779, 85633229
1108955787 superseded by 1108955785, 85632373
1108955785 superseded by 1108955783, 85632609
1108955783 superseded by 85633755, 85632667, 85633259*
```

_* Note: Kosovo was in a disputed state between 2006~ and 2008~_

Here is the dissolution of Yugoslavia in the form of a GIF, along with the WOF IDs and EDTF data:

![](images/yugoslavia.gif)

You too can travel through time, space and politics by [superseding layers in Tangram Play](https://mapzen.com/tangram/view/?api=22/770#6.529/44.129/-341.711).

##How does this relate to other records?

Great question!

###Constituency records

We've recently imported constituency data for the 115th U.S. Congress ([take a look!](https://github.com/whosonfirst-data/whosonfirst-data-constituency-us)) and have the scaffolding in place to import additional constituency data from previous sessions of Congress, as well as constituency data for other countries. While each Congress has a "hard" end date, the `edtf:*` properties will still be used signify dates in historical constituency records.

### Manifest Destiny project

The [Manifest Destiny project](http://michaelporath.com/projects/manifest-destiny/) is another interesting use case for the `edtf:*` properties. This project has geometries of unclaimed areas, claims, states, and territories in the United States from March 1789 to the present; this is a proposed import for Who's On First and an interesting test case for more superseding and date classification work.

### Existing records

We've done something similar with a smaller batch of records in San Francisco. Follow the `supersedes` links for two venues in San Francisco: [Rock Bar](https://whosonfirst.mapzen.com/spelunker/id/890535433/#14/37.7458/-122.4211) and [Francisca's (neé The Palace)](https://whosonfirst.mapzen.com/spelunker/id/1126130035/#13/37.7604/-122.4143). 



##Caveats...

If it isn't obvious by now, tackling these types of issues can be challenging. We're doing our best to catalogue historical places, but that comes with caveats. Using dates and superseding properties is helpful in creating a timeline of a "place", but it is difficult to manage every edge case with the Extended Date/Time Format and other Who's On First properties. Yugoslavia was an area with relative agreement when creating records and adding dates, but other places in long-term conflict will not be as easy to catalogue.

We welcome anyone to suggest improvements or methods to help us navigate through this historical work. If you have suggestions, questions, ideas, or comments, please [let use know](mailto:hello@mapzen.com)!

_Photo Credit: [Iraia Martínez, Pixabay. (CC BY 2.0)](https://www.flickr.com/photos/aiari/3766024455/in/photolist-6JMRS8-6DruhW-dMpjq-qEC1wW-8jqbkg-3eKq11-9vJDWb-RYEBSv-erDaj-9UQbk-5Xx3no-5MLX4y-7SinmX-q9yT2J-hZMUDT-dEDz8e-VCw3RH-8o2aQe-d9txSf-Sb3iEj-8E1s88-SNrkgW-vESZ2-Uz71gq-Dn2miV-5YW8LF-TSNui7-B4uAyk-dbtWi5-71c6CD-KZsfb-oiYot-dAnKbo-a7Et8u-Av2fPK-bXANVG-9BGheC-bfxnzi-Uz77WE-o7oMjJ-DxpmsQ-7DPAkZ-Uz74ej-8XXBFV-dxVxBL-LqUFzX-Uvvtum-Uz79oY-oiJ5aM-dm4Qmn)_
