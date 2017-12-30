---
layout: page
title: Updating Who's On First Neighbourhoods - Part II
category: blog
excerpt: We've been busy updating neighbourhood records in Who's On First - check them out!
authors: [stepps00,zbsingleton]
image: https://s3.amazonaws.com/mapzen-assets/images/neighbourhood-updates-II/blog_photo_main.png
tag: [whosonfirst, neighbourhoods, data]
---

In a [previous blog post](https://mapzen.com/blog/sf-neighbourhood-updates/), we outlined Mapzen's efforts to update neighbourhood records in Who’s On First. Since that blog post was published, we’ve been busy updating our records in several major metropolitan areas like Washington D.C., Helsinki, Amsterdam, Chicago and New Orleans, which are all now available in Mapzen's [basemap styles](https://mapzen.com/products/maps/).

We’ve not only updated our records, but we’ve also developed a streamlined approach to importing [new sources](https://github.com/whosonfirst/whosonfirst-sources/tree/master/sources) and adding [new properties](https://github.com/whosonfirst/whosonfirst-properties/tree/master/aliases) to existing records. In addition to neighbourhoods, Who’s On First has gained new and updated microhood, macrohood, borough, and locality records. For more information on how we define our placetypes, see our handy [placetypes](https://github.com/whosonfirst/whosonfirst-placetypes) repository.

##How do we update records?

We want to make it straightforward for anyone to contribute, so all of the standard tools Mapzen uses are open-source and freely available for download. The major software tool we use to manually enhancing our Who's On First data is the [QGIS](http://www.qgis.org/en/site/) open-source geographic information system.

###Our Workflow

Our workflow revolves around finding authoritative geospatial neighbourhood information and integrating that into our current inventory of records. That means importing new neighbourhoods from open sources and updating current neighbourhood records, often with sourced geometries and attributes. In most situations we reviewed and modified local authoritative sources, but in certain situations where open data was not available, we hand-crafted new neighbourhood shapes.

###Additional Resources

On the surface, the process to update these neighbourhoods is simple, but can get more challenging. Neighbourhoods are usually represented as polygons, but sometimes they are points. We have to consider naming conventions and languages across different sources, as well as making sure neighbourhoods don't extend outside their locality. 

For a more-detailed technical rundown on our process, our updated [document on WOF neighbourhoods](https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md) is a good place to start.

##Where do we find sources?

In our mission to improve Who's On First records, we often turn to municipal or other authoritative open data portals to furnish the framework for our neighbourhood data. Local governments often provide high-quality maps and data of their neighbourhoods in order to aid in planning or community development efforts, which we can then use to provide more reliable information in Who's On First. 

However, not all data needs to come from government sources. Just as regularly, we use detailed, open neighbourhood data from private entities. Regardless of the source, all data is distributed with a permissive license, often coming in the form of a [CC0](https://creativecommons.org/share-your-work/public-domain/cc0/) or a [CC-BY](https://creativecommons.org/licenses/by/4.0/) license.

##How can you view sources?

All of the sources we use are listed in our detailed [sources page](https://github.com/whosonfirst/whosonfirst-sources/tree/master/sources#sources). If you ever wonder where a particular bit of information or property comes from, that page will direct you to its source. This list is updated whenever a new, open-license source is incorporated into Who's On First. To search an individual source, simply look through our list for the appropriate reference code (“mz”, “wof”, etc.) applicable to the data in question.

##Where have neighbourhood records been updated?

We've been busy updating neighbourhood (and associated placetype) shapes; as of this blog post, we have updated administrative features in 35 localities! A list of those places, alphabetically:

- [Amsterdam](https://whosonfirst.mapzen.com/spelunker/download/101751893/)
- [Atlanta](https://whosonfirst.mapzen.com/spelunker/download/85936429/)
- [Baltimore](https://whosonfirst.mapzen.com/spelunker/download/102081589/)
- [Berlin](https://whosonfirst.mapzen.com/spelunker/download/101748799/)
- [Boston](https://whosonfirst.mapzen.com/spelunker/download/85950361/) (including [Cambridge](https://whosonfirst.mapzen.com/spelunker/download/85950329/) and [Somerville](https://whosonfirst.mapzen.com/spelunker/download/85950339/))
- [Chicago](https://whosonfirst.mapzen.com/spelunker/download/85940195/)
- [Denver](https://whosonfirst.mapzen.com/spelunker/download/85928879/)
- Greater Finland (includes [Vantaa](https://whosonfirst.mapzen.com/spelunker/download/101748419/), [Turku](https://whosonfirst.mapzen.com/spelunker/download/101748421/), [Tampere](https://whosonfirst.mapzen.com/spelunker/download/101748431/), [Oulu](https://whosonfirst.mapzen.com/spelunker/download/101748443/), [Kuopio](https://whosonfirst.mapzen.com/spelunker/download/101748439/), [Kauniainen](https://whosonfirst.mapzen.com/spelunker/download/101753897/), and [Espoo](https://whosonfirst.mapzen.com/spelunker/download/101748415/))
- [Helsinki](https://whosonfirst.mapzen.com/spelunker/download/101748417/)
- [Los Angeles](https://whosonfirst.mapzen.com/spelunker/download/85923517/)
- [Minneapolis](https://whosonfirst.mapzen.com/spelunker/download/85969169/) & [St. Paul](https://whosonfirst.mapzen.com/spelunker/download/85953191/)
- [New Orleans](https://whosonfirst.mapzen.com/spelunker/download/85948111/)
- [New York City](https://whosonfirst.mapzen.com/spelunker/download/85977539/)
- [Oakland](https://whosonfirst.mapzen.com/spelunker/download/85921881/)
- [Philadelphia](https://whosonfirst.mapzen.com/spelunker/download/102081353/)
- [Portland](https://whosonfirst.mapzen.com/spelunker/download/101715829/)
- [Rotterdam](https://whosonfirst.mapzen.com/spelunker/download/101751843/)
- [San Diego](https://whosonfirst.mapzen.com/spelunker/download/85922227/)
- [San Francisco](https://whosonfirst.mapzen.com/spelunker/download/85922583/)
- [San Jose](https://whosonfirst.mapzen.com/spelunker/download/85922347/)
- [Seattle](https://whosonfirst.mapzen.com/spelunker/download/101730401/)
- [The Hague](https://whosonfirst.mapzen.com/spelunker/download/101752763/)
- [Utrecht](https://whosonfirst.mapzen.com/spelunker/download/101751827/)
- [Washington, D.C.](https://whosonfirst.mapzen.com/spelunker/download/85931779/) (including [Arlington](https://whosonfirst.mapzen.com/spelunker/download/101729469/) and [Alexandria](https://whosonfirst.mapzen.com/spelunker/download/102080641/))

##Nice list, but how do the new shapes compare?

We can talk all we want about new neighbourhood shapes, but it’s probably best to show these new shapes in [Tangram](https://mapzen.com/tangram/play/). Below, we have two localites to compare, pre-update and post-update: Denver and Amsterdam. 

Note that the original shapes have a more organic, popcorn-looking shape, while the new shapes are more regularly aligned along arterial roads and other major landmarks.

####Denver, Colorado, USA:

- **Original neighbourhood** features are shown **up to** zoom 11 (default map zoom) <span style="color:orange; font-weight: bold;">in orange</span>.
- **New macrohood** features are shown from zoom 11 to zoom 12 <span style="color:LightSteelBlue; font-weight: bold;">in blue</span>.
- **New and updated neighbourhood** features are shown from zoom 12 to zoom 13 <span style="color:green; font-weight: bold;">in green</span>.
- **New microhood** features are shown **past** zoom 13 <span style="color:purple; font-weight: bold;">in purple</span>.

<div class="demo-wrapper" id="refillcycle" style="background-image:url('images/denver.gif');">
<div id=screenshot></div>
<iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=images/denver.yaml#10.5/39.7609/-104.8612"></iframe>
</div>
<p style="text-align: center"  class='caption'><br><a style="font-weight:normal"href="https://tangrams.github.io/tangram-frame/?url=images/denver.yaml#10.5/39.7609/-104.8612">Click to view Denver in full screen ➹</a> <br></p>



####Amsterdam, Netherlands:

- **Original neighbourhood** features are shown **up to** zoom 11 (default map zoom) <span style="color:orange; font-weight: bold;">in orange</span>.
- **New borough** features are shown from zoom 11 to zoom 12 <span style="color:LightSteelBlue; font-weight: bold;">in blue</span>.
- **New and updated neighbourhood** features are shown from zoom 12 to zoom 13 <span style="color:green; font-weight: bold;">in green</span>.
- **New microhood** features are shown **past** zoom 13 <span style="color:purple; font-weight: bold;">in purple</span>.

<div class="demo-wrapper" id="refillcycle" style="background-image:url('images/amsterdam.gif');"><iframe src="https://tangrams.github.io/tangram-frame/?noscroll&url=images/amsterdam.yaml#10.5/52.3553/4.8892"></iframe></div><p style="text-align: center"  class='caption'><br><a style="font-weight:normal"href="https://tangrams.github.io/tangram-frame/?url=images/amsterdam.yaml#10.5/52.3553/4.8892">Click to view Amsterdam in full screen ➹</a> <br></p>

##In conclusion…

Neighbourhood updates are not over yet; we plan on continuing this work and have many more localities in the pipeline. Keep an eye on our [Who's On First data repository](https://github.com/whosonfirst-data/whosonfirst-data) for continued updates! 

If you have a specific request or suggestion, please do not hesitate to [contact us](mailto:hello@mapzen.com?subject="Who's On First neighbourhoods")! Thanks for reading!

_Photo Credit: [midnightboheme, Pixabay](https://pixabay.com/en/new-orleans-neighborhoods-map-river-1228029/)_
