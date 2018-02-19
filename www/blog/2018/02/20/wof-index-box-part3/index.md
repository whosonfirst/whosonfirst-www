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

Here's the punchline: The Spelunker is live again! It's new home is:

[https://spelunker.whosonfirst.org](https://spelunker.whosonfirst.org)

All the old URLs should "just work" once you update the root, replacing `whosonfirst.mapzen.com/spelunker` with `spelunker.whosonfirst.org`.

For example, if you were linking to the Who's On First record for [Tokyo](https://spelunker.whosonfirst.org/id/102031307/) at this URL:

`https://whosonfirst.mapzen.com/spelunker/id/102031307/`

You should now point to:

`https://spelunker.whosonfirst.org/id/102031307/`

---

We rebuilt the Spelunker, on a bare Ubuntu Linux server, following Dan's [WOF in a Box]() instructions which and everything worked without a hitch.

...I made some updates to the "fetching and indexing data" piece, specifically to make things "faster and easier".

Historically all the Who's On First tools have been designed to work with the raw (plain-text GeoJSON) data contained in the GitHub repositories. It's important that there always be tooling ...

...generating SQLite databases...

The first tool that we wrote is a simple command-line tool to fetch all of the databases defined in an `inventory.json` file

```
./bin/wof-dist-fetch -inventory https://dist.whosonfirst.org/sqlite/inventory.json -dest /usr/local/data
...time passes...

ls -d /usr/local/data/whosonfirst-data*
```

This tool is part of the [go-whosonfirst-dist]() package which will also be used to _generate_ those SQLite files (and other distributions) but it still being actively developed so you probably shouldn't try using it yet, unless you are feeling adventurous.

The second tool that we wrote was actually just an update to one of the very first tools we ever wrote: A command line tool to crawl a directory full of Who's On First GeoJSON data files and index them in the Who's On First Spelunker Elasticsearch index.

The update 

```
./scripts/wof-es-index -mode sqlite /usr/local/data/whosonfirst-data-*-latest.db
```

...[go-whosonfirst-index]()...

---
