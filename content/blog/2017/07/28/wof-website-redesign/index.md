---
layout: page
title: Redesigning and Rebuilding the Who's On First website
category: blog
excerpt: How can we most effectively allow for understanding, visualizing, and interacting with Who's On First?
authors: [sdombkow]
image: https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction33.png
tag: [whosonfirst,data,design,interns]
---

My name is [Scott](http://scottdombkowski.com/ "Scott's Portfolio") and I am an intern on the Mapzen data team this summer. I am also pursuing a graduate degree at the [Carnegie Mellon School of Design](http://design.cmu.edu/ "Carnegie Mellon School of Design").

At Mapzen, I am tasked with [improving how Who’s On First (WOF) is presented to the world and increasing its accessibility to a wider range of users](https://whosonfirst.mapzen.com/interns/#2017-ux "WOF Internship Call").

For the majority of my first three weeks at Mapzen, I have focused on the redesign and the rebuilding of the [WOF website](https://whosonfirst.mapzen.com/ "WOF Website"). (For those who aren’t familiar with the current website, here's a
[full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstCurrentState.png "Mockup of Current Website"))

The website currently contains:

* [an introduction/explanation of Who’s On First](https://whosonfirst.mapzen.com "WOF Documentation") (What is WOF?, What state WOF is in?)
* [a section with links to WOF documentation](https://whosonfirst.dev.mapzen.com/#documentation "WOF Documentation")
* [a section with links to WOF tools](https://whosonfirst.mapzen.com/#examples "WOF Tools") (ex: WOF spelunker (a tool to browse WOF data))
* [a section with links to the thinking surrounding the project](https://whosonfirst.mapzen.com/#theory "WOF Theory") (What is the purpose of WOF?, How are WOF places organized?)
* [a section with links to access WOF data and explanations on how the data is organized](https://whosonfirst.mapzen.com/#data "WOF Data") (Where does the data live?, Why is the data organized that way?)
* [a section with links to WOF sources](https://whosonfirst.mapzen.com/#sources "WOF Sources") (human-friendly and JSON formats)
* [a section dedicated to licensing and how to credit WOF and other projects properly](https://whosonfirst.mapzen.com/#license "WOF License")

##Goals

After gaining a better understanding of the website and the project itself, I developed four goals to help guide the redesign:

* Provide an overview of the project showing the entirety of the thought put into the project, while not being so overwhelming as to scare potential users off.
* Provide the tools to immediately utilize WOF.
* Provide the tools for deeper exploration into WOF.
* Get individuals excited about the project.

##Users

I also began to think about the users of the website. Are they all similar? Are they coming to the project for different reasons? What kind of backgrounds and experiences do they bring with them?

I concluded that the majority of these users will come from three different groups.

1. _Users actively working on a project that could benefit from WOF._ They are not stumbling upon the project, they have come to the website with a specific purpose. They have either used WOF before or have background knowledge about WOF. They have some technical knowledge.
2. _Users not actively working on a project that could benefit from using WOF._ These users are interested in WOF, but don’t have an immediate need for it. They are interested in learning about the project, but are not looking for in-depth knowledge. They may or may not have technical knowledge.
3. _Users who stumble upon WOF._ They come to the project without preconceptions. They may never have a use for WOF, but may spend some time on the page if they find it interesting.

##Ideation

With established goals and thoughts concerning website users, new questions began popping up.

* How can we most effectively allow for understanding of WOF?
* What are the most effective ways of visualizing WOF?
* Can understanding of WOF be acquired through some sort of interaction?
* How can users directly interact with the data?
* How can we replicate a user’s interaction with WOF outside the website within the website?
* Can we utilize the website’s content to create a dialog that gets the attention of a user while also showing the depth of the project?
* How can we visualize that this project is a continuous work in progress?

With these questions and others in mind, I searched for answers moving from lower fidelity to higher fidelity prototypes.

*Note: Throughout the design process, I have been using the [Mapzen Styleguide](https://mapzen.com/common/styleguide/ "Mapzen Styleguide") so that anything I was designing or building would align with the Mapzen visual style and other Mapzen product pages.*

##Prototyping

One of the first things I focused on was how users directly interact with WOF data. Do we create some sort of interactive component where individuals can immediately interact and get a sense of the data made available by WOF? If so, what powers that component? One feature that WOF provides is an [API](https://mapzen.com/documentation/wof/ "WOF API"). We talked about this [a few months back](https://mapzen.com/blog/whosonfirst-api/):

>The API provides programmatic access for you and your robots to all the Who’s On First data. You can query individual places and their relations, look for concordances and perform basic spatial queries. You can also use the API to query things like all the different placetypes or sources for data.

While some of the [API queries](https://mapzen.com/documentation/wof/methods/ "WOF API Queries") require background knowledge, a number of them could be understood by a first-time user, like [getByLatLon](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getByLatLon "WOF getByLatLong Query").

Knowing that I could use the [API](https://mapzen.com/documentation/wof/ "WOF API"), I explored different ways the [API methods](https://mapzen.com/documentation/wof/methods/ "WOF API Queries") could be visualized.

Could we create a card with tabs that would display specific fields based on the tab selected?

![Card with Tab Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock7Small.png "Card with Tab Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock7Small.png "Card with Tab Mockup")

Results would appear below the tabs and fields.

![Card with Tab Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock2Small.png "Card with Tab Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock2Small.png "Card with Tab Mockup")

Or we could create a map that would allow for interaction? A user could select a specific point or draw a box on the map and results based on that point or rectangle would appear.

![Map Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock10Small.png "Map Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock10Small.png "Map Mockup")

I had some concerns with this approach. Would the interaction interfere with the main navigation of the page? Should the first thing be an element relying on user interaction? I ultimately came to the conclusion that this first element should not rely on a user’s interaction.

###Initial Component

Since I didn’t want the first element to rely on a user interacting with it, I created further iterations.

I knew that I wanted the element to immediately capture the user’s attention and show some of the capabilities of WOF. With that in mind, I created the mockup below where users are able to see WOF places depicted by red circles.

![Initial Component without API Command](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock14Small.png "Initial Component Without API Command")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock14Small.png "Initial Component Without API Command")

I showed it to my team and they suggested including the API command powering the visualization.

![Initial Component with API Command](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock19Small.png "Initial Component with API Command")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock19Small.png "Initial Component with API Command")

When initially building this out, I'd planned to detect a user’s location and run a WOF API query based on that location. However, this can lead to [potential problems with GeoIP lookups](https://mapzen.com/blog/missing-the-point/ "Missing the Point Blog Post"). The mockup is now built to randomly select one of five locations and run a WOF API query based on that location.

###Interactive Component

After building out the initial component, I still wanted to create an element that would allow for a deeper and more direct interaction with WOF. Consulting with my team about [the most important API queries](https://mapzen.com/documentation/wof/methods/#whosonfirstplaces "WOF API Queries"), we settled on:

* [**getByLatLon**](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getByLatLon "WOF getByLatLong Query"): returns WOF places intersecting a latitude and longitude
* [**getNearby**](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getNearby "WOF getNearby Query"): returns all the WOF records near a point
* [**getIntersects**](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getIntersects "WOF getIntersects Query"): returns all the WOF places intersecting a bounding box

Using my earlier mockups as inspiration, I thought about ways a user could run these queries through an interface. This inspired another set of mockups.

![Early Concept Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock19Small2.png "Early Concept Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock19Small2.png "Early Concept Mockup")

These brought up a new question.

Could you combine the [getByLatLong function](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getByLatLon "WOF getByLatLong Query") with the [getNearby function](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getNearby "WOF getNearby Query")? The [getByLatLong function](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getByLatLon "WOF getByLatLong Query") is essentially equivalent to the [getNearby function](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getNearby "WOF getNearby Query"), without the radius argument. 

This convinced me to combine the [getByLatLong](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getByLatLon "WOF getByLatLong Query") and [getNearby](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getNearby "WOF getNearby Query") queries into one type of interaction, while the [getIntersects query](https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getIntersects "WOF getIntersects Query") would be represented by a different interaction. They would be represented by the icons in the top left of the mockup below.

![Combined Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction33.png "Combined Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction33.png "Combined Mockup")

The point (dot) icon would represent the `getByLatLong` and `getNearby` interaction. When active, users would be able to select a point on the map and/or specify a radius, latitude, and longitude in a window on the bottom left. The box icon would represent the `getIntersects` interaction. When active, users would be able to draw a box on the map or specify minimum and maximum latitudes and longitudes in a window on the bottom left. The results of the those queries would be seen in the right hand column, followed by the API query run to acquire those results.

![Activated Icon Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction39.png "Activated Icon Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction39.png "Activated Icon Mockup")

We would also need a walkthrough to help users understand the functionality of the component.

![Component Walkthrough](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction33Small.png "Component Walkthrough")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction33Small.png "Component Walkthrough")

After showing my team this set of mockups, they mentioned including descendants. I felt it would difficult for users to utilize the point and box functionality to find specific places and their descendants. 

Users could search for a place and then view the descendants of those places, but the walkthrough would have to be broken up. 

![Search Walkthrough Screen](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction41.png "Search Walkthrough Screen")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction41.png "Search Walkthrough Screen")

![Point Walkthrough Screen](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction46.png "Point Walkthrough Screen")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction46.png "Point Walkthrough Screen")

I also explored different possible implementations.

For instance, could you recognize a place, find that place’s locality, find that locality’s parent, and then use that parent to find different places on the same level as the original place’s locality? You could then give users the ability to view the descendants of those localities.
<p>
<div style="margin: 0 auto; width:25%;">
<img alt="View Descendants" src="https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction47Small.png">
</div>
<p>
Or could you provide users an interface to move from one level to another.
<p>
<div style="margin: 0 auto; width:25%;">
<img alt="View Descendants" src="https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/MapInteraction48Small.png">
</div>
<p>
I ultimately believe that these implementations would not work as well as a search and would lead to more difficulty for the user.

###Stats

An additional way to create a dialog that could capture the attention of a user, while showing the depth of the project, would be through stats. WOF provides an ample amount of stats that could be relevant to a wide variety of users. At the same time, stats must be limited. You do not want to be consistently processing statistics in the background.

With the stats, I also wanted to avoid the parts of WOF that require background knowledge. Users shouldn’t have to discern what things mean, and the stats should be relatively simple.

So what statistics would users understand?

* *Total # of records* - _users definitely understand records when given some context_
* *Total # of countries* - _users understand countries too_
* *Total # of marine areas* - _a user may not immediately connect oceans, rivers, and seas with marines areas, maybe this one should be avoided_
* *Total # of regions* - _users have a general sense of regions_
* *Total # of counties* - _counties should be avoided, there are a greater number of localities than counties_
* *Total # of localities* - _users will not be able to immediately identify what a locality is, but we can add a small explanation that a locality is a city or town_
* *Total # of neighborhoods* - _probably does not fit, not every venue has a neighborhood, users from different areas may identify a neighborhood differently_
* *Total # of venues* - _users should understand this and it is at the core of WOF_

Further exploration needs to take place to understand how to organize and visualize the stats. Should it go from higher levels place types (countries, regions, etc…) to lower level place types (venues, etc…)? Should these stats be context specific? How much more computation would that require? Is that computation worth it?

![Stat Mockup 1](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock4Small.png "Stat Mockup 1")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock4Small.png "Stat Mockup 1")

![Stat Mockup 2](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock5Small.png "Stat Mockup 2")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock5Small.png "Stat Mockup 2")

![Stat Mockup 3](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock6Small.png "Stat Mockup 3")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock6Small.png "Stat Mockup 3")

###Getting Users Started

The website should also provide users with tools to immediately get started with WOF. This includes the different options a user could take to use WOF. For example, if a user knows the specific path and ID for a particular place, the website should provide that user with an example URL they could use to retrieve data. Or if the user wants to use the [WOF API](https://mapzen.com/documentation/wof/ "WOF API"), that user should see a number of example queries and links to additional documentation. A link to [the Github repo where all WOF data lives](https://github.com/whosonfirst-data "WOF Data Github repo") would also work, users could then download their own version of the data if they so desire. You can find a mockup below to see just how this could work.

![Getting Started Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock12Small.png "Getting Started Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstMock12Small.png "Getting Started Mockup")

###Information Architecture

Currently, part of WOF lives solely on [Github](https://github.com/whosonfirst, "WOF Github Repo"). One example of this is [source information](https://github.com/whosonfirst/whosonfirst-sources "WOF Sources"). In order to make WOF more useable we plan to clone selected parts of the information on Github to the website.

Some subpages already exist, for example the theory and data page, but at the very least there should be a page for tools, the blog, data, and docs. All these topics are complicated. By creating separate pages, less emphasis can be paid to those subjects on the home page.

We are currently working on just how all this information will be organized. Below you can find some mockups.

![Subpage Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstSubpageMock4.png "Subpage Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstSubpageMock4.png "Subpage Mockup")

![Subpage Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstSubpageMock2.png "Subpage Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstSubpageMock2.png "Subpage Mockup")

![Subpage Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstSubpageMock6.png "Subpage Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstSubpageMock6.png "Subpage Mockup")

![Subpage Mockup](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstSubpageMock8.png "Subpage Mockup")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/WhosOnFirstSubpageMock8.png "Subpage Mockup")

##Where Are We Now?

Below you will see how the current site looks in a development environment. We just pushed this out to production.

![Current Rebuilt Website](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/whoswholescreen.png "Current Rebuilt Website")
[See full-size image](https://s3.amazonaws.com/mapzen-assets/images/wof-website-resdesign/whoswholescreen.png "Current Rebuilt Website")

##Where Are We Going To Be?

Over the course of the next couple weeks, we plan to make further improvements to the website in the following areas:

* Building out the interactive component.
* Creating a narrative around WOF stats.
* Working on the information architecture of the website.
* Deciding what information lives on the website and what information lives on Github.

Let us know what you think at @[alloftheplaces](https://twitter.com/alloftheplaces)!
