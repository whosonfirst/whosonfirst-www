---
layout: page
date: 2017-04-04
permalink: /blog/2017/04/04/whosonfirst-api/
published: true
title: The Who's On First API
category: blog
excerpt: Anything you can do by clicking around the Spelunker should be able to be automated using code.
authors: [thisisaaronland]
image: images/splash-sq.png
tag: [whosonfirst]
---

<a href="https://en.wikipedia.org/wiki/Common_Gateway_Interface"><img width="600" height="200" src="images/splash.png"></a>

Today we are pleased to announce [the Who's On First API](https://mapzen.com/documentation/wof/). This is something that has been hiding in plain sight for a little while now and that a few people may have noticed if they "looked under the hood" of the [Spelunker code](https://github.com/whosonfirst/whosonfirst-www-spelunker/) following the recent blog post about the [Who's On First bundler tool](https://mapzen.com/blog/bundler/).

The API provides programmatic access for you and your robots to all the [Who's On First data](https://github.com/whosonfirst-data). You can query [individual places](https://mapzen.com/documentation/wof/methods/#whosonfirstplaces) and their relations, look for [concordances](https://mapzen.com/documentation/wof/methods/#whosonfirstconcordances) and perform [basic spatial queries](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getIntersects). You can also use the API to query things like all the different [placetypes](https://mapzen.com/documentation/wof/methods/#whosonfirstplacetypes) or [sources](https://mapzen.com/documentation/wof/methods/#whosonfirstsources) for data. It is not a "complete" API yet. The first goal for the API is to achieve parity with the [Spelunker](https://whosonfirst.mapzen.com/spelunker/): anything you can do by clicking around that website manually should be able to be automated using code.

You should treat this API as though it were still in “beta”. Which is to say: the point is for _the thing to work_ but there are probably still some rough edges and lingering gotchas so you should adjust your expectations and your code accordingly. In the meantime have at it and [please let us know on Twitter](https://twitter.com/alloftheplaces) or [contact us through email](mailto:hello@mapzen.com) if something is busted or just doesn’t feel right.

If you want to dive in right away and come back for storytime later the documentation is here:

<div style="text-align:center;"><a href="https://mapzen.com/documentation/wof/">https://mapzen.com/documentation/wof/</a></div>

## "Stuff over HTTP"

The API uses a parameter-based [stuff over HTTP](http://www.aaronland.info/weblog/2014/02/10/36hours/#what) style interface. Currently all API methods are read-only so everything is sent using [the HTTP GET verb](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3). If the method is successful the result with be returned with an HTTP `200 OK` response. If there was a problem with the request then an error will be returned in [the HTTP 400-499 range](https://mapzen.com/documentation/wof/errors/#client-side-errors). If there was a problem generating a response then an error will be returned in [the HTTP 500-599 range](https://mapzen.com/documentation/wof/errors/#server-side-errors).

Successful API responses can be returned in one of three possible formats: [JSON](https://mapzen.com/documentation/wof/formats/#json), [CSV](https://mapzen.com/documentation/wof/formats/#csv) and Who's On First's own "[meta](https://mapzen.com/documentation/wof/formats/#meta)" format (which is just a CSV file with fixed headers). JSON is the default response format and available for all methods. CSV is available for most methods. Meta responses are available for methods where it makes sense.

Meta files are the CSV files included with every [Who's On First data repository](https://github.com/whosonfirst-data). The easiest way to think about meta files is that they canned indices or views in to the data; a way for people to grab or work with a slice of the data, say by placetype, without having to set up and load everything in to a database. As such, a lot of tooling has been built to consume meta files from the [I Am Here](https://mapzen.com/blog/iamhere) tool, to the Who's On First [point-in-polygon server](https://github.com/whosonfirst/go-whosonfirst-pip/), to the tools we use to [generate bundles](https://github.com/whosonfirst/go-whosonfirst-clone#example) (you can read more about bundles [over here](https://whosonfirst.mapzen.com/bundles/)), to indexing WOF data in [in third-party tools like Tile38](https://github.com/whosonfirst/go-whosonfirst-tile38#example-1) to [generating FeatureCollections](https://github.com/whosonfirst/py-mapzen-whosonfirst-utils/blob/master/scripts/wof-csv-to-feature-collection). Now rather than just consuming the [default meta files](https://github.com/whosonfirst-data/whosonfirst-data/tree/master/meta) included with each repository all of those tools can be fed the output of whatever query you dream up using the [whosonfirst.places.search](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.search), or similar, API methods.

<a href="https://collection.cooperhewitt.org/objects/18214745/"><img width="589" height="589" src="images/gate.jpg"></a>

Other API responses can and will be added as time and circumstance permit. We are interested in people _using_ the Who's On First API in whatever format their software needs and with not in making our opinions about API responses someone else's problem. If there's a particular response format you need to start using the Who's On First API please send up a flare [via email](mailto:hello@mapzen.com) or [Twitter](https://twitter.com/alloftheplaces).

## Examples

### [whosonfirst.concordances.getById](https://mapzen.com/documentation/wof/methods/#whosonfirst.concordances.getById)

Here are all the concordances in Who's On First for the [GeoPlanet](https://whosonfirst.mapzen.com/spelunker/concordances/geoplanet/) ID for the city of [Montreal](https://whosonfirst.mapzen.com/spelunker/101736545) or `gp:id=3534`:

```JSON
curl -s -X GET 'https://whosonfirst-api.mapzen.com?method=whosonfirst.concordances.getById&api_key=mapzen-xxxxxx&id=3534&source=gp:id&page=1&per_page=100'
{
    "concordances": [
        {
            "dbp:id": "Montreal",
            "fb:id": "en.montreal",
            "fct:id": "03c06bce-8f76-11e1-848f-cfd5bf3ef515",
            "gn:id": 6077243,
            "gp:id": 3534,
            "loc:id": "n80132975",
            "nyt:id": "N59179828586486930801",
            "qs:id": "239659",
            "tgn:id": "7013051",
            "wd:id": "Q340",
            "wk:page": "Montreal",
            "wof:id": 101736545
        }
    ],
    "cursor": null,
    "next_query": null,
    "page": 1,
    "pages": 1,
    "per_page": 100,
    "stat": "ok",
    "total": 1
}
```

### [whosonfirst.places.getByLatLon](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getByLatLon)

Here are all the neighbourhoods (there's only one of them) at the corner of [16th and Mission](https://whosonfirst.mapzen.com/iamhere/#17/37.76494/-122.41944) in San Francisco:

```JSON
curl -s -X GET 'https://whosonfirst-api.mapzen.com?method=whosonfirst.places.getByLatLon&api_key=mapzen-xxxxxx&latitude=37.766633&longitude=-122.417693&placetype=neighbourhood&extras=mz:uri,geom:latitude,geom:longitude'
{
    "places": [
        {
            "geom:latitude": 37.758768,
            "geom:longitude": -122.413313,
            "mz:uri": "https://whosonfirst.mapzen.com/data/858/874/43/85887443.geojson",
            "wof:country": "US",
            "wof:id": 85887443,
            "wof:name": "Mission District",
            "wof:parent_id": "85922583",
            "wof:placetype": "neighbourhood",
            "wof:repo": "whosonfirst-data"
        }
    ],
    "stat": "ok"
}
```

There are a couple things to note about this API response. First, the "[minimum response data](http://code.flickr.net/2008/08/19/standard-photos-response-apis-for-civilized-age/)" for a place and second the use of the `extras` parameter to include additional information about a place. We're still working out what the final "minimum response" data structure for a place should be but so far we've settled on the following properties:

```JSON
{
	"wof:id": ...,
	"wof:name": "...",
	"wof:parent_id": ...,
	"wof:placetype": "...",
	"wof:repo": "..."
}
```

Every API method that returns a "place" as part of its response will be guaranteed to include those properties. If you need or want additional properties you can list them in the `extras` parameter. Passing the `extras=geom:latitude,geom:longitude` parameter will cause the API to add the geographic center a place's geometry to its response. You can also request entire classes of properties by passing only a prefix.

### [whosonfirst.places.getInfo](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getInfo)

For example to fetch [all the names](https://mapzen.com/blog/wikipedia-data/) for the city of Beijing you would pass `extras=name:`, like this:

```JSON
curl -s -X GET 'https://whosonfirst-api.mapzen.com?method=whosonfirst.places.getInfo&api_key=mapzen-xxxxxx&id=102027745&extras=name:'
{
    "place": {
        "name:ace_x_preferred": [
            "Beijing"
        ],
        "name:ady_x_preferred": [
            "\u041f\u0435\u043a\u0438\u043d"
        ],
        "name:afr_x_preferred": [
            "Beijing"
        ],
        "name:als_x_preferred": [
            "Peking"
        ],
        "name:amh_x_preferred": [
            "\u1264\u12ea\u1302\u1295\u130d"
        ],
        "name:ang_x_preferred": [
            "Beicing"
        ],

	...truncated for brevity...

	"name:zho_x_preferred": [
            "\u5317\u4eac\u5e02"
        ],
        "name:zho_x_variant": [
            "\u5317\u4eac\u5e02"
        ],
        "name:zho_yue_x_preferred": [
            "\u5317\u4eac"
        ],
        "wof:country": "CN",
        "wof:id": 102027745,
        "wof:name": "Beijing",
        "wof:parent_id": "85669727",
        "wof:placetype": "locality",
        "wof:repo": "whosonfirst-data"
    },
    "stat": "ok"
}
```

You can request any fully-qualified property, or property prefix, in the `extras` parameter. The API will check to ensure that the prefix for an extras parameter is defined in the [whosonfirst-sources](https://github.com/whosonfirst/whosonfirst-sources/tree/master/sources) list (there are [corresponding API methods for sources](https://mapzen.com/documentation/wof/methods/#whosonfirstsources)). As of this writing if an unknown prefix is requested it is silently ignored. _That might become an error in time. We'll see..._

### [whosonfirst.places.search](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.search)

Here are all the [microhoods](https://whosonfirst.mapzen.com/spelunker/placetypes/microhood) in Who's On First returned as a CSV document:

```bash
curl -s -i -X GET 'https://whosonfirst-api.mapzen.com?method=whosonfirst.places.search&api_key=mapzen-xxxxxx&placetype=microhood&page=1&per_page=10&format=csv'
HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Content-Type: text/csv
Date: Fri, 31 Mar 2017 21:41:50 GMT
Server: nginx/1.4.6 (Ubuntu)
Status: 200 OK
X-api-format-csv-header: wof_country,wof_id,wof_name,wof_parent_id,wof_placetype,wof_repo
X-api-pagination-cursor: cXV...c7MDs=
X-api-pagination-next-query: method=whosonfirst.places.search&amp;placetype=microhood&amp;format=csv&amp;per_page=10&amp;cursor=cXV...c7MDs%3D
X-api-pagination-page:
X-api-pagination-pages: 60
X-api-pagination-per-page: 10
X-api-pagination-total: 595
Content-Length: 746
Connection: keep-alive

wof_country,wof_id,wof_name,wof_parent_id,wof_placetype,wof_repo
US,1108802091,"Scripps Miramar Ranch",1108802089,microhood,whosonfirst-data
US,1108561153,"La Tuna Canyon",85865489,microhood,whosonfirst-data
US,1108750019,"Green Valley Ranch",420781629,microhood,whosonfirst-data
US,1075806299,"Northridge West",85838305,microhood,whosonfirst-data
DE,1108810201,Biesdorf-Sud,-3,microhood,whosonfirst-data
US,1108719769,"Rivergate Industrial District",85846673,microhood,whosonfirst-data
US,1108750017,Gateway,420781629,microhood,whosonfirst-data
US,1108750051,"Northeast Park Hill",85840547,microhood,whosonfirst-data
US,1091648325,"Hansen Dam",85865477,microhood,whosonfirst-data
US,1041491317,"Beverly Glen",85869119,microhood,whosonfirst-data
```

There are a couple of things to note about CSV formatted responses:

* The `:` character that normally separates a prefix from its value has been replaced by a `_`. For example `wof:id` becomes `wof_id` when it is encoded as a CSV column header. It's not awesome but lots of tools that consume CSV have problems with column headers containing colons so we just live with the inconsistency.
* Nested values (arrays and dictionaries) are returned as JSON-encoded strings. It is left up to consumers of the API to decode them as necessary.

Also, did you notice the many different pagination properties in the JSON responses and the HTTP headers for the CSV response? Yeah...

## A short miserable history of pagination

<a href="https://collection.cooperhewitt.org/objects/18805295/"><img width="589" height="400" src="images/unicorn.jpg"></a>

Pagination, the practice of chunking a lot of results in to smaller sets, shouldn’t be complicated. But it is. Because databases, after all these years, are still complicated beasts.

Databases have always been about trade-offs. No two databases are the same and so no two sets of trade-offs are the same either. The really short version is that some databases can’t tell you exactly how many results there are for a given query. Some databases can tell you how many results there are but can’t or won’t return results past a certain limit. Other databases can do both but only if you use something called a cursor for pagination rather than the traditional offset and limit model (as in “return the next 5 of 50 results starting from postion 20”).

A long time ago, [I worked at the photo-sharing website Flickr](https://www.flickr.com/photos/paulhammond/2883048077/). One of the limits of the [Flickr API](https://www.flickr.com/services/api) is that the `flickr.photos.search` method was, and still is, capped at 4,000 results for any single query. This was a limit of [Flickr's search engine](http://aaronland.info/talks/mw10_machinetags/#92), an early and proprietary version of applications like [Solr](https://lucene.apache.org/solr/) and more recently [Elasticsearch](https://www.elastic.co/guide/en/elasticsearch) which are often referred to as "document stores".

Document stores are similar to relational databases (think of the many different `something-SQL` databases people talk about) in that you can query them and get stuff back. Relational databases and document stores are very different in how they accomplish the same task and one of the limitations of the latter has always been that they aren't really designed to return the "long tail" of results for a query with lots of results.

When I last checked the Flickr website it returns [1,844,154 photos when you search for kittens](https://www.flickr.com/search/?text=kittens). If you query the Flickr API for photos tagged "kittens" it says there are 429,203 photos. The disparity is because people are allowed to opt-out of including their photos in API results.

Here is the first result at around the 4,000 mark (500 photos per request * page 8, out of a possible 859):

```JSON
https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=*****&tags=kittens&per_page=500&page=8&format=json&nojsoncallback=1&api_sig=*****

{ "photos": { "page": 8, "pages": "859", "perpage": "500", "total": "429203",
    "photo": [
          { "id": "33746803785", "owner": "148036032@N07", "secret": "4f91e6622b", "server": "2809", "farm": 3, "title": "Heineka’s “I’m ready for bed stare” - The Caturday", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
```

And here's the same query but at the 5,000 mark (500 photos per request * page 10):

```JSON
https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=*****&tags=kittens&per_page=500&page=10&format=json&nojsoncallback=1&api_sig=*****

{ "photos": { "page": 10, "pages": "859", "perpage": "500", "total": "429203",
    "photo": [
          { "id": "33746803785", "owner": "148036032@N07", "secret": "4f91e6622b", "server": "2809", "farm": 3, "title": "Heineka’s “I’m ready for bed stare” - The Caturday", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
```

See what's happening there? It's the same photo at the beginning of the list even though the results are a thousand photos apart. The search engine is configured to return the same results for every request over the 4,000 results limit. This is not a new thing. This is also not a Flickr thing. It's a document store thing. Even today, ten years, later the state of the art hasn't improved all that much: In 2017, Elasticsearch still has [a hard limit of 10,000 results](https://www.elastic.co/guide/en/elasticsearch/guide/current/pagination.html) for a single query.

The reason I mention all of this is not to pick on Flickr or Elasticsearch or anyone else working with document stores. The performance of "traditional" relational databases is also known to increasingly degrade as you offset further and further in to a large result set (the rule of thumb is that things start to get painful around the 500,000 record mark). The limits imposed by document stores are often worth it because they allow you perform complex queries that would otherwise be impossible or impractical in another database. I mention all of this for two reasons:

First, there remains a lot of interesting and important work to do designing interfaces and models to account for the inability of databases to reliably (or efficiently) return all the results for a large query. The 4,000 results limit was [well-known by developers](https://www.flickr.com/groups/api/discuss/72157663968579450/) using the Flickr API. We didn't hide that it happened but we also didn't see it as an opportunity to encourage developers to think about different ways to imagine what search should look like or how people should think about using it. The work that [George Oates](https://en.wikipedia.org/wiki/George_Oates) did redesigning the search and subject pages for the [Internet Archive's Open Library project](https://archive.org/details/Kohacon2010OpenLibraryPresentation-GeorgeOates) is a good example of how we might approach that problem, going forward.

Second, the reason for telling you all of this "exciting" detail from the past is to help explain how and why we've implemented pagination for the Who's On First API in the present. Who's On First is all about [the relationship between places](https://whosonfirst.mapzen.com/placetypes) and sometimes a place (like a country) will have lots and lots of relationships (like all the venues in that country). We don't really have the luxury of "ranking" those relationships and only returning the top 4,000 (or 10,000) results. We need to find a way to return [all the things](https://mapzen.com/blog/all-of-the-places).

Further, Who's On First uses multiple, different databases by design. We do this to ensure that the data and the overall data modeling is flexible enough to work with as many tools as possible. That's very important to the project because we want to make sure that the infrastructure burden required to _do_ something with Who's On First data is as a light as possible and not a reflection of Mapzen's specific needs to operationalize things or the inertia of our own preferences.

For example the [Spelunker](https://whosonfirst.mapzen.com/spelunker) is built using Elasticsearch but has no spatial indices even though they are supported. We set things up this way to make sure, to prove, that it was possible to use the data without _requiring_ a spatial database.

Since there is no all-purpose database, the Who's On First API accounts for multiple different pagination models. We've identified four overlapping models ([plain](#pagination-plain), [cursor](#pagination-cursor), [mixed](#pagination-mixed) and [next-query](#pagination-next-query)) each of which are described in detail below. If you don't really care and just want to get started [you should skip ahead to the discussion of next-query pagination](#pagination-next-query).

<a name="pagination-plain"></a>
### Plain pagination

Plain pagination assumes that we know how many results a query yields and that we can fetch any set of results at any given offset. For example, let's say you wanted to use the API to fetch all the places with a variant name containing the word `Paris` in sets of five. The API will respond with something like this:

```JSON
{
	"places": [ ... ],
	"next_query": "method=whosonfirst.places.search&alt=Paris&per_page=5&page=2",
	"total": 7,
	"page": 1,
	"per_page": 5,
	"pages": 2,
	"cursor": null,
	"stat": "ok"
}
```

It's pretty straightforward. There are seven results (`total`) and this is the first of two pages worth of results (`page` and `pages`, respectively). You might already be wondering about the `next_query` property but [we'll get to that shortly](#pagination-next-query).

<a name="pagination-cursor"></a>
### Cursor-based pagination

Cursor-based pagination is necessary when a database can't or won't tell you how many results there are for a query. This means you will need to pass the same query to the database over and over again for as long as the database returns a `cursor` which is like a secret hint _that only the database understands_ indicating where the next set of results live.

For example, let's say you wanted to use the API to fetch all of the venues near the [Smithsonian Cooper Hewitt Design Museum](https://whosonfirst.mapzen.com/spelunker/id/420571601/) in sets of ten. The API will respond with something like this:

```JSON
{
	"places": [ ... ],
	"next_query": "method=whosonfirst.places.getNearby&latitude=40.784165&longitude=-73.958110&placetype=venue&per_page=10&cursor={CURSOR}",
	"per_page": 10,
	"cursor": {CURSOR},
	"stat": "ok"
}
```

In order to fetch the next set of results you would include a `cursor={CURSOR}` parameter in your request, rather than a `page={PAGE_NUMBER}` parameter like you would with plain pagination. Some databases yield time-sensitive cursors that expire after a number of seconds or minutes so the easiest way to think about cursors is that they are _all_ time sensitive.

_Databases, amirite?_

<a name="pagination-mixed"></a>
### Mixed pagination

This is where it gets fun. Sometimes an API method might use _both_ plain and cursor-based pagination. That can happen when an underlying database is able to calculate the total number of results but only be able to fetch a fraction of them using plain pagination after which it needs to switch to cursor-based pagination. Which doesn't really make any sense when you think about it because cursors are magic database pixie-dust so there's no way to determine or calculate a corresponding cursor for a traditional page number. So in the end the API itself needs to perform an initial query just to see how many results there are and then adjust whether it is going to use plain or cursor-based pagination on the fly.

For example, let's say you wanted to use the API to fetch all the `microhoods` in sets of five. The API will respond with something like this:

```JSON
{
	"places": [ ... ],
	"next_query": "method=whosonfirst.places.search&placetype=microhood&page=2&per_page=5",
	"total": 186,
	"page": 1,
	"per_page": 5,
	"pages": 38,
	"cursor": null,
	"stat": "ok"
}
```

But if you then asked the API to fetch all of the `neighbourhoods`, again in sets of five, the API will respond with something like this:

```JSON
{
	"places": [ ... ],
	"next_query": "method=whosonfirst.places.search&placetype=neighbourhood&per_page=5&cursor={CURSOR}",
	"total": 81065,
	"page": null,
	"pages": 16213,
	"per_page": 5,
	"cursor": "{CURSOR}",
	"stat": "ok"
}
```

In both examples we know how many results there will be. In the first example we are able to use plain pagination so we know that this is page one of thirty-eight and thus the value of the `cursor` property is null. In the second example the API has returned a cursor so even though we know the total number of results and can calculate the number of "pages" we set the value of the `page` property to be null since the requirement on cursor-based pagination makes it moot.

If you look carefully at the value of the `next_query` property in both examples you can probably figure out where this is going, next.

<a name="pagination-next-query"></a>
### Next-query-based pagination

Next-query based pagination is an attempt to hide most of the implentation details from API consumers and provide a simple "here-do-this-next" style pagination interface, instead.

For example, let's say you wanted to use the API to fetch all the localities (there are over 200,000 of them) in sets of five. That will require more than 41,000 API requests but that's your business. The API will respond with a `next_query` parameter, something like this:

```JSON
{
	"places": [ ... ],
	"next_query": "method=whosonfirst.places.search&placetype=locality&per_page=5&cursor={CURSOR}",
	"total": 208214,
	"page": null,
	"pages": 41643,
	"per_page": 5,
	"cursor": "{CURSOR}",
	"stat": "ok"
}
```

There are a few things to note about the `next_query` property:

* It contains a URL-encoded query string with the parameters to pass to the API retrieve the _next_ set of results for your query.
* When it is empty (or `null`) that means there are no more results.
* It <em>does not</em> contain any user-specific access tokens or API keys &#8212; you will need to add those yourself.
* It <em>does not</em> contain any host or endpoint specific information  &#8212; you will need to add that yourself.
* You may want or need to decode the query string in order to append additional parameters (like authentication) and to handle how those parameters are sent along to the API. For example, whether the method is invoked using HTTP's `GET` or `POST` method or whether parameters should be `multipart/mime` encoded or not. And so on.

This type of pagination is not ideal but strives to be a reasonable middle-ground that is not too onerous to implement and easy to use.

<a name="pagination-headers"></a>
### Pagination and HTTP headers

Pagination properties are also returned as HTTP response headers. This is useful for any output format and necessary for output formats like plain old [CSV](#formats-csv) or Who's On First's [meta](#formats-meta) format. All of the pagination properties you've come to know and love in the examples above are also returned as HTTP response header prefixed by `X-api-pagination-`.

For example:

```bash
$> curl -s -v -X GET 'https://whosonfirst-api.mapzen.com/?method=whosonfirst.places.search&api_key=API_KEY&q=poutine&extras=geom:bbox&page=1&format=csv&per_page=1'

< HTTP/1.1 200 OK
< Access-Control-Allow-Origin: *
< Content-Type: text/csv
< Date: Tue, 28 Feb 2017 21:13:37 GMT
< Status: 200 OK
< X-api-pagination-cursor:
< X-api-pagination-next-query: method=whosonfirst.places.search&amp;q=poutine&amp;extras=geom%3Abbox&amp;per_page=1&amp;page=2&amp;format=csv
< X-api-pagination-page: 1
< X-api-pagination-pages: 13
< X-api-pagination-per-page: 1
< X-api-pagination-total: 13
< X-whosonfirst-csv-header: geom_bbox,wof_country,wof_id,wof_name,wof_parent_id,wof_placetype,wof_repo
< Content-Length: 208
< Connection: keep-alive
<
geom_bbox,wof_country,wof_id,wof_name,wof_parent_id,wof_placetype,wof_repo
"-71.9399642944,46.0665283203,-71.9399642944,46.0665283203",CA,975139507,"Poutine Restau-Bar Enr",-1,venue,whosonfirst-data-venue-ca
```

## Libraries

<div style="width:451px; margin: 0 auto;">
<a href="https://collection.cooperhewitt.org/objects/18612725/"><img width="451" height="600" src="images/kitten.jpg"></a>
</div>

As of this writing there are two general-purpose software libraries for accessing the Who's On First API, one written in [Python](https://github.com/whosonfirst/py-mapzen-whosonfirst-api) and another in [Go](https://github.com/whosonfirst/go-whosonfirst-api). We also have PHP and Javascript libraries that we use internally but they are still full of Mapzen-isms which we'd like to clean up before releasing.

The Python and Go libraries don't have feature parity and probably never will. They are each well-suited for different tasks and, as with databases, we use their respective strengths and weaknesses to test the decisions we make modeling the actual Who's On First data. We use both of these libraries on a day-to-day basis. _Most_ of the kinks should be worked out by now but the documentation could be improved in places, notably in the [Go](https://github.com/whosonfirst/go-whosonfirst-api) package which we're using [as a way to test](https://github.com/whosonfirst/go-whosonfirst-api#interfaces) how a strictly typed language can work with less formal and semi-structured API responses.

If you write your own library for the Who's On First API [we'd love to hear about it](https://twitter.com/alloftheplaces).

### py-mapzen-whosonfirst-api

The Python library is available on GitHub: [https://github.com/whosonfirst/py-mapzen-whosonfirst-api](https://github.com/whosonfirst/py-mapzen-whosonfirst-api). Here's a simple example of how you might use it:

```python
import mapzen.whosonfirst.api.client

api = mapzen.whosonfirst.api.client.Mapzen("mapzen-xxxxxx")
print api.execute_method("api.spec.formats", {})

# prints:
# {u'default_format': u'json', u'stat': u'ok', u'formats': [u'json', u'csv', u'meta']}
```

### go-whosonfirst-api

The Go library is available on GitHub: [https://github.com/whosonfirst/go-whosonfirst-api](https://github.com/whosonfirst/go-whosonfirst-api). Here's a simple example of how you might use it:

```Go
import (
	"github.com/whosonfirst/go-whosonfirst-api/client"
	"github.com/whosonfirst/go-whosonfirst-api/endpoint"
	"os"
	)

func main() {

	api_key := "mapzen-xxxxxx"

	api_endpoint, _ := endpoint.NewMapzenAPIEndpoint(api_key)
	api_client, _ := client.NewHTTPClient(api_endpoint)

	method := "whosonfirst.places.search"

	args := api_client.DefaultArgs()
	args.Set("query", "poutine")
	args.Set("placetype", "venue")

	rsp, _ := api_client.ExecuteMethod(method, args)
	os.Stdout.Write(rsp.Raw())

	# prints (truncated for brevity)
	# {"places":[{"wof:id":152777717,"wof:parent_id":"85874363","wof:name":"Poutine LA Fleur","wof:placetype":"venue","wof:country":"CA","wof:repo":"whosonfirst-data-venue-ca"} ... ],"next_query":null,"total":13,"page":1,"per_page":100,"pages":1,"cursor":null,"stat":"ok"}
}
```

There is also a command line tool called `wof-api` for performing simple and batch operations with the API. For example, using the tool it's possible to [fetch all 63,387 venues in San Francisco](https://github.com/whosonfirst/go-whosonfirst-api#example) as a single GeoJSON FeatureCollection. There are lots of ways to do this but the nice thing about the `wof-api` tool is that depending on your network connection this can be accomplished in as little as 5 minutes.

![](images/sf-venues.png)

All those dots in the image above were produced by typing `wof-api -param method=whosonfirst.places.search -param locality_id=85922583 -param api_key=mapzen-xxxxxx -param per_page=500 -param placetype=venue -paginated -geojson -output venues.geojson -timings -async`

Note the use of the `-paginated` flag which will instruct the tool to handle all the pagination nonsense described above for you. It's kind of like having your very own [Bundler](https://mapzen.com/blog/bundler/) on the [command line](https://en.wikipedia.org/wiki/In_the_Beginning..._Was_the_Command_Line).

## Inspirational conclusion

<a href="https://collection.cooperhewitt.org/objects/18402495/"><img width="589" height="400" src="images/shadow.jpg"></a>

We hope you make awesome things with the API. Enjoy!

---

Image credits:

* [Model Of A Walled Entrance With Gate (Italy), ca. 1710; carved and painted pine, wrought iron gate and window grill; Gift of Mrs. James O. Green and Eleanor and Sarah Hewitt; 1921-17-16-a/d ](https://collection.cooperhewitt.org/objects/18214745/)
* [Label (USA), 1980–85; jacquard woven; 1985-39-60](https://collection.cooperhewitt.org/objects/18805295/)
* [Sheet Music, The Kitten with the Big Green Eyes; 1949-106-3](https://collection.cooperhewitt.org/objects/18612725/)
* [Panel (England), mid-19th century; cotton; Gift of Ruth Van Norman; 1955-119-1](https://collection.cooperhewitt.org/objects/18402495/)
