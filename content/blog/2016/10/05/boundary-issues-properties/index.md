---
layout: page
title: "Boundary Issues: Editing Properties in Who's On First Records"
category: blog
excerpt: Introducing our bespoke web-based editor for Who's On First records—helping GeoJSON help you.
authors: [dphiffer]
image: "https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/grouped-properties.gif"
tag: [whosonfirst, boundaryissues, data]
---



[Who’s On First records](https://whosonfirst.mapzen.com/), encoded as GeoJSON flat files, have always supported a failure scenario where you can open them up in Microsoft Word, or TextEdit, or *your favorite text editor here* and save the changes. Or, if you’re feeling *even lazier*, you could [go to GitHub](https://github.com/whosonfirst-data/whosonfirst-data) and click on the little pencil icon to modify a record in your browser.

![Edit in GitHub](https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/edit-button.gif)

As it turns out, these methods can be cumbersome, so we’ve been developing an internal-facing (for now) web-based editor for Who's On First records called [Boundary Issues](https://github.com/whosonfirst/whosonfirst-www-boundaryissues/) (shout out to former Mapzen-er [Ingrid Burrington](https://twitter.com/lifewinning) for the name—also, hey, go [buy her book](http://www.mhpbooks.com/books/networks-of-new-york/)). And to be clear, yes, this is a public blog post about a not-yet-public editing tool. It is still just a little too early to open access up to everyone, but we will get there.

Boundary Issues does not yet edit polygon boundaries in the way that [OpenStreetMap's iD editor](http://www.openstreetmap.org/edit?editor=id) does. It will do that someday, but right now it’s primarily for editing GeoJSON _properties_. Here is an excerpt of the [GeoJSON document](https://whosonfirst.mapzen.com/data/100/818/405/1/1008184051.geojson) for the [Poop Emoji Rock](https://bernalwood.com/2016/08/29/bernal-rock-transformed-into-beloved-poop-emoji/):

	{
		"type": "Feature",
		"geometry": {
			"coordinates": [
				-122.411529,
				37.743715
			],
			"type": "Point"
		},
		"properties": {
			"geom:latitude": 37.743715,
			"geom:longitude": -122.411529,
			"wof:id": 1008184051,
			"wof:name": "Poop Emoji Rock",
			"wof:parent_id": 420780697,
			"wof:placetype": "venue"
		}
	}

If you’re unfamiliar with the Poop Emoji Rock, it is a frequently painted rock that was recently made to look like Unicode character U+1F4A9 “PILE OF POO” (also known as 💩). As you might expect, it [has a Who's On First record](https://twitter.com/alloftheplaces/status/770793279969374208).

![Poop Emoji Rock](https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/poop-emoji-rock.jpg)

<p class="caption">Image courtesy of <a href="https://bernalwood.com/2016/08/29/bernal-rock-transformed-into-beloved-poop-emoji/">Telstar Logistics</a>.</p>

GeoJSON is a specific kind of JSON (a file format for structuring data), which [specifies](https://tools.ietf.org/html/rfc7946) that we can expect a handful of predictable top-level properties. GeoJSON makes it easy for a computer to keep descriptions about *where a place is* (the `geometry`) separate from descriptions about the *qualities of the place* (the `properties`).

The very first feature of Boundary Issues was for choosing a place’s geometry: _click on the map to set the position._ (Thanks to [Leaflet.draw](https://github.com/Leaflet/Leaflet.draw) for the add-a-pin UI.)

![Dropping a pin on the map](https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/drop-pin.gif)

As for what goes in the GeoJSON `properties` list, it is very open-ended. [Who’s On First](https://mapzen.com/blog/who-s-on-first/) provides some conventions about [what and how to encode things in the GeoJSON properties](https://github.com/whosonfirst/whosonfirst-properties). This is meant to maximize the compatibility of GeoJSON records between a broad variety of applications.

For example, here is how you might add tags to a record using Boundary Issues.

![Adding properties](https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/add-properties.gif)

Notice that we’re using property _namespaces_. Instead of specifying a `tags` property, we use `wof:tags`, meaning it’s a part of the [Who’s On First namespace](https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/wof.md). This lets us keep things that are common to _all WOF records_ like `wof:name` separate from from Mapzen _opinionated things_ like `mz:categories`. This namespacing is in the same [spirit](https://en.wikipedia.org/wiki/Triplestore) as the [Semantic Web](https://en.wikipedia.org/wiki/Semantic_Web), but without the verbosity of [RDF](https://en.wikipedia.org/wiki/Resource_Description_Framework#Examples).

The namespaces also offer a natural way to group related properties in the user interface.

![Grouped properties](https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/grouped-properties.gif)

Unlike the more freestyle approach of [geojson.io](http://geojson.io/),  Boundary Issues has built-in scaffolding that guides how properties get encoded. The user interface is saying “here are some of the things you can type in.” For example, what are the [names](https://github.com/whosonfirst/whosonfirst-names) people are known to call this place? Are there [concordances to records in other databases](https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/wof.md#concordances) we can hold hands with?

Boundary Issues also keeps a short list of _minimal viable properties_ that are required to make a Who’s On First record. When creating a [venue placetype](https://github.com/whosonfirst/whosonfirst-placetypes/blob/master/placetypes/venue.json) you can pretty much drop a pin on the map, type in a `wof:name` value, and you’ve got yourself a WOF record. All the other properties are optional, and will be assigned reasonable default values.

We turned to [JSON Schema](http://json-schema.org/), _yet another flavor of JSON_, to define how different properties get encoded. JSON Schema was originally created as a way of declaring guidelines that say _this is VALID_ or _this is INVALID_. Using it for that purpose does have [some complications](https://www.tbray.org/ongoing/When/201x/2016/04/30/JSON-Schema-funnies), but the specification files themselves can be read by a variety of programming languages. It lets us build a basic scaffolding for records that isn’t tied into any one particular application.

We can use the schema to construct a brand new empty record, and to nudge each of its properties into their intended data types (strings, numbers, lists, etc.), and provide a default value when we need one. Perhaps we will use our JSON Schema for validating records some day.

Here's an excerpt from [our schema](https://github.com/whosonfirst/whosonfirst-json-schema/blob/master/schema/whosonfirst.schema) (derived from [this sample GeoJSON schema](https://github.com/fge/sample-json-schemas/blob/master/geojson/geojson.json)):

	{
		"properties": {
			"wof:id": {
				"type": "integer"
			},
			"wof:parent_id": {
				"type": "integer",
				"default": -1
			},
			"wof:name": {
				"type": "string"
			}
		}
	}

The way the property-editing interface _behaves_ requires an additional set of [guidelines](https://github.com/whosonfirst/whosonfirst-www-boundaryissues/blob/master/www/include/lib_wof_render.php#L44-L133). These rules _are_ baked into the source code (since they’re specific to Boundary Issues), and they let us specify things on a per-property basis like:

- Is the property _editable_? If not, the property should be set by software automatically.
- Is the property _deletable_? Which is really just another way of saying “this property is required, _it must have a value of some sort_.”
- Is the property _visible_? Almost all properties are visible in the list, but sometimes it’s helpful to hide them from the editing interface.
- Is the property on the short list of _minimum viable properties_?

Collectively these data types, default values, and editing behaviors get baked into an HTML `<form>` element, with various clues for the JavaScript code about how it should treat each property.

	<div class="json-schema-field json-schema-required">
		<input type="text" name="properties.wof:parent_id" value="-1"
		       disabled="disabled" data-type="integer">
	</div>

![Minimum Viable Properties / Add a new property](https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/minimum-viable.png)

In the case of `wof:parent_id`, you might wonder how it can be both _required_ and also _disabled_? With these constraints, how could the value ever change from the default value? The answer is in our growing assortment of bespoke editing interfaces, discussed below.


In the case of `wof:parent_id` and `wof:hierarchy`, these values are chosen automatically thanks to our internal [point in polygon service](https://github.com/whosonfirst/go-whosonfirst-pip). After dropping a pin on the map, the code consults with the point in polygon service, then suggests a potential hierarchy (or _hierarchies_, [there can be more than one](https://github.com/whosonfirst/whosonfirst-placetypes#hierarchies)).

![Hierarchy](https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/hierarchy.png)

The hierarchy interface doesn’t actually offer any new user-facing controls, instead it just kind of [_does stuff_](http://lifewinning.com/tag/magic/), encoding properties behind the scenes based on the chosen latitude and longitude coordinates. There are some additional bespoke property interfaces within the UI that make it easier to express things that don’t sit neatly inside of text input boxes. Recent additions include a multi-language name editor, an address parsing widget, a way of encoding a venue’s open and closing hours, and a way of encoding venue categories. We hope some of these UI widgets—such as the address parsing one—will eventually get extracted out into a generalized JavaScript library for use outside of Boundary Issues.

<div class="row">
	<div class="col-sm-6"><img src="https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/libpostal_bi_address.gif" alt="Address"></div>
	<div class="col-sm-6"><img src="https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/names.gif" alt="Names"></div>
</div>
<div class="row">
	<div class="col-sm-6"><img src="https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/category.gif" alt="Categories"></div>
	<div class="col-sm-6"><img src="https://mapzen-assets.s3.amazonaws.com/images/boundary-issues-properties/hours.gif" alt="Hours"></div>
</div>

Boundary Issues is still very much a wet-paint prototype, but it’s making steady progress. There is a growing backlog of [issues](https://github.com/whosonfirst/whosonfirst-www-boundaryissues/issues) to work through, and plenty of Who’s On First records that need some TLC. We'll get there, and once the editor is a little more mature we'll be sure to invite you to give it a try!
