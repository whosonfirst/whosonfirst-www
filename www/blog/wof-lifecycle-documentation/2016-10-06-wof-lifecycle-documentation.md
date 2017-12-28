---
layout: page
title: Who's On First Life Cycle Documentation
category: blog
excerpt: Documenting the life cycle and tracking rules of the Who's On First ID
authors: [stepps00]
image: https://mapzen-assets.s3.amazonaws.com/images/wof-lifecycle-document/new_growth.jpg
tag: [WOF, ID, whosonfirst, data, Who's On First, lifecycle]
---

![WOF is growing, up](https://mapzen-assets.s3.amazonaws.com/images/wof-lifecycle-document/new_growth.jpg)

[Who's On First](https://whosonfirst.mapzen.com) is Mapzen's gazatteer of places. Within Who's On First, each place is represented as a record with a unique and stable identifier that we call the **wof:id**. Because our gazetteer tracks changes to places over time we create new records when places experience significant events (and point the old record forward to the new record's **wof:id**).

The Who's On First **wof:id** comes with various levels of complexity and convention; the guidelines around the **wof:id** can be found in our new [Who's On First ID Life Cycle Documentation](https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/wof:id_lifecycle.md).

### So, why is documenting these rules is so important?

It is important to document the rules around **wof:id** because sometimes a place experiences a change so significant that it warrants "snapshotting" it in the past preserving its original **wof:id** so that it (the place) can move forward with a new **wof:id**.

For example: St. Petersburg, Russia became Leningrad for a while, then changed back to St. Petersburg. These are all the same "place", but should have different Who's On First records, each with a unique and stable **wof:id** to represent each snapshot in time.

The rules in Who's On First may differ from the assumptions that a user or application has; documentation allows downstream data consumers and mapping services to optimize data usage and understand the assumptions in the data structure.

The folks over at the [UK's Local Ordnance Survey](https://www.ordnancesurvey.co.uk/) wrote [a life cycle document](https://www.europa.uk.com/resources/os/os-mastermap-topography-layer-user-guide.pdf) to detail a set of tracking rules around the features in their OS MasterMap database. The Local Ordnance Survey's User Guide was used as an outline for our own document due to it's complexity and detail. They did a great job at explaining the possible workflows around their feature IDs - a big thanks!

The following snippet from the Local Ordnance Survey document summarizes their reasonings well:

>_"The features within OS MasterMap vector layers are viewed as having a life cycle. The life cycle of each feature is matched, where practically possible, to that of the real-world object it represents. For example, a new building will become a new object in the Ordnance Survey main holding of the data and will be treated as the same feature – even if it undergoes change – until the building is demolished. By adopting this approach, Ordnance Survey is emulating real-world behaviour within a digital model and therefore creating a more realistic version of the real world in a computer."_

>...

>_"Essentially, these rules indicate when an OS MasterMap feature will be retained and when it will be replaced, for different types of feature and different change scenarios. These rules are not only there to guide surveyors (from Ordnance Survey) collecting and attributing the features, but also to provide customers with a consistent definition of how real-world change is handled by Ordnance Survey."_

### The Flowchart

And now, [our handy flowchart](https://raw.githubusercontent.com/whosonfirst/whosonfirst-cookbook/master/_images/lifecycle_flowchart.png) to help you visualize feature **wof:id** life cycle workflows in Who's On First:

<div class="demo-wrapper" id="lifecycle" style="height: 620px;">
<iframe src="https://whosonfirst.github.io/whosonfirst-cookbook/wof-lifecycle-document/index.html"></iframe>
</div>

#### The short version

* **Create**: This workflow should be followed for any **new** features that are being imported to Who's On First that the database does not already contain.

* **Alter**: Altered feature workflows occur to features that are **already** in Who's On First.

* **End of Life**: Used for features that are no longer current (think closed businesses or dissolved administrative districts).

* **Renew**: A workflow outcome that requires the existing feature to be "replaced" with a new feature. This requires some superseding work for the **wof:id**, see [our life cycle document](https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/wof:id_lifecycle.md) for more detail.

### Sounds great, but how does this work in practice?

In a [previous blog post](https://mapzen.com/blog/sf-neighbourhood-updates/), we wrote about updating neighbourhood records in Who's On First. That neighbourhood work relied heavily on these life cycle rules because we not only created new neighbourhood records, but we also altered existing records and ended the life of several other records.

We liked what the UK's Ordnance Survey did, but we also recognize that Who's On First is a separate project with differing rules and guidelines. We thought about these rules and expirimented; the neighbourhood work in San Francisco was the genesis of these life cycle rules. We've also begun updating neighbourhood records in other cities (New York, Los Angeles, Chicago, etc.), which rely on these same rules.

Let's take a look at use cases of the life cycle document through the eyes of the **Sunset District**; a neighbourhood in San Francisco that should _actually_ be a macrohood.

Since Who's On First had a record for the Sunset District, this workflow will be an **alteration** to an existing place record. Let's walk through the workflow taken for the Sunset District:

> _Are we changing the feature's properties or geometry?_

The feature's properties.

> _Was a change made to the wof:parent, wof:placetype, or wof:name fields?_

Yes.

> _Was a change made to the wof:placetype?_

Yes.

After following those steps in the flowchart, the outcome to the Sunset District record was to **renew**.

And there you have it. Since a change was made to the `wof:placetype` property of the existing Sunset District record, the record and its descendants had to be superseded into new records.

#### What about the Sunset District's descendant records?

The `wof:hierarchy` of the **Sunset Reservoir**, a venue that was parented by the existing Sunset District neighbourhood record, is shown below:

Before updating the Sunset District's record:

```
    "wof:hierarchy":[
        {
            "continent_id":102191575,
            "country_id":85633793,
            "region_id":85688637,
            "county_id":102087579,
            "locality_id":85922583,
            "neighbourhood_id":85887463,
            "venue_id":588405947
        }
```
After updating the Sunset District's record:

```
    "wof:hierarchy":[
        {
            "continent_id":102191575,
            "country_id":85633793,
            "region_id":85688637,	    
            "county_id":102087579,
            "locality_id":85922583,
            "macrohood_id":907212605,
            "neighbourhood_id":85865975,
            "venue_id":588405947
        }
```

Note the addition of a `marcohood_id` property and the change in the `neighbourhood_id` property value.

### Internal debates and churn

It is important to note that the life cycle document, as written today, is a working document. We expect churn in the Who's On First database, which means we will not be able to capture every possible scenario or rule at the moment, but we are working towards being able to do just that.

While we do expect churn in the early days of Who's On First as we clean things up, we also expect things to stabilize going forward; this is just that nature of our work. We just need to remember that life is complicated and Who's On First mirrors those complexities.

Thanks for reading; please check out the full wof:id life cycle document [here](https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/wof:id_lifecycle.md).


_If you or your application relies on Who's On First features, please give our document a read and [let us know what you think](mailto:stephen.epps@mapzen.com)!_

**_[Image via Dennis Yang, CC-BY 2.0](https://flic.kr/p/4NLV2d)_**
