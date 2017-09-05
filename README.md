# whosonfirst-www

whosonfirst.mapzen.com – it's a website.

## What is going on in here?

This is one of those static website generators, with lowest-common-denominator dependencies. The very short version is that a `Makefile` turns concatinates many smaller bits of HTML into a site structure that we can upload to the Internet.

* `Makefile` - a whole lotta `curl` and `cat` and `sed` that makes it all go.
* `pages/` - each section of the site has its own sub-makefile (e.g., `data.mk`)
* `components/` - things like headers and footers, navs and subnavs, that sandwich the content.
* `content/` - what it sounds like, these HTML files define what you see in the main part of the page.
* `www/` - where everything gets built to.

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

## Adding a blog post

To add a blog post:

1. Open [content/blog/blog.html](https://github.com/whosonfirst/whosonfirst-www/blob/master/content/blog/blog.html) file.
2. Scroll to the bottom of that file.
3. If it is a new year, add a h6 element with updated content and id.  
    ````html
    <h6 id="2017" class="whosonfirst-deemphasized-subpageheader">2017</h6>
    ````
4. If you added a h6 element, also add a new unordered list.  
    ````html
    <ul class="whosonfirst-nonbullet-list whosonfirst-sole-links-container">
    </ul>
    ````
5. If you added a new unordered list, add a list item in that new list.  
    ````html
    <ul class="whosonfirst-nonbullet-list whosonfirst-sole-links-container">
        <li class="whosonfirst-nonbullet-list-item">
        </li>
    </ul>
    ````

    If you did not add a new unordered list, add the list item after the last list item in the last existing unordered list.

    ```html
    <ul class="whosonfirst-nonbullet-list whosonfirst-sole-links-container">
        <li class="whosonfirst-nonbullet-list-item">
            <a href="https://mapzen.com/blog/geotagging-wof-venues/" class="whosonfirst-sole-link whosonfirst-dynamically-generated-post" data-pubdate="2017-08-01" title="Geotagging WOF venues" data-au="0.44" data-word-count="2392">Geotagging WOF venues</a>
        </li>
        <li class="whosonfirst-nonbullet-list-item">
        </li>
    </ul>
    ```
6. Add a link to the new list item, be sure sure to include the link url and whosonfirst-sole-link and whosonfirst-dynamically-generated-post as classes.  
    ```html
    <ul class="whosonfirst-nonbullet-list whosonfirst-sole-links-container">
        <li class="whosonfirst-nonbullet-list-item">
            <a href="https://mapzen.com/blog/geotagging-wof-venues/" class="whosonfirst-sole-link whosonfirst-dynamically-generated-post" data-pubdate="2017-08-01" title="Geotagging WOF venues" data-au="0.44" data-word-count="2392">Geotagging WOF venues</a>
        </li>
        <li class="whosonfirst-nonbullet-list-item">
            <a href="https://mapzen.com/blog/wof-website-redesign/" class="whosonfirst-sole-link whosonfirst-dynamically-generated-post" data-pubdate="2017-07-28" title="Redesigning and Rebuilding the Who's On First website" data-au="0.40" data-word-count="2194">Redesigning and Rebuilding the Who's On First website</a>
        </li>
    </ul>
    ```
7. Run `make blog` from the command line. The blog page should now be updated with the new blog post.

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

Or, if you want to deploy to just dev or prod S3 buckets:

```
make www-dev
make www-prod
```

### Cloning to S3

We are using a home-grown tool called `wof-clone-website` which is part of the [go-whosonfirst-www](https://github.com/whosonfirst/go-whosonfirst-www) repo, mostly so that file permissions are set correctly. There is a binary copy for OS X included in this repo so if you're trying to deploy things from not-a-Mac then you will need to build an OS-specific version of the tool, which is left as an exercise to the reader.

## Props

Thanks to 2017 summer intern [Scott Dombkowski](http://scottdombkowski.com/) for designing and building the new site.

## See also

* https://github.com/whosonfirst/whosonfirst-data
* https://github.com/whosonfirst/go-whosonfirst-www
