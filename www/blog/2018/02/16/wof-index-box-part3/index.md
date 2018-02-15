---
layout: page
published: false
date: 2018-02-16
permalink: /blog/2018/02/16/wof-in-a-box-part3/
title: WOF in a Box (part 3)
category: blog
excerpt: Run Who's On First on your own hardware.
authors: [thisisaaronland]
image: "images/cats-in-boxes.jpg"
tag: [golang,python,spelunker,sqlite,whosonfirst]
---

...[wof-dist-fetch](https://github.com/whosonfirst/go-whosonfirst-dist) tool.

```
./bin/wof-dist-fetch -dest /usr/local/data
```

...[wof-es-index](https://github.com/whosonfirst/py-mapzen-whosonfirst-search#wof-es-index) tool.

```
./scripts/wof-es-index -m sqlite /usr/local/data/*-latest.db
```

...something something something [Nextzen API keys](https://developers.nextzen.org/keys)

...something something something `Docker`
