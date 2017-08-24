# Adding a Blog Post to the Blog Page

To add a blog post, follow the instructions below:

1. Navigate to the [blog.html](https://github.com/whosonfirst/whosonfirst-www/blob/sdombkow-v2-clean/www/content/blog/blog.html) file, the path to this file should be www/content/blog/blog.html
2. Scroll to the bottom of that file.
3. If it is a new year, add a h6 element with updated content and id.
```html
<h6 id="2017" class="whosonfirst-deemphasized-subpageheader">2017</h6>
```
4. If you added a h6 element, also add a new unordered list.
```html
<ul class="whosonfirst-nonbullet-list whosonfirst-sole-links-container">
</ul>
```
5. If you added a new unordered list, add a list item in that new list.
```html
<ul class="whosonfirst-nonbullet-list whosonfirst-sole-links-container">
    <li class="whosonfirst-nonbullet-list-item">
    </li>
</ul>
```
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
7. Navigate to the folder to the whosonfirst-www folder in your console. Run `make blog`. The blog page should now be updated with the new blog post.