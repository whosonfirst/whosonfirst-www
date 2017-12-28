---
layout: page
category: blog
title: "Geotagging WOF venues"
excerpt: "Photography as data collection."
image: "https://mapzen-assets.s3.amazonaws.com/images/geotagging-wof-venues/yoonseoul-selfie.jpg"
authors: [dphiffer]
tag: [boundaryissues, whosonfirst, data]
---

For much of this summer I’ve been working remotely on Who’s On First. In early July I was in Korea giving [a workshop on offline mapping](http://seoulbiennale.org/en/public-programs/educational/read-write-offline-mapping) as part of the [Seoul Biennale of Architecture and Urbanism](http://seoulbiennale.org/en/). From there I joined my wife [Ellie](https://ellieirons.com/) at an [artist residency in Taipei](http://bambooculture.com/en), where I’ve been working 12 hours ahead of my [EDT](https://whosonfirst.mapzen.com/spelunker/id/102047399/) colleagues. Along the way I’ve been collecting new places for WOF, since both [Taiwan](https://github.com/whosonfirst-data/whosonfirst-data-venue-tw) and [South Korea](https://github.com/whosonfirst-data/whosonfirst-data-venue-kr) are still rather sparsely populated with venues. This was my excuse to try using my software “in the field” and expand WOF’s venue coverage.

This post includes a fair share of obscure technical details. Perhaps it might be useful for someone working on a similar application. (And shout-out to the NYPL’s [Bert Spaan](http://bertspaan.nl/) who’s released a very interesting looking [geotagging Leaflet plugin](https://github.com/nypl-spacetime/Leaflet.GeotagPhoto).)

## Start where you are

I started with what I already had running on [Boundary Issues](https://github.com/whosonfirst/whosonfirst-www-boundaryissues/), I just loaded it up on my phone. (Here is where I mention that the bespoke web-based editor I’m working on for Who’s On First is not quite ready for public use, but [I’m blogging about it](https://mapzen.com/tag/boundaryissues) out in the open anyway. [Drop us a line](mailto:boundaryissues@mapzen.com) if you think you have something to add.) In addition to the general purpose [WOF properties editor](https://mapzen.com/blog/boundary-issues-properties/), I’ve been working on a pared down [venue-specific interface](https://mapzen.com/blog/simple-is-hard/). I used that simpler venues UI to try adding some new places I’ve enjoyed during my travels.

I am carrying two phones with me. One is an iPhone 5 with T-Mobile’s generous data roaming—a throttled, but functional, version of the mobile data service I get at home (at no extra cost). The other is a Samsung Galaxy S7 with Verizon service, which works great, but not outside the USA. I’ve been sticking to wifi hotspots on the Android phone while I’m traveling.

## Slow bandwidth is very real

Instead of investing in a Korean or Taiwanese SIM card, I decided to embrace my slower bandwidth as a useful constraint. By sticking to my throttled roaming data, I’m getting a bit of a taste for what mobile bandwidth bottlenecks feel like day-to-day. My iPhone is limited to 3G networks even though everyone around me has fast LTE connectivity.

I’ve gotten better at planning ahead, making a deliberate effort to cache the map data (and routing results) I know I’ll need to navigate the city. In NYC, my network experience alternates between fast cable, fast mobile data (with a subway break for reading a book), and then back to a fast fiber connection. It’s easy to forget about all the slow connectivity that’s out here.

In testing out Boundary Issues, the first thing I learned is that mobile web slippy maps don’t really work so well on a bandwidth-constrained network. I would load up the “Add A Venue” page and just stare at the place where a map should appear. After waiting long enough, the screen would turn off to save battery and I’d mutter something rude under my breath.

![3G network blues](https://mapzen-assets.s3.amazonaws.com/images/geotagging-wof-venues/3g-sadness.jpg)

## The “headless” option

I decided to try a different approach. What if instead of relying on a mobile web page, I used the latitude/longitude metadata embedded in the photos I took?  I could just take pictures and then process them when I got back to a faster internet connection. This had the added benefit of making data collection more enjoyable. Instead of staring down at my pocket supercomputer all the time, I’d just take a quick photo from the lock screen shortcut, and it’d go right back into my pocket.

I took a bunch of photos around Seoul with each of my phones. This method was so much faster, and felt less battery intensive compared to my mobile web interface. Once I got back to my laptop, I downloaded the photos and ran them through a [command-line script](https://github.com/whosonfirst/whosonfirst-www-boundaryissues/blob/master/bin/jpgs2csv.php) to convert a folder of images into a CSV file containing a list of filenames and latitude/longitude coordinates.

![CSV geotagging](https://mapzen-assets.s3.amazonaws.com/images/geotagging-wof-venues/csv-geotagging.jpg)

I took that CSV file and imported it into Boundary Issues, using the [step-through venue importer](https://mapzen.com/blog/weird-and-wonderful/). And it worked! The one flaw in this setup was matching up each filename from the CSV with its corresponding photo in order to remember the place names.

At first I opted for my S7’s higher quality camera. But then I noticed Android has a tendency to hold onto an outdated location compared to iOS. Now I prefer the lower-quality photos from my old iPhone, favoring its more consistently accurate geotags. (Perhaps there is some setting in Android to improve its accuracy that I’m missing.)

## Skipping the CSV stage

After running a few CSV venue imports, I started to wonder if I could just put the visual cue I’d photographed *on the page* next to the extracted geotags. I continue to be astonished at the range of things JavaScript can do. As it turns out, you can [import/cache JPEG binary data](https://gist.github.com/straup/0ee19019afd88c6dbd2d) and [extract EXIF tags](https://github.com/exif-js/exif-js) without hitting any server-side code.

The newest incarnation of the geotagged importer is basically an [HTML file input](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/file) wired up to some fancy JavaScript that eventually uploads a GeoJSON WOF record into Boundary Issues. With some important caveats (discussed below), this approach lets you keep your geotagged photo on your own device(s). Boundary Issues inspects the geotags on the client-side, so it doesn’t need to store a copy of the photo itself.

At some point we may offer an opportunity for users to opt into a Creative Commons license, and associate their photos with WOF records, but that opens up lots of questions we aren’t yet prepared to address. For now Boundary Issues cares very narrowly about geotag metadata, only keeping a photograph (in `localStorage`) long enough for you to remember which place it depicts.

![Geotagging Yoonseul](https://mapzen-assets.s3.amazonaws.com/images/geotagging-wof-venues/yoonseoul.gif)
<p class="caption"><a href="https://whosonfirst.mapzen.com/spelunker/id/1158786431/">윤슬 or Yoonseul</a> is a <a href="http://societyofarchitecture.com/soa/project/yoonsulmanridong-reflects-seoul/">public art/public space installation</a> in Seoul</a></p>

## EXIF tags contain multitudes

Working with photos straight off the camera has  some quirks. Upon reading an image from an `<input type="file">` you get a binary `Blob` (yes, that is the [technical name](https://developer.mozilla.org/en/docs/Web/API/Blob)) that [contains](https://en.wikipedia.org/wiki/JPEG#Syntax_and_structure):

* Technical metadata like width, height, tables needed to decode the image.
* A sequence of compressed bits—a “scan”—that represent the image. (In the case of “progressive scan” JPEGs there are multiple scans of increasing quality.)
* “Application-specific” metadata, including Exchangeable Image File Format (EXIF), including lots of detailed context (where/when/how it was shot) about the photo.

There are a great many things that EXIF tags can describe about a photo. The tags can tell you which model of camera produced the photo as well as details about the exposure settings like shutter speed and f-stop. In the case of (configured properly) smartphones, the EXIF tags also contain latitude/longitude/altitude metadata. I normally disable geotags on my phone camera [for privacy reasons](https://www.eff.org/deeplinks/2012/04/picture-worth-thousand-words-including-your-location), but they’ve been very useful for gathering venue data.

Another important tag I inadvertently encountered is the [EXIF Orientation mode](https://www.daveperrett.com/articles/2012/07/28/exif-orientation-handling-is-a-ghetto/). If you’ve ever seen a photo that someone posted online that looked upside-down, it’s because the image scan was stored in the upside-down order that the camera captured it, and the EXIF tag instructing the computer how to display the image right-side-up was ignored. Web browsers are still not so great applying that EXIF orientation mode (see also: my [EXIF orientation test page](https://phiffer.org/etc/exif-orientation-test/)).

As it happens, there is a [CSS3 `image-orientation` property](https://developer.mozilla.org/en-US/docs/Web/CSS/image-orientation) for exactly this purpose. It even includes a magical sounding `from-image` setting, which sounds like it should fix things right up. Unfortunately [nobody but Firefox](http://caniuse.com/#search=image-orientation) supports this approach. It’s up to us web developers to rotate EXIF-oriented photos ourselves.

![plz caniuse?](https://mapzen-assets.s3.amazonaws.com/images/geotagging-wof-venues/caniuse-image-orientation.jpg)

## Compatibility is (usually) better than correctness

But wait, it gets worse! One platform, iOS, behaves differently than every other operating system (at least, so far as I’ve gathered). iOS arguably does the “right thing” with these tags, but it is the _only case_ I know of where the EXIF tags are taken into account. Everyone else seemingly ignores the EXIF orientation entirely.

Let’s say you upload a photo you took in EXIF Orientation 3 (volume buttons up) from Mobile Safari on iOS. The resulting photo will look totally normal on your iPhone, because iOS decoded the EXIF Orientation and flipped the image around for you. Everyone else on _every other platform_ (including Safari on macOS) will see an upside-down version. The best part is how it _looks totally normal_ to the original poster, understandably baffled by the inevitable jokes in the comments about being in the opposite hemisphere.

One additional caveat I discovered is that iOS _only_ compensates for the EXIF Orientation with `<img>` tags, ignoring the EXIF orientation of background images, like non-iOS browsers. My geotagging interface switches between `<img>` and `background-image` CSS, so this detail was just one more mystery to untangle along the way.

![Taipei 101, as viewed from Xiangshan Trail](https://mapzen-assets.s3.amazonaws.com/images/geotagging-wof-venues/taipei-101.jpg)
<p class="caption"><a href="https://whosonfirst.mapzen.com/spelunker/id/1141959909/">Taipei 101</a> as viewed from the <a href="https://whosonfirst.mapzen.com/spelunker/id/1141959907/">象山 Xiangshan Trail</a> (aka Elephant Mountain).</p>

## Yep, CSS can fix it

The upshot of all this EXIF Orientation mode stuff is that working with photos that are upside-down or sideways is _really annoying_, making it hard to decipher whatever it was you were trying to photograph. It’s important for me to get this detail right, instead of holding my device sideways/upside-down to _see the dang photo_ like a chump.

After [detecting the EXIF Orientation mode](https://github.com/whosonfirst/whosonfirst-www-boundaryissues/blob/32dbe0cd63beba4ff3f7d3d40a092fb9c8af53fd/www/javascript/mapzen.whosonfirst.geotagged.js#L228-L247) in JavaScript and [assigning a set of CSS classes](https://github.com/whosonfirst/whosonfirst-www-boundaryissues/blob/32dbe0cd63beba4ff3f7d3d40a092fb9c8af53fd/www/javascript/mapzen.whosonfirst.geotagged.js#L26-L37), I used a [`transform` property](https://github.com/whosonfirst/whosonfirst-www-boundaryissues/blob/8e6f6444f0a88859e30aa7c5fcfb181cfedb1bd9/www/css/mapzen.boundaryissues.css#L894-L920) to rotate each image (or flip it) back into its intended position. Success! Except … in iOS, which earns a [special browser sniff](https://github.com/whosonfirst/whosonfirst-www-boundaryissues/commit/8e6f6444f0a88859e30aa7c5fcfb181cfedb1bd9#diff-14ab22632dd21f09bf0afcbd351b8d23R788) for not conforming. Without that special case, my CSS transform would flip an image, only to have iOS helpfully _flip the photo back upside-down again_ (and then I was like `(╯°□°）╯︵ ┻━┻`).

If I was processing photos on the server-side, I would prefer rotating photos by rearranging the order of bits in the JPEG scan and stripping out the EXIF orientation tag altogether. Either [`jhead -autorot flipped.jpg`](http://www.sentex.net/~mwandel/jhead/usage.html) or [`exiftran -ia rotated.jpg`](https://www.kraxel.org/blog/linux/fbida/) would neatly avoid the problem of client-side photo orientation.

## Mobile telephones are really, like, _a thing_ now

You may have noticed lots of people enjoy taking pictures with their mobile phones. One might say they’re more like [network-connected _cameras_](https://craigmod.com/journal/photography_hello/) than _phones_ at this point. This kind of had me wondering—what if I load up a Boundary Issues geotagging page on my camera/phone, and maybe press the `<input type="file">` to launch the camera app—capturing a geotagged photo right from the (tiny) web page?

This is kind of getting back to where I started, except with a slightly different interaction than before. Instead of telling a map to gather my current location with the [`geolocation` API](https://github.com/domoritz/leaflet-locatecontrol), a photo could act both as a saved-for-later digital artifact and as a means to convey my current location into a WOF record.

In iOS you can totally launch the camera from a web page, and the JavaScript gets the same data Blob, but the EXIF metadata is mysteriously lacking geotags. Even if you’ve enabled location services for Mobile Safari, Chrome, and the Camera. Android _does_ include geotags with photos taken with its version of the Chrome browser, but I’ve found that it occasionally omits them.

I’ve filed a <a href="https://mapzen-assets.s3.amazonaws.com/images/geotagging-wof-venues/geotags-bug-report.jpg">bug report with Apple</a> and created a <a href="https://phiffer.org/etc/file-input-geotags/">minimal test case</a>, but so far it’s hard to say <em>why</em> iOS omits geotags, or whether it’s likely to be fixed in a future release. I’ll update this post as I learn more.

## Metadata is complicated

JPEG geotags, and the mixed salad of web technologies required to work with them, are tricky to get right. But the resulting user experience of capturing latitude/longitude coordinates via the camera is really seamless, once you get the settings right. This ease-of-use is burdened by the fact that geotagging metadata can be [potentially](http://www.nytimes.com/2010/08/12/technology/personaltech/12basics.html) [dangerous](http://www.bbc.com/news/technology-17311702) if you inadvertently share your location on the open web, especially for at-risk populations. (There are helpful guides online for [iOS](https://forums.imore.com/guides-how-articles/271636-guide-how-enable-disable-geotagging.html) and [Android](https://www.youtube.com/watch?v=WeraN99NJ0U).)

The inertia that comes with phone camera configurations makes it easy to accidentally leave geotags enabled outside of the narrow data-gathering context. The small choices that developers and designers make about these interfaces (what are the defaults? when do you get visual cues that geotagging is enabled?) are shifting norms around what we’re comfortable sharing, with whom, and in what contexts. Software that [nudges us toward oversharing](https://www.theverge.com/2017/6/23/15864552/snapchat-snap-map-privacy-threat) will eventually exclude and endanger those of us who have reason to worry about our location privacy (I would argue that includes _everyone_, even if they don’t realize it yet).

I want Boundary Issues to use geotagged photos responsibly, ideally reminding each user to reconfigure location services once they are done gathering venue locations. Until iOS and Android provide some explicit mechanism for this, it might make sense to send an email or Slack message reminder after each geotagging session.

I’ve been struck by how hard it is to detect which photos carry geotagged metadata and how easy it is to accidentally share my precise location online. Both iOS and Android helpfully group photo albums by location, but lack safety features like [geofencing](https://en.wikipedia.org/wiki/Geo-fence) or warning me when I’m about to share my location metadata. There are many opportunities for improving web-based applications as well. Us web developers need to call attention to users which of their photos carry geotags, especially _before_ they upload them.

## Onward

Despite some challenges working with EXIF metadata, it’s been fun to have a simpler mechanism for collecting new WOF venues. I now find myself photographing lots of signage, particularly those signs that include place names in both English and Korean/Chinese. I now explore the built environment thinking of which places I might want to capture for Who’s On First.

I’ve also been doing some experiments with using the [Cordova mobile app framework](https://cordova.apache.org/) to run a basic [Tangram map](https://mapzen.com/documentation/tangram/). This geotagging interface has me thinking about how an offline-friendly geotagging app might incorporate the work [Aaron](http://aaronland.info/) has been doing on [place bookmarking](https://github.com/whosonfirst/electron-whosonfirst-bookmarks/). In due time all of this will be ready enough to invite more users to try it out. Please [get in touch](mailto:boundaryissues@mapzen.com) if you’re interested!
