---
layout: page
title: Updating Neighbourhood Records in Who's on First
category: blog
excerpt: A handy guide updating neighbourhood records in Who's On First!
authors: [stepps00]
image: images/battery_park.jpg
tag: [whosonfirst, tutorial, data]
---

![Historic Manhattan](images/battery_park.jpg)
_Photo Credit: [Gustave Straubenmuller, Flickr](https://www.flickr.com/photos/internetarchivebookimages/14782952795/in/photolist-owjuQt-oeXUZF-oskqGG-6cfLKf-owddJm-owqudn-owtHpZ-owEBqR-owjvdn-ou63Tn-ov9vB1-ownwLy-osPEQ5-oddXQL-ovv6CR-oePvaL-odFukR-ounhb6-odFyjT-5ZzStu-4ibzJo-ouq595-x4qKZf-ouGC9w-oeY2hR-owg7Gq-odeqaE-owrPU6-oskoPo-ouooHD-odqeuY-ouq6SW-oweTDU-owSur6-oy5fzP-i7JBGv-oeX74i-ouAb8q-owq57g-y8iw81-ouMDmm-zhvmPt-Dczajt-w9YJux-oeXeWH-xnwY2E-owaNsr-oeWXFN-owrSwv-oycF32)_

Here at Mapzen, we _love_ neighbourhoods - you've seen them on our maps and in your search results. We acknowledge there are issues with our data and hope that you'll use your local knowledge and expertise to help update our neighbourhood records in Who's on First. We want your help!

The rundown:

* We have a Gazetter called **Who's on First**
* We use it for, well, **everything**
* We love neighbourhoods, but some of our neighbourhoods **could be improved**
* We **need your help** to improve them
* We have a **[tutorial and list of steps](https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md)** for you to follow if you'd like to contribute

## _We have a Gazetteer called Who's on First_

A while back[^1], we wrote about the [Who's On First](https://whosonfirst.mapzen.com/) project. Who's on First is a gazetteer of places... not quite all the places in the world, but a whole lot of them and, we hope, the kinds of places that we mostly share in common.

>_A **gazetteer** is a big list of places, each with a stable identifier and some number of descriptive properties about that location._

It is essentially a (very) large collection of open administrative and venue data. We've developed a useful browsing tool that displays our Who's on First records' geometries and attributes in our [Spelunker](https://whosonfirst.mapzen.com/spelunker/).

## _We use it for, well, everything_

Who's on First is used in many Mapzen services. Specifically, neighbourhood records in Who's on First are important because they are used for:

* **Labelling:** When we use a mapping application, we want neighbourhoods to be labelled on the map (in the right place and at the right zoom)
* **Ability to search:** Neighbourhoods should be searchable (with the ability to know how large the feature is and fit it into view)
* **Browsing venues:** We should be able to browse venues by neighbourhood

## _We love neighbourhoods (some of our neighbourhoods could be improved)_

Not every gazetteer includes neighbourhood geometries, but Who's On First _does_ and we're proud of that. We've spent a lot of time cleaning up their names and positions on the map, and now we're starting to clean up their shapes.

While Who’s On First uses [Quattroshapes](www.quattroshapes.com) geometries for most neighbourhoods globally, many neighbourhoods in the United States, including San Francisco, source their default geometry from [Zetashapes](www.zetashapes.com). The Zetashapes project follows the same basic principles as Quattroshapes, but builds shapes up from Census 2010 features. We’ve seen problems with shapes extending into adjacent localities, counties, and sometime far out into neighboring rural areas. This automated technique used by Zetashapes is responsible for some of the issues that we want to address. We want shapes touched by a human, and we'll [show you how to do so in San Francisco](https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md) as this map illustrates:

<div class="demo-wrapper" id="refillcycle"><iframe src="https://tangrams.github.io/tangram-frame/?lib=0.8&noscroll&url=https://s3.amazonaws.com/whosonfirst.mapzen.com/misc/_blogs/neighbourhood_blogpost.yaml#13/37.7669/-122.4398"></iframe></div><p style="text-align: center"  class='caption'>San Francisco macrohoods (red), WOF neighbourhoods (blue), additional SFGov neighbourhoods (green) & microhoods (purple).<br><a style="font-weight:normal"href="https://tangrams.github.io/tangram-frame/?lib=0.8&noscroll&url=https://s3.amazonaws.com/whosonfirst.mapzen.com/misc/_blogs/neighbourhood_blogpost.yaml#13/37.7669/-122.4398">Click to view San Francisco in full screen ➹</a> <br></p>

## _We need your help to improve them_

Because we (unfortunately) do not have expert knowledge of every neighbourhood on Earth, we are hoping you'll help us improve these neighbourhood shapes for your locality!

Big cities love neighbourhoods. Neighbourhoods like _Kensington Gardens (London)_, _Capitol Hill (Seattle)_, _The Mission (San Francisco)_, and _French Quarter (New Orleans)_ are well-known and often mentioned in apartment rental and housing ads. Smaller cities might have a couple well known neighbourhoods, but they're "squishy", and you'd probably say things like "by the shopping mall" or "by the high school" instead of using a neighbourhood name.

In larger localities, like San Francisco and New York City, we generate neighbourhood names in our [Search](https://mapzen.com/projects/search/) results for the more interesting neighbourhoods. This is why we want our neighbourhoods to be as clean and as accurate as possible - your local knowledge and expertise will help us accomplish this.

## _We have a tutorial and list of steps for you to follow if you'd like to contribute_

If this sounds like a project you'd like to contribute to, check out our [tutorial on updating Who's on First records](https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md). 

**We look forward to hearing from you!**
 
[^1]: 
    Blog posts [introducing Who's On First](https://mapzen.com/blog/who-s-on-first),
    using the Spelunker and [Jumping into Who's On First](https://mapzen.com/blog/spelunker-jumping-into-who-s-on-first),
    WOF neighbourhoods in [Mapzen Vector Tiles](https://mapzen.com/blog/vector-tiles-v0-8-preview), and 
    WOF places powering [Mapzen Search](https://mapzen.com/blog/wof-search-live/)
