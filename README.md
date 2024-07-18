# whosonfirst-www

whosonfirst.org – it's a website.

## Important

Outside of the blog the way this website is structured and built is _weird_.

It is due an overhaul but please don't exhaust yourself getting worked up about how weird and often confusing and sometimes frustrating it is to use. It just _is_ and more importantly it's gotten us this far, allowing us to work on other things.

What you're seeing here is the output of a summer of work with Scott (Dubrowski) who did fantastic work to update the design and site architecture and Dan (Phiffer) who helped Scott along the way building an as-you-go toolset to facilitate Scott's work. It's not perfect but it does work. It just requires pressing a lot of buttons in a lot of files sometimes. So it goes.

## What is going on in here?

This is one of those static website generators, with lowest-common-denominator dependencies. The very short version is that a `Makefile` turns concatinates many smaller bits of HTML into a site structure that we can upload to the Internet.

* `Makefile` - a whole lotta `curl` and `cat` and `sed` that makes it all go.
* `pages/` - each section of the site has its own sub-makefile (e.g., `data.mk`)
* `components/` - things like headers and footers, navs and subnavs, that sandwich the content.
* `content/` - what it sounds like, these HTML files define what you see in the main part of the page.
* `www/` - where everything gets built to.

## Blog posts

The `/blog` part of the website is handled differently from the rest of the Who's On First website. The "tl;dr" is: Jekyll-like Markdown files and Golang templates that are rendered using the [whosonfirst/go-blog](https://github.com/whosonfirst/go-blog) package.

There are really only two "rules" for blog posts:

* They are expected to live in a nested `YYYY/MM/DD/TITLE` directory structure. For example:

`/blog/2024/07/18/more-shapefiles/`

2) They are expected to contain Jekyll-style "front-matter" supplemented with a hand full for Who's On First specific properties. For example:

```
layout: page
title: Who’s On First shapefile downloads in QGIS and on HDX
published: false
date: 2024-07-18
permalink: /blog/2024/07/18/more-shapefiles/
category: blog
excerpt: "Shapefiles are the resurgent vinyl music format for digital mapping"
authors: [nvkelso]
image: "images/88663_58c7addb90c5c93a_b.png"
tag: [shapefile,download,whosonfirst,wof,data]
```

After that it's just plain-old Markdown.

To render the blog in to its HTML format run the `blog` Makefile target. For example:

```
$> make blog
"utils/darwin/wof-md2html" -templates templates/common -templates templates/blog/post -header blog_post_header -footer blog_post_footer -writer fs=./www -mode directory www/blog/
"utils/darwin/wof-md2idx" -templates templates/common -templates templates/blog/index -header blog_index_header -footer blog_index_footer -writer fs=. www/blog/
"utils/darwin/wof-md2idx" -templates templates/common -templates templates/blog/index -header blog_index_header -footer blog_index_footer -writer fs=. -mode authors www/blog/
"utils/darwin/wof-md2idx" -templates templates/common -templates templates/blog/index -header blog_index_header -footer blog_index_footer -writer fs=. -mode tags www/blog/
"utils/darwin/wof-md2feed" -templates templates/blog/feed -format rss_20 www/blog/
"utils/darwin/wof-md2feed" -templates templates/blog/feed -format atom_10 www/blog/
```

To render the blog in to its HTML format and serve those pages from a local webserver run the `debug` Makefile target. For example:

```
$> make debug
...render blog here
2024/07/18 09:09:50 Listening on http://localhost:8080
```

Templates for the blog are stored in the [templates](templates) directory.

## Editing the site

* Some files are downloaded from GitHub, so you should edit them there.
* You can build all the pages with `make build-pages` or a section with `make [section]` or a specific page `make [section]-[page]`.
* All the site content, including GitHub-derived pages, is stored in `content/`.
* The navigation and other template HTML lives in `components/`.
* Nothing is automatic, you have to edit the navigation files yourself.

You may notice the `Makefile` is full of `@` symbols. This hides the command from the output, which makes it easier to observe the site-build progress. Feel free to un-`@` a specific line if you want to see more details.

### Example: editing a page from GitHub

Let's say you want to edit the [Known Knowns](https://whosonfirst.mapzen.com/data/knownknowns/) page. This is one of the pages pulled down from GitHub. You can tell because `content/data/knownknowns.html` has an HTML comment that links to the Markdown document it's built from.

```
<!-- https://github.com/whosonfirst-data/whosonfirst-data/blob/master/README.KNOWN.KNOWNS.md -->
<h1 id="there-are-known-knowns">There are known knowns...</h1>
```

You'll notice that GitHub-derived pages are modified so that all the HTML is on a single line, so editing them directly would be a pain anyway.

1. Edit [README.KNOWN.KNOWNS.md](https://github.com/whosonfirst-data/whosonfirst-data/blob/master/README.KNOWN.KNOWNS.md) on GitHub using the pencil button (you could also clone/commit/push your edits, it's up to you).
2. Download the updated content HTML: `make data-download-knownknowns`
3. Build the page: `make data-knownknowns`

### Example: editing a page that lives in whosonfirst-www

Most of that same process applies for pages that _don't_ originate from GitHub. For example, to update the main [docs](https://whosonfirst.mapzen.com/docs/) page:

1. Edit `content/docs/docs.html` directly, then save your file.
2. Build the page: `make docs-home`

## Adding a new page

Look in the `pages` folder and open the `.mk` file for the section where your new page will live. In this example we'll create a new page "foo" in the "docs" section.

### Downloading HTML from GitHub

_Note: If your page doesn't "live" on GitHub, you can skip this part._

Open `pages/docs.mk` and add an additional line to the `docs-download-content` target:

```
docs-download-content: \
	docs-download-properties \
	docs-download-brooklynintegers \
	...
	docs-download-foo
```

Define your new download target, using a variable for the repo base URL, defined at the top of `pages/docs.mk`:

```
SOME_REPO := https://github.com/whosonfirst/whosonfirst-some-repo/blob/master/

...

docs-download-foo:
	@make URL=$(SOME_REPO)pages/foo.md \
	      OUT=docs/foo.html \
	      download-content
```

This will download HTML from `https://github.com/whosonfirst/whosonfirst-some-repo/blob/master/pages/foo.md` and save it to `content/docs/foo.html`.

Test it out by running your new target at the command line:

```
make docs-download-foo
```

### Building the `www` page HTML

There are different page "levels" that determine how the templates work.

* `build-page-level0` - everything in `home.mk`, no top nav section
* `build-page-level1` - section home pages (e.g., [docs](https://whosonfirst.mapzen.com/docs/))
* `build-page-level2` - sub-pages inside a section (e.g., [properties](https://whosonfirst.mapzen.com/docs/properties/))
* `build-page-level3` - sub-sub-pages (e.g., [wof properties](https://whosonfirst.mapzen.com/docs/properties/wof/))

Each section has its own set of `[section]-build-page-level[n]` targets that define common section-wide values.

In the case of our example, `content/docs/foo.html`, we will use `docs-build-page-level2` since it's a sub-page inside docs.

```
docs-foo:
	@make CONTENT=docs/foo.html \
	      OUT=docs/foo/index.html \
	      PAGE_TITLE='foo page title' \
	      SUBNAV_LINK=foo \
	      docs-build-page-level2
```

The variables getting passed are:

* `CONTENT` - path to the file to use inside the `content/` dir.
* `OUT` - path to the `www/` output file (use the `[page]/index.html` convention).
* `PAGE_TITLE` - ends up in the page `<title>`
* `SUBNAV_LINK` - the link to highlight in the sidebar subnav
* `SUBSUBNAV` - optional, for linking to level 3 pages (e.g., set to `properties` in the [properties](https://whosonfirst.mapzen.com/docs/properties/) pages)

Test it out at the command line, and see if you can load up your new page:

```
make docs-foo
```

You should see your new page here: `www/docs/foo/index.html`

### Updating the subnav

In our last example we created a new page "foo" in the "docs" section. Let's add a link to it in the subnav files.

There are two places we need to add it:

* `components/subnav/docs/subnav-top.html` - for desktop/tablet/etc.
* `components/subnav/docs/subnav-bottom.html` - for mobile

Edit `subnav-top.html` and add new `<li>` and `<a>` elements:

```
<li class="whosonfirst-sidenav-list-element">
    <a href="/docs/foo/" class="whosonfirst-nav-link whosonfirst-sidenav-link">foo</a>
</li>
```

Do the same for `subnav-bottom.html`:

```
<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
    <a href="/docs/foo/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">foo</a>
</li>
```

Note that because we are using a really dumb `sed` replacement, the _last_  `class` value should be the same as all the other links.

## Sub-sub-navs

You may notice that there are some other component files in the `subnav` directory. Those are for sub-sections like [properties](https://whosonfirst.mapzen.com/docs/properties/), whose subsubnav is defined by `components/subnav/docs/properties-top.html` (for desktop/tablet/etc.) and `components/subnav/docs/properties-bottom.html` (for mobile).

These get included by defining a `SUBSUBNAV` variable (e.g., `SUBSUBNAV=properties`) when invoking each page build.

When defined, the _subsubnav_ HTML component gets inserted into the _subnav_ based on an HTML comment `<!-- [subsubnav] -->` in `subnav-top.html` and `subnav-bottom.html`.

For example, here's how the `properties` subsubnav gets placed within `components/subnav/docs/subnav-top.html`:

```
<li class="whosonfirst-sidenav-list-element">
    <a href="/docs/properties/" class="whosonfirst-nav-link whosonfirst-sidenav-link">properties</a>
</li>
<!-- properties -->
<li class="whosonfirst-sidenav-list-element">
    <a href="/docs/concordances/" class="whosonfirst-nav-link whosonfirst-sidenav-link">concordances</a>
</li>
```

## Building the site

* `make` - download and build _all the pages_
* `make docs` - download and build pages in the docs section
* `make download` - download all the content
* `make build-pages` - build all the pages

## Deploying

### tl;dr

```
make www
```

## Props

Thanks to 2017 summer intern [Scott Dombkowski](http://scottdombkowski.com/) for designing and building the new site.

(debug)

## See also

* https://github.com/whosonfirst/whosonfirst
* https://github.com/whosonfirst/whosonfirst-data