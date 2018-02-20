---
layout: page
title: WOF in a Box (part 3)
published: true
date: 2018-02-20
permalink: /blog/2018/02/20/wof-in-a-box-part3/
category: blog
excerpt: The Spelunker was rebuilt on a bare Ubuntu 16.04 Linux server, following Dan’s WOF in a Box instructions and everything worked without a hitch. Along the way, I made some updates to the “fetching and indexing data” piece specifically to make things “faster and easier” for people who just want to work with the data as-is and don’t need to make updates.
authors: [thisisaaronland]
image: "images/wof-on-off.jpg"
tag: [spelunker,sqlite,whosonfirst]
---

![](images/wof-on-off.jpg)

The Who's On First Spelunker lives again! It's new home is:

<div style="font-size:2em; text-align:center; margin-top:1em;">
     <a href="https://spelunker.whosonfirst.org/">https://spelunker.whosonfirst.org/</a>
</div>

Any old Spelunker URLs should continue to work as-is once you update the root, replacing
`whosonfirst.mapzen.com/spelunker` with `spelunker.whosonfirst.org`. For example, the URL for the Who's On First record for
[Tokyo](https://spelunker.whosonfirst.org/id/102031307/) used to be:

<div style="font-size:2em; text-align:center; margin-top:1em;">
     <a href="#" style="color:#666 !important;"); return false;">https://whosonfirst.mapzen.com/spelunker/id/102031307/</a>
</div>

And now it is:

<div style="font-size:2em; text-align:center; margin-top:1em;">
     <a href="https://spelunker.whosonfirst.org/id/102031307/">https://spelunker.whosonfirst.org/id/102031307/</a>
</div>

Yay!

The rest of this blog post is divided up in to two parts, one nerdier than the
next. The first section describes a couple of mechanical changes we made to
speed up rebuilding the Spelunker ("part 3" of WOF in a Box).

> In my mind everything up to and including the Spelunker is “near-term”, the
API and the spatial services are “medium-term” and the editorial stuff is
“longer-term”. It’s not ideal but it seems the most realistic given whatever
world of new everyone involved in the project will be negotiating during the
coming year.

The second section builds on the first and
discusses what we've been up to [post-Mapzen](/blog/2018/01/02/chapter-two/) and
where things are going next. This is the "medium-term" work outlined in the blog
post that [followed the announcement](/blog/2018/01/02/chapter-two/) that Mapzen was shutting down.

It's pretty technical so if that's not your jam you can skip it all in good
conscience and head over the to [the
Spelunker](https://spelunker.whosonfirst.org/) and start spelunking away again.

![](images/wof-wall.jpg)

The Spelunker was rebuilt on a bare [Ubuntu
16.04](https://wiki.ubuntu.com/XenialXerus/ReleaseNotes) Linux server, following
Dan's [WOF in a Box](/blog/2017/12/21/wof-in-a-box/) instructions and
everything worked without a hitch. Along the way, I made some updates to the
"fetching and indexing data" pieces specifically to make things faster and
easier for people who just want to work with the data as-is and don't need to
make updates.

_These updates actually introduced some "hitches" in Dan's guide but with [Gary
Gale](https://www.vicchi.org/) 's help we were able to make short work of those
bugs and everything should work as advertised again..._

Historically all the Who's On First tools have been designed to work with [the
raw (plain-text GeoJSON) data](/blog/2016/08/15/mapping-with-bias/#database) contained in the GitHub repositories. It's
important that there always be tooling to work with the raw "at rest" data but
it can be unnecessarily fiddly for a lot of people.

We've been doing a lot of work recently to distribute Who's On First data [as
SQLite databases](https://sqlite.org/). SQLite databases have the advantage of being self-contained
with widespread support in a variety of tools and programming languages. They
don't currently include [alternate geometry](https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/creating_alt_geometries.md) WOF records but those
aren't necessary for most of the things that people want to do with WOF related tools.

The first tool that we wrote is a simple command-line tool to fetch all of the
databases defined in an `inventory.json` file. These `inventory.json` files are still [a work in progress](https://dist.whosonfirst.org/sqlite/inventory.json) and currently only
published for SQLite databases. As we chip away at the remaining work to
generate other [Who's On First distributions](/download/#distributions) the plan is to adopt and adapt the
inventory files accordingly. More on that below.

Here's how to the [wof-dist-fetch](https://github.com/whosonfirst/go-whosonfirst-dist#wof-dist-fetch) tool works. In this example we're going to
ask the tool to fetch _every_ database listed in the inventory file, and
store them in a folder called `/usr/local/data`:

```
> wof-dist-fetch -inventory https://dist.whosonfirst.org/sqlite/inventory.json -dest /usr/local/data
...time passes...

> ls -d /usr/local/data/whosonfirst-data*
/usr/local/data/whosonfirst-data-constituency-ca.db
/usr/local/data/whosonfirst-data-constituency-ca-latest.db
/usr/local/data/whosonfirst-data-constituency-us-latest.db
...
/usr/local/data/whosonfirst-data-venue-us-wy-latest.db
/usr/local/data/whosonfirst-data-venue-uy-latest.db
/usr/local/data/whosonfirst-data-venue-za-latest.db
```

You can also filter specific databases by passing one or more `-include` or
`-exclude` flags. For example if we only wanted to download postal code
databases we would do this:

```
> wof-dist-fetch -inventory https://dist.whosonfirst.org/sqlite/inventory.json -dest /usr/local/data -include 'whosonfirst-data-postalcode-*-latest.db'
```

The `wof-dist-fetch` tool replaces the steps described in the [Download some
data](/blog/2017/12/21/wof-in-a-box/#download) section of Dan's post. It will
still take a while to download all the SQLite databases but they are generally
smaller and easier to work with than the Git repositories and don't require
setting up additional tools like [Git LFS](https://github.com/whosonfirst-data/whosonfirst-data#git-and-large-files).

The `wof-dist-fetch` tool is part of the [go-whosonfirst-dist](https://github.com/whosonfirst/go-whosonfirst-dist) package which will also be used
to _generate_ those SQLite files and other distributions. The package contains different tools to fetch and build distributions but the latter are still being actively developed so you probably shouldn't try using those yet, unless you are
feeling adventurous.

The second tool is actually just an update to one of the very
first tools we ever wrote. The [wof-es-index](https://github.com/whosonfirst/py-mapzen-whosonfirst-search#wof-es-index) tool is used to crawl a
directory full of Who's On First GeoJSON data files and index them in the Who's
On First Spelunker [Elasticsearch
index](https://github.com/whosonfirst/es-whosonfirst-schema). It has been updated to also read and index WOF data stored in the SQLite
databases we're generating. In [Dan's original blog
post](/blog/2017/12/21/wof-in-a-box/#index) you would index the Spelunker like this:

```
> cd /usr/local/data/whosonfirst-data
> wof-es-index -s . --index=spelunker -b
```

And now you can do this:

```
> wof-es-index -b -m sqlite /usr/local/data/whosonfirst-data-*-latest.db
```

The `-s(ource)` flag has been deprecated and replaced with the `-m(ode)` flag
which can [index a number of different data sources](https://github.com/whosonfirst/py-mapzen-whosonfirst-index): Git repositories, SQLite
databases, one or more GeoJSON files and so on. It is also no longer necessary
to pass the `-i(ndex)` flag since it defaults to "spelunker" now. The trusty
`-b(ulk)` flags remains unchanged for speeding up indexing.

So, it's only a pair of small tweaks to Dan's instructions but hopefully they are useful ones.

![](images/wof-phone.jpg)

There's been a lot of work on the SQLite databases leading up to those tweaks
including adding full-text and spatial
indexing as well as refactoring the code in to re-usable components so that
it can be used for other kinds of data, specifically [Who's On First
brands](https://github.com/whosonfirst-data/whosonfirst-brands) and Markdown
files.

In all there are three distinct packages, two of them for Who's On First features and
brands and another for generic Markdown files, and a fourth shared by all the others:

* [https://github.com/whosonfirst/go-whosonfirst-sqlite#interfaces](https://github.com/whosonfirst/go-whosonfirst-sqlite#interfaces)

* [https://github.com/whosonfirst/go-whosonfirst-sqlite-features](https://github.com/whosonfirst/go-whosonfirst-sqlite-features)

* [https://github.com/whosonfirst/go-whosonfirst-sqlite-brands](https://github.com/whosonfirst/go-whosonfirst-sqlite-brands)

* [https://github.com/whosonfirst/go-whosonfirst-sqlite-markdown](https://github.com/whosonfirst/go-whosonfirst-sqlite-markdown)

_There is even an experimental `go-whosonfirst-sqlite` package for working with [Privatezen](/blog/2018/02/02/privatezen/) databases but it's still too soon to discuss that yet._

The support for Markdown files is not as much of a non-sequitur as it might
seem. Part of living in a [post-Mapzen world](blog/2018/01/02/chapter-two/) has involved moving all the
Who's On First blog posts (from the Mapzen website) [over here](/blog). That's
meant writing [our own suite of tools](https://github.com/whosonfirst/go-whosonfirst-markdown) to render the Jekyll-flavoured Markdown
files that we've always used for blog posts.

Last summer we launched ["version 2"](/blog/2017/07/28/wof-website-redesign/) of the Who's
On First website, the result of [Scott
Dombrowski](http://scottdombkowski.com/) 's internship with Mapzen. It has been
a huge UI and UX improvement and helped corral all the many different sources of
documentation in to one place. 

On the other hand the website still requires more work than it should in order to update or
add new pages so "version 3" will essentially be Markdown files written by hand or derived
from machine readable data that will be rendered as HTML with the same tools
that I wrote for the blog. 

The value of being able to index Markdown files in SQLite is that we are now able to do full-text search, first for the blog but ultimately for all the WOF related
documentation, once [the "version 3" work](https://github.com/whosonfirst/whosonfirst-www/milestone/3) is completed:

```
> ./bin/wof-sqlite-query-markdown -dsn test.db montreal
15:49:12.499695 [wof-sqlite-query-markdown] STATUS montreal - /blog/2015/08/18/who-s-on-first/
15:49:12.499856 [wof-sqlite-query-markdown] STATUS montreal - /blog/2017/04/04/whosonfirst-api/
15:49:12.499906 [wof-sqlite-query-markdown] STATUS montreal - /blog/2017/10/17/whosonfirst-nacis-2017/
15:49:12.499936 [wof-sqlite-query-markdown] STATUS montreal - /blog/2017/12/22/neighbourhood-updates-three/
15:49:12.500024 [wof-sqlite-query-markdown] STATUS montreal - /blog/2015/08/18/who-s-on-first/
``` 

_Careful readers will note that it's still not possible to search the weblog on the weblog itself. It
will become possible, I promise, just not today..._ 

We used the blog as a testing and proving ground for how full-text search should
work and then applied those lessons to the tools we use to index brands:

```
> ./bin/wof-sqlite-query-brands -dsn test.db 'car* bank'
17:23:40.459620 [wof-sqlite-query-brands] STATUS car* bank - 1125154403 Carolina First Bank
17:23:40.459746 [wof-sqlite-query-brands] STATUS car* bank - 1125153083 Central Carolina Bank
```

And then finally for actual [Who's On First documents](https://github.com/whosonfirst/go-whosonfirst-sqlite-features#wof-sqlite-query-features):

```
> ./bin/wof-sqlite-query-features -dsn test2.db JFK
102534365,John F Kennedy Int'l Airport

./bin/wof-sqlite-query-features -dsn test2.db -column names_colloquial Paris
85922583,San Francisco
102027181,Shanghai
102030585,Kolkata
101751929,Tromsø
```

We've also added the ability to index and query Who's On First geometries for
people who have the [Spatialite](https://www.gaia-gis.it/fossil/libspatialite/index) extension installed on their computers.

```
> ./bin/wof-sqlite-index-features -timings -live-hard-die-fast -spr -geometries -driver spatialite -mode repo -dsn test.db /usr/local/data/whosonfirst-data-constituency-ca/
10:09:46.534281 [wof-sqlite-index-features] STATUS time to index geometries (87) : 21.251828704s
10:09:46.534379 [wof-sqlite-index-features] STATUS time to index spr (87) : 3.206930799s
10:09:46.534385 [wof-sqlite-index-features] STATUS time to index all (87) : 24.48004637s

> sqlite3 test.db
SQLite version 3.21.0 2017-10-24 18:55:49
Enter ".help" for usage hints.

sqlite> SELECT load_extension('mod_spatialite.dylib');
sqlite> SELECT s.id, s.name FROM spr s, geometries g WHERE ST_Intersects(g.geom, GeomFromText('POINT(-122.229137 49.450129)', 4326)) AND g.id = s.id;
1108962831|Maple Ridge-Pitt Meadows
```

Now that we've sorted out how to index and query spatial properties in the
SQLite databases we've also begun work on a `spatialite` branch of the [Who's On First point-in-polygon
(PIP)
server](https://github.com/whosonfirst/go-whosonfirst-pip-v2/tree/spatialite).

The idea
is to speed up indexing time and memory usage (and maybe even query time) by teaching
the code to use the newer SQLite databases instead of an [in-memory
RTree](/blog/2016/02/19/iamhere/). Our hope is people can simply download one or
more of the SQLite databases using the `wof-dist-fetch` tool described above,
point the PIP server at those databases and having a working services in a
matter of minutes.

The other hope is that these SQLite databases can be integrated with existing
Who's On First applications, like the Spelunker or the
[API](/blog/2017/04/04/whosonfirst-api/), to provide an abbreviated set of features – a sort of "Who's On First Lite" – for people who aren't in a position to set up more
complicated databases like Elasticsearch.

There's still some heavy-lifting and hoop-jumping to complete before any of this is possible but that is the goal.

![](images/wof-jetway-2.jpg)

There are three reasons we've been spending so much time on the SQLite databases:

1. They are super cool and super useful in their own right.

2. Life has been mostly interupt-driven since the Mapzen shutdown and hasn't
lent itself to more concentrated work.

3. I have a hunch that we can use these SQLite databases to more effeciently
update all the _other_ tools and services whether it's the Spelunker, the API, the raw
[data.whosonfirst.org](https://data.whosonfirst.org) files or [other bulk
distributions](http://localhost:8080/download/) that people might want to
download.

But that means _building_ those SQLite databases first and doing so in a timely
and automated fashion when changes are pushed to the [actual Who's On First
data](https://github.com/whosonfirst-data). That's where we're at today: Working
through those details and figuring out how to improve on [the bubble-gum and duct
tape solutions](https://github.com/whosonfirst/go-whosonfirst-updated#go-whosonfirst-updated) that got us this far. 

The goal for the next phase of work is to set up a reliable workflow for
generating both [bundles](http://localhost:8080/download/#bundles) and
[SQLite](http://localhost:8080/download/#sqlite) databases for each of the
[whosonfirst-data](https://github.com/whosonfirst-data) repositories, along with
a standardized "inventory" file for both formats that can be consumed by the
`wof-dist-fetch` tool, and then to use those distributions to update the
[Spelunker](https://spelunker.whosonfirst.org/) and the
[places.whosonfirst.org](https://places.whosonfirst.org/) endpoint.

_If you're curious you can follow along in
the [sqlite](https://github.com/whosonfirst/go-whosonfirst-dist/blob/sqlite/cmd/wof-dist-build.go)
and [bundles](https://github.com/whosonfirst/go-whosonfirst-dist/blob/bundles/cmd/wof-dist-build.go)
branches of the
[go-whosonfirst-dist](https://github.com/whosonfirst/go-whosonfirst-dist)
package._

Once that's working then we'll turn our attention to spinning up the [Who's On
First API](/blog/2017/04/04/whosonfirst-api/) again. No one is working on this "40 hours a week" anymore so it
may take a bit longer than we'd like but hopefully not too much longer.

In the meantime, [the Spelunker is back!](https://spelunker.whosonfirst.org/)
