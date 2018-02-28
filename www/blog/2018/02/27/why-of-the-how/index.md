---
layout: page
title: The Why of the How
published: true
date: 2018-02-27
permalink: /blog/2018/02/27/why-of-the-how/
category: blog
excerpt: One of the things I've taken to saying in recent years is that: Sometimes we make mistakes because of circumstance and sometimes we make bad decisions because of reasons... so please just write those reasons down somewhere.
authors: [thisisaaronland]
image: "images/mushrooms-bowl.jpg"
tag: [elasticsearch,go,python,spelunker,whosonfirst,why-of-the-how]
---

![](images/mushrooms-risotto.jpg)

_This is a bit of an accidental blog post._

_I mentioned [Gary Gale](https://vicchi.org/) briefly in [the last blog
post](/blog/2018/02/20/wof-in-a-box-part3/). Gary and I go back to Flickr /
Y!Geo / GeoPlanet (née Where On Earth) days and lately he's been spending some
time poking at all the tools and data that make up Who's On First._

_What I love about Gary is that he has the diligence and the
patience to find all the outstanding questions and gotchas in a project. Gary
has been setting up a local instance of the [Spelunker](https://spelunker.whosonfirst.org/) and he sent me a long list
of questions about how the Spelunker does and doesn't work with newer versions
of [Elasticsearch](https://www.elastic.co/products/elasticsearch). The gist of his email being:_

> The WOF Spelunker is currently based on ES 2.4.6 and there’s been a *lot* of changes that I’ve had to accommodate 

> I still can’t get the punctuation filter working properly. Creating a new index with this in the schema dies with this ...

> One thing that’s caused significant headaches is that there’s a lot of type inconsistencies in the WOF GeoJSON, with fields that /should/ be numeric being specified as strings. As I’m bulk indexing, 1000 at a tome, there’s no guaranteed order (or shard guarantee) for the documents to be processed in so I was getting a lot of mapping mismatches.

> For now I’ve fixed this by coercing the problematic fields into their integer values so the mappings are dynamically created consistently. Specifically this bites when processing the properties.wk:count, properties.qs:id and properties.wof:concordances.qs:id fields. Also oddly, properties.qs:id always seems to be zero whereas properties.wof:concordances.qs:id isn’t?

> I did check in https://github.com/whosonfirst/whosonfirst-json-schema but it looks like these documents only cover the minimum viable WOF schema and not all the fields available. Either that or it’s just out of date.

_I have included an abbreviated version of my reply below because aside from
answering some of Gary's immediate questions it ended up touching on a lot of
other interelated decisions and trade-offs in both the design and the implementation of Who's On First that probably haven't been discussed
or documented as well as they should be._

_One of the things I've taken to saying in recent years is that: "Sometimes we
make mistakes because of circumstance and sometimes we make bad decisions
because of reasons... so please just write those reasons down somewhere."_

_I'd like to believe we've done a pretty good job of that in the Who's On First
codebase itself but in as much as a large number of people are never going to
read those comments it seems like it a useful practice to do pursue, here on the
blog, as well. If other people have similar questions [we'd be happy to answer them](https://www.twitter.com/alloftheplaces/) and
maybe we will start a general "why of the how" series of posts._

_In the meantime, here's what I said to Gary:_

---

Did I mention I have _#feelings_ about Elasticsearch (ES) ?

Everything you've just described is one
reason we're still using 2.4. It was enough of a time-sink just migrating from
1.x to 2.x that there's never been a compelling reason to upgrade again beyond
"3 (or 5 in the case of Elasticsearch, which skipped versions 3 and 4) is bigger than 2".

Worse, I began to have little confidence that updating from version `x` to
version `y` wasn't just going to be time wasted because I soon as I was done I would
have to upgrade to version `z`.

I realize this is pretty much the defining characteristic of "modern software development" but that doesn't make it right. 

![](images/mushrooms-bowl.jpg)

I suppose if Elastic are already talking about "version 8" [it might be worth the
effort](https://readwrite.com/2011/02/10/pinboard-creator-maciej-ceglow/) but it's hard not to feel grumpy about it all. Anyway, all the ES stuff is kept here:

* https://github.com/whosonfirst/es-whosonfirst-schema

The first thing I would suggest are branches and PRs. Even just creating a
milestone and outlining all the migration issues would be useful. All of the code to index ES is kept here: 

* https://github.com/whosonfirst/py-mapzen-whosonfirst-search/blob/master/mapzen/whosonfirst/search/__init__.py

And here, which is just a thin non-WOF/Spelunker-specific base class which wraps
the handful of HTTP requests we make to ES, because every ES wrapper library out
there tries to do all the things and quickly becomes more trouble than it's worth:

* https://github.com/whosonfirst/py-mapzen-whosonfirst-elasticsearch/blob/master/mapzen/whosonfirst/elasticsearch/__init__.py

In the beginning we relied on the supposed "schemaless magic" of ES to index
heterogeneous documents but very quickly bumped in to the thing where ES tries to
be clever and then shoots itself in the face when it comes to strings versus ints and of course [EDTF date
strings](/blog/2017/06/29/tackling-space-and-time-in-whosonfirst/). Because there was never time to go on a prolonged ES vision quest I
just handled it all in code.

* https://github.com/whosonfirst/py-mapzen-whosonfirst-search/blob/master/mapzen/whosonfirst/search/__init__.py#L62-L480
* https://github.com/whosonfirst/py-mapzen-whosonfirst-search/blob/master/scripts/wof-es-prepare

Eventually we made some of that code redundant with better schema definitions:

* https://github.com/whosonfirst/es-whosonfirst-schema/blob/master/schema/2.4/mappings.spelunker.json

The fact that all the indexing code is [in Python](https://github.com/whosonfirst?language=python) is largely an historical
artifact of having started in Python (the correct choice). I do not love having
to "prepare" documents and in some ideal world we could just throw the
properties dictionary at an ES index and get on with more exciting things.

![](images/mushrooms-wh.jpg)

I would also like to be able to [use Go](https://github.com/whosonfirst?language=go) to index ES because it is simply faster
and we could distribute pre-compiled binary tools, because Python's dependency
hoohah is reliably sad-making. The combination of _constructing_ free-form JSON
documents in Go, in writing all the scaffolding code to deal with ES
requests/responses in Go and just limited time means it hasn't happened yet.

This is what I meant when I said we use Go as much to test decisions/assumptions
around the code, with a strictly typed language, as we do for its speed and
muscle.

**I see this inability to write a WOF -> ES thingy in Go, quickly and with
only a manageable amount of burden, as a short-coming and something to be
addressed going forward. We have [a couple other places](https://github.com/whosonfirst/py-mapzen-whosonfirst-export) where we've painted
ourselves in to a language corner (Python) and it's useful only in that it
illustrates how _not_ to do things in the future.**

WOF can't support all the
languages itself but it definitely shouldn't make [ insert language here ] a
requirement for common things... like indexing a database. Today it does.

The [JSON Schema stuff](https://github.com/whosonfirst/whosonfirst-json-schema) was an early attempt to see if we could enforce a certain
amount of consistency and quality control around document types without making
[the mistakes that XHTML 2.0 made](https://www.wired.com/2009/07/the_w3c_buries_xhtml_2dot0_html_5_is_the_future_of_the_web/) around strict-iness (who remembers XHTML 2.0
right...?) It was also an attempt to see if it could be used to automate some
parts of [Boundary Issues](http://localhost:8080/blog/2016/10/05/boundary-issues-properties/) (the editorial tools) which are written in
[PHP/Flamework](https://github.com/whosonfirst?language=php) and [Javascript](https://github.com/whosonfirst?language=javascript) without going [Full Metal XForms](https://en.wikipedia.org/wiki/XForms) (no offense to [Micah](http://dubinko.info/blog/tags/standards/xforms/)) about
everything.

There's [a whole other discussion](http://localhost:8080/blog/2017/05/10/simple-is-hard/) about how Boundary Issues has to wrangle and round-trip
documents and forms and UI/UX behaviour based on property types and ACLs but
that's a conversation for another day.

![](images/mushrooms-caps.jpg)

I think, as I write this now, that I had faint hopes of being able to generate
the ES schemas from the JSON schemas, or at least use the latter as a starter
kit for the former. In the end [the JSON Schema stuff never warranted the time](https://www.tbray.org/ongoing/When/201x/2016/04/30/JSON-Schema-funnies) to
prove or disprove or, more specifically, _it was going to take too long prove or
disprove itself either way_ and we didn't have the luxury of finding out.

I am totally open to the idea that we might be able to revisit JSON Schema with
more success now but it does point out one of the built-in tensions around a
dataset like WOF: Namely that outside of a handful of [core/common/required
properties](https://github.com/whosonfirst/whosonfirst-properties) which should enforce strict-iness in any dataset as large as ours
there _will_ be type inconsistencies. It's not ideal but it is also entirely
realistic to expect and it's not clear to me that a random `qs:whatever`
property should cause a fatal error that prevents the casual user from getting
started.

A good example of this is [the nightmare around LFS and large geometries](https://github.com/whosonfirst-data/whosonfirst-data#git-and-large-files) (hello,
New Zealand) which is why we're talking about making the default/common
geometries in records a max of 2-10 MB and moving all the "ground truth"
geometries in to dedicated "you will need to use LFS" repos.

It's also the motivating factor behind the "standard places response" (modeled after Flickr's [standard photo response](https://code.flickr.net/2008/08/19/standard-photos-response-apis-for-civilized-age/)) to try and
identify _what_ the strictly enforced properties in a record are and, by
extension, what we and consumers should "be liberal" about:

* https://github.com/whosonfirst/go-whosonfirst-spr#interface

_See the way the definition for the `Id()` method returns a string instead of an integer? Yeah... something something something other data sources something something something..._

![](images/mushrooms-peas.jpg)

To answer your immediate question of _"Is this stuff all documented somewhere?"_ the answer is yes, here:

* https://github.com/whosonfirst/whosonfirst-properties/tree/master/properties

Some of those records are incomplete but there should at least be [a placeholder](https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties_template.json)
for all the properties. Ultimately I would like for all those machine readable
documents to be used to generate human-readable documentation and code-level
sanity checking (like we already do for placetypes and sources) but that is not
the case today:

* https://github.com/whosonfirst/whosonfirst-sources/tree/master/bin
* https://github.com/whosonfirst/py-mapzen-whosonfirst-sources/blob/master/utils/mk-spec.py
* https://github.com/whosonfirst/go-whosonfirst-sources/blob/master/sources/spec.go
* https://github.com/whosonfirst/whosonfirst-www-api/blob/master/www/include/lib_whosonfirst_placetypes_spec.php

On top of all this, I am just going to assume that all the query syntax for ES
6-8 has changed as well? Which means both the Spelunker and the API will need to updated.

* https://github.com/whosonfirst/whosonfirst-www-spelunker/blob/master/www/server.py
* https://github.com/whosonfirst/whosonfirst-www-api/blob/master/www/include/lib_whosonfirst_places.php

In case you're wondering I do periodically question whether or not we should just define all
our ES queries as language-agnostic templates but after a few moments of hating
myself move on to other things.

So. That's maybe more than you were hoping for, by way of answers, but welcome to my
world.

It seems like it's time to spend some energy on ES 7. Presumably there is no
point in stopping at 6 if 8 is already being discussed? I would start by making
a new branch and version-specific folders in:

* https://github.com/whosonfirst/es-whosonfirst-schema/tree/master/schema

And then updating the Python libraries accordingly. There is nothing precious in
them so most things are fair game, short of embarking on a wholesale Python 2 ->
3 rewrite (which is in the cards, but not right now...) Removing as much of the
type-checking hoohah from the Python code and in to the schema would be a good
thing but I have a feeling expediency will dictate keeping some of the former. 

**The subtext here is that I too would like to have a dataset where we can enforce
type-ish consistency across the board and where the penalty for stopping and
fixing one bad record isn't the potential of having to repeat the process ad infinitum. Our
burden, I think, will be to live in the interim working towards that better
world...**

The first step should just be "indexing the data" and adjusting the schemas and
"prepare" code as the circumstances demand. After that we can sort out / update
all the query nonsense. If we need to sacrifice [the emoji support](https://github.com/whosonfirst/es-whosonfirst-schema/tree/master/synonyms#emoji-synonyms) in the
short-term then that's probably the right thing, although it is pretty cool to
be able to do this:

* [https://spelunker.whosonfirst.org/search/?alt=💩](https://spelunker.whosonfirst.org/search/?alt=💩)

Good times...

---

_One immediate side-effect of the email thread with Gary is that there are now
[tools to crawl all the Who's On First records](https://github.com/whosonfirst/go-whosonfirst-properties#tools) and ensure that each of their
properties has a corresponding record in the
[whosonfirst-properties](https://github.com/whosonfirst/whosonfirst-properties)
repo and Gary is writing [code to test those files](https://github.com/vicchi/php-whosonfirst-properties)._

![](images/mushrooms-egg.jpg)

_Each of those records still needs to have descriptive metadata added and
some of the records will be bunk and in need of being superseded or deprecated
but at least its progress._

_Tiny steps may be tiny but they are still forward momentum so "Onwards!" and
all that good stuff..._
