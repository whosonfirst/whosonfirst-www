---
layout: page
title: Change to the Who's On First administrative data
published: false
date: 2019-05-09
permalink: /blog/2019/05/09/changes/
category: blog
excerpt: 
authors: [thisisaaronland]
image: ""
tag: [whosonfirst,wof,github]
---

There are some pretty substantial changes coming to the way we will publish
administrative data in Who's On First (WOF) and from the perspective of people
not actively working on WOF they will be coming fast, like next week.

Administrative data means everything in the `whosonfirst-data` repository, or
everything ranging from continents (and empires) to neighbourhoods (and
microhoods). Historically we have included all of these things in a single
comprehensive repository spanning the planet and that approach has had a lot of
benefits. It also means that over time and as we've improved the data and added
records for missing places the repository has gotten... well, pretty
big.

So big that the Git history file is now larger than the sum total of the
data which is already pretty big (and which grew substantially after we finished
importing 4M localities from Geonames). The history file is also impossibly big
because of some unfortunate decisions we made to include overly-large "meta"
files with the raw data in the past.

You might say that the `whosonfirst-data` repository was "comically big" if it
weren't for the fact that it's also become impractically big both for
individuals working with WOF data and especially for GitHub who host the
data. Almost any Git operation takes forever on a local machine and probably
sets off alarms on the GitHub servers.

Earlier this year WOF and people who had forked the original `whosonfirst-data`
repository received notices from GitHub saying that the repo (and its forks) were
way too big and were placing an undue burden on their infrastructure. Oh,
and would everyone please delete their copies of the repository.

Before we go any further this is a good time to say that **GitHub have been
basically awesome about all of this**. They have been patient and understanding as
we've tried to find an alternative solution (as in not just deleting all the
data) that addresses everyone's concerns. WOF is the beneficiary of GitHub's
decision to offer free hosting for projects and frankly we feel pretty bad that
we have ended up being the project that has become a hassle for them.

So, here's what's going to happen:

* All the data files in the original `whosonfirst-data` repository have been
  migrated in to per-country repositories. The naming convention for these
  repositories is `whosonfirst-data-admin-{TWO_LETTER_WOF_COUNTRY_CODE}`.

* Any data that isn't associated with a country will be migrated to the
  ``whosonfirst-data-admin-xy` repository. This includes things like continents,
  empires and of course Null Island.

* The `whosonfirst-data` repository will be purged and replaced with
  documentation and pointers to the new data. The Git history (between
  2015-2019) will be archived on the Who's On First servers for anyone who wants
  that data or who needs a known-difficult [problem set](https://en.wikipedia.org/wiki/Problem_set) to use for improving
  Git.

All of this will happen next week, on or around May 15th. In fact, the first two
things have already happened and all new data and updates are being applied to
the per-country repos. What will happen next week is the purging of the original
`whosonfirst-data` repo so that GitHub (and everyone else) can stop thinking
about this.

It's worth repeating that **GitHub have been entirely gracious throughout this
process** and if people want to be cross about things they should be cross with us
(WOF) for not communicating these changes sooner. They don't call them "growing
pains" for nothing, I guess.

There are some follow-on consequences to these decisions that will, in the
short-term, affect how Who's On First distributions (bundles, SQLite databases,
etc.) are built.

The most notable is that for some amount of time there will not be a single "all
the administrative data" distribution for Who's On First. Instead, there will be a
SQLite distribution for each country, as well as the `-admin-xy` repository, and
it will be the responsibility of consumers to fetch each one individually. This
is not ideal and there is [on-going work to generate a single combined
distribution](https://github.com/whosonfirst/go-whosonfirst-dist/compare/combined)
but it's not complete yet. Unfortunately, as of this writing, I can't say when it will be
finished beyond "real soon now".

WOF has been designed from the beginning with the idea that _one day_ it will be
possible to merge all the data in the different `whosonfirst-data-*` repos in to
a single monolithic repository. That would be good for a bunch of reasons but
the reality, in 2019, is that it's still beyond the limits of what Git (and by
extension GitHub) can tolerate. We are not the only people with this
problem. For example, Microsoft quickly discovered that Git had problems
handling twenty-plus years of Windows source code and since then they've been working on
developing improvements. We're just not there yet.

Similarly, faceted repos are already a reality in WOF. We have had per-country
and in some cases per-region repositories for postal codes and venues almost
from beginning. What we
have lacked is the tooling for making these facetings transparent (or at least
easier) to end-users. So, maybe the silver lining in all of this is that the
changes to the administrative data will be the catalyst for developing and
improving these tools. 

We apologize for the unfortunate bumpiness ahead. If it's any consolation
we'll be dealing it too and with any luck it will be short-lived and we can all
get back to doing other things.

