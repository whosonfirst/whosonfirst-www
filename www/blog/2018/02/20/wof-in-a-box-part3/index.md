---
layout: page
title: WOF in a Box (part 3)
published: false
date: 2018-02-20
permalink: /blog/2018/02/20/wof-in-a-box-part3/
category: blog
excerpt: 
authors: [thisisaaronland]
image: "images/cube.jpg"
tag: [spelunker,whosonfirst]
---

The Who's On First Spelunker lives again! It's new home is:

<div style="font-size:2em; text-align:center; margin-top:1em;">
     <a href="https://spelunker.whosonfirst.org/">https://spelunker.whosonfirst.org/</a>
</div>

All the old URLs should work as before once you update the root, replacing
`whosonfirst.mapzen.com/spelunker` with `spelunker.whosonfirst.org`. For example, the URL for the Who's On First record for
[Tokyo](https://spelunker.whosonfirst.org/id/102031307/) used to be:

<div style="font-size:2em; text-align:center; margin-top:1em;">
     <a href="#" style="color:#666 !important;">https://whosonfirst.mapzen.com/spelunker/id/102031307/</a>
</div>

And now it is:

<div style="font-size:2em; text-align:center; margin-top:1em;">
     <a href="https://spelunker.whosonfirst.org/id/102031307/">https://spelunker.whosonfirst.org/id/102031307/</a>
</div>

---

The Spelunker was rebuilt on a bare [Ubuntu
16.04](https://wiki.ubuntu.com/XenialXerus/ReleaseNotes) Linux server, following
Dan's [WOF in a Box](/blog/2017/12/21/wof-in-a-box/) instructions and
everything worked without a hitch. Along the way, I made some updates to the
"fetching and indexing data" piece specifically to make things "faster and
easier" for people who just want to work with the data as-is and don't need to
make updates.

_These updates actually introduced some "hitches" in Dan's guide but with [Gary
Gale](https://www.vicchi.org/) 's help we were able to make short work of those
bugs and everything should work as advertised again..._

Historically all the Who's On First tools have been designed to work with the
raw (plain-text GeoJSON) data contained in the GitHub repositories. It's
important that there always be tooling to work with the raw "at rest" data but
it can be unnecessarily fiddly for a lot of people.

We've been doing a lot of work recently to distribute Who's On First data as
SQLite databases. SQLite databases have the advantage of being self-contained
and widespread support in a variety of tools and programming languages. They
don't currently include "alternate geometry" WOF records but those
aren't necessary (yet) for most things people want to do with WOF related tools.

The first tool that we wrote is a simple command-line tool to fetch all of the
databases defined in an `inventory.json` file. These `inventory.json` files are still a work in progress and currently only
published for SQLite databases. As we chip away at the remaining work to
generate other Who's On First distributions the plan is to adopt (and adapt) the
inventory files accordingly.

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

This replaces the steps described in the [Download some
data](/blog/2017/12/21/wof-in-a-box/#download) section of Dan's post. It will
still take a while to download all the SQLite databases but they are generally
smaller and easier to work with than the Git repositories and don't require
setting up additional tools like [Git LFS](https://github.com/whosonfirst-data/whosonfirst-data#git-and-large-files).

This tool is part of the [go-whosonfirst-dist](https://github.com/whosonfirst/go-whosonfirst-dist) package which will also be used
to _generate_ those SQLite files (and other distributions) but it still being
actively developed so you probably shouldn't try using it yet, unless you are
feeling adventurous.

The second tool that we wrote was actually just an update to one of the very
first tools we ever wrote: The [wof-es-index]() tool which is used to crawl a
directory full of Who's On First GeoJSON data files and index them in the Who's
On First Spelunker [Elasticsearch index]().

The tool has been updated to also read and index WOF data stored in the SQLite
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

---

There's been a lot of work on the SQLite databases adding full-text and spatial
functionality as well as refactoring the code in to re-usable components so that
it can be used for other kinds of data, specifically [Who's On First
brands](https://github.com/whosonfirst-data/whosonfirst-brands) and Markdown files.

* [https://github.com/whosonfirst/go-whosonfirst-sqlite#interfaces](https://github.com/whosonfirst/go-whosonfirst-sqlite#interfaces)

* [https://github.com/whosonfirst/go-whosonfirst-sqlite-features](https://github.com/whosonfirst/go-whosonfirst-sqlite-features)

* [https://github.com/whosonfirst/go-whosonfirst-sqlite-brands](https://github.com/whosonfirst/go-whosonfirst-sqlite-brands)

* [https://github.com/whosonfirst/go-whosonfirst-sqlite-markdown](https://github.com/whosonfirst/go-whosonfirst-sqlite-markdown)

The support for Markdown files is not as much of a non-sequitur as it might
seem. Part of living in a [post-Mapzen world](blog/2018/01/02/chapter-two/) has involved moving all the
Who's On First blog posts (from the Mapzen website) [over here](/blog). That's
meant writing [our own suite of tools](https://github.com/whosonfirst/go-whosonfirst-markdown) to render the Jekyll-flavoured Markdown
files that we've always used for blog posts.

We launched ["version 2"](/blog/2017/07/28/wof-website-redesign/) of the Who's
On First website last summer, the result of [Scott
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

...Spatialite!

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

There is also a `spatialite` branch of the [Who's On First point-in-polygon
(PIP) server](https://github.com/whosonfirst/go-whosonfirst-pip-v2/). The idea
is to speed up indexing time and memory usage (and maybe even query time) by teaching
the code to use the newer SQLite databases instead of an [in-memory RTree](/blog/2016/02/19/iamhere/):

* [https://github.com/whosonfirst/go-whosonfirst-pip-v2/tree/spatialite](https://github.com/whosonfirst/go-whosonfirst-pip-v2/tree/spatialite)

This is code that _does not work_ yet and I am going to kick the tires using
another [unrelated project](https://github.com/aaronland/go-marc) that I started working on for the New South Wales
library last year that will allow them to upload a CSV file full of MARC 034
fields and get back a CSV file of WOF IDs which intersect that bounding box (034
field).
