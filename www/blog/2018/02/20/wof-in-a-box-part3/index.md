---
layout: page
title: WOF in a Box, Part 3
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
Dan's [WOF in a Box](/blog/2017/12/21/wof-in-a-box/) instructions which and
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
$> wof-dist-fetch -inventory https://dist.whosonfirst.org/sqlite/inventory.json -dest /usr/local/data
...time passes...

$> ls -d /usr/local/data/whosonfirst-data*
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
$> cd /usr/local/data/whosonfirst-data
$> wof-es-index -s . --index=spelunker -b
```

And now you can do this:

```
$> wof-es-index -b -m sqlite /usr/local/data/whosonfirst-data-*-latest.db
```

The `-s(ource)` flag has been deprecated and replaced with the `-m(ode)` flag
which can index a number of different data sources (Git repositories, SQLite
databases, one or more GeoJSON files and so on). It is also no longer necessary
to pass the `-i(ndex)` flag since it defaults to "spelunker" now. The trusty
`-b(ulk)` flags remains unchanged for speeding up indexing.


...[go-whosonfirst-index]()...

---
