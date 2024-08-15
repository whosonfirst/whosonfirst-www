---
layout: page
title: De-duplicating venues with vector embeddings
published: false
date: 2024-08-16
permalink: /blog/2024/08/16/dedupe/
category: blog
excerpt: "..."
authors: [thisisaaronland]
image: ""
tag: [venues,download,whosonfirst,wof,data]
---
![](images/200157_a2963607223a77cf_b.jpg)

<div style="font-size:small;font-style:italic;text-align:center;">
Card, Karrie Jacobs: Change of Address; offset lithograph on paper; 11.8 x 16.3 cm (4 5/8 x 6 5/8 in.); Tibor Kalman <a href="https://collection.cooperhewitt.org/objects/18644345/">Collection of Cooper Hewitt Museum</a>.</div>

> If address parsing is where you go to cry then address de-duplication is where you go to give up.

I said that in 2017 as part of [a talk I did at State of the Map US](https://whosonfirst.org/blog/2017/10/24/whosonfirst-sotmus-2017/) about the work the Who's On First project was around publishing venue records, including [Al Barrantine's work to de-deplicate those records](https://github.com/openvenues/lieu). Unfortunately, a few months later [Mapzen shut down](https://whosonfirst.org/blog/2018/01/02/chapter-two/) so all of that work stalled out after that.

Earlier this year I started to wonder whether it would be possible to use the vector embeddings for texts produced by, and for, large language models to restart some of that work. The short answer is: We can. The longer answer is: Nothing is especially "fast" yet and the code preferences (relative) ease of use, modularity and reproducability in favour of speed and other optimizations.

So far, I have been able to first deprecate about 50,000 duplicate records in four Who's On First venue repositories (...) and then derive 70,000 concordances with [Overture Data](#) place records, 10, 000 concordances with [All The Places](#) venues and another (N) concordances with [ILMS museum records](#). There are almost certainly still bugs, or at least "gotchas", but importantly the work so far passes the "better than yesterday" test.

![](images/91579_eee532aad4b0955d_b.jpg)

https://collection.cooperhewitt.org/objects/18653089/

This code works around (1) common struct and (5) interfaces, and their provider-specific implementations. They are:

* [location.Location](location/README.md#locationlocation) – A Go language struct containing a normalized representation of a place or venue.

* [location.Parser](location/README.md#locationparser) – A Go language interface for parsing JSON-encoded GeoJSON records and producing `location.Location` instances.

* [location.Database](location/README.md#locationdatabase) – A Go language interface for storing and querying `location.Location` records.

* [iterator.Iterator](iterator/README.md) – A Go language interface for iterating through arbirtrary database sources and emiting JSON-encoded GeoJSON records.

* [embeddings.Embedder](embeddings/README.md) – A Go language interface for generating vector embeddings from input text.
* [vector.Database](vector/README.md) – A Go language interface for storing and querying vector embeddings.

The basic working model is as follows:

* Given a data source or provider, iterate through its records generating and storing `location.Location` records.
* Given two databases of `location.Location` records, one of them the "source" and the other the "target":
* Derive the set of unique 5-character geohashes from the records in the "target" database.
* For each of those geohashes, find all the `location.Location` records in the "source" database which a matching geohash and index each record in a vector database.
* Store each matching ("source") `location.Location` record in a vector database deriving its embeddings using an `embeddings.Embedder` instance.
* Query each of the ("target") records matching a given geohash against the records in the vector database; as with the records in the second database, embeddings for each record in the first database are derived using an `embeddings.Embedder` instance.
* Matching records are emitted as CSV-encoded rows.

What happens with those CSV rows of matching records is left for implementors to decide. For example:

<pre>
$> tail -f /usr/local/data/wof-wof-ny.csv
dr5rr,wof:id=353594351,wof:id=353593911,"Cogliano Angelo Jr, 9407 101st Ave Ozone Park NY 11416","Cogliano Angelo Acctnt Jr, 9407 101st Avenue Ozone Park NY 11416",3.018408
dr5xg,wof:id=572126199,wof:id=287214377,"Prosthodontic Associates PC, 1 Hollow Ln Ste 202 New Hyde Park NY 11042","Prosthodontic Associates, 1 Hollow Ln New Hyde Park NY 11042",3.716114
dr5x6,wof:id=303812969,wof:id=269602859,"Hudson Shipping Lines Corp, 20 W Lincoln Ave Valley Stream NY 11580","Hudson Shipping Lines Corp, 20 E Lincoln Ave Valley Stream NY 11580",0.795845
dr7b3,wof:id=370248145,wof:id=253556813,"Pisciotta Capital, 775 Park Dr Huntington Station NY 11793","Pisciotta Capital, 775 Park Ave Huntington NY 11743",3.776641
dr8v9,wof:id=387002999,wof:id=320123265,"Gray Cpa Pc, 16 E Main St Ste 400 Rochester NY 14614","Gray CPA PC, 16 Main St W Rochester NY 14614",2.519037
dr5xq,wof:id=353801261,wof:id=270152357,"Maurice Fur Designer, 69 Merrick Ave Merrick NY 11566","Maurice Fur Designer-Merrick, 69 Merrick Rd North Merrick NY 11566",3.880814
dr5xq,wof:id=555197305,wof:id=253237525,"Matteo's Cafe, 412 Bedford Ave Bellmore NY 11710","Matteos Cafe, 416 Bedford Ave Bellmore NY 11710",3.053007
</pre>

And so on.

![](images/209192_293a68417192660f_b.jpg)

https://collection.cooperhewitt.org/objects/152749803/

There are a few things to note about this approach:

* A 5-character geohash represents an area of approximately 2.4 km. In the future it may be the case that a longer geohash will be stored (in the location database) and a variable length geohash will be queried based on properties that can be derived about a location. For example, a venue in the center of Manhattan might use a longer, more precise geohash, versus a venue in a rural area might use a shorter, more inclusive, geohash.
* Likewise, if `location.Location` records have been supplemented with Who's On First hierarchies (on ingest or at runtime) then they might also be filtered by geohash _and_ region to account for the fact that the same geohash can span multiple administrative boundaries (for example `dr5re`).
* This code works best with small and short-lived (temporary) vector databases on disk or in memory. Storing and querying millions of venue records and their embeddings on consumer grade hardware (my laptop) is generally slow and impractical. Many (but not all, yet) of the `vector.Database` implementations have been configured with the ability to create (and remove) temporary databases automatically.

![](images/50841_91faa27aa6285c00_b.jpg)

https://collection.cooperhewitt.org/objects/18446851/