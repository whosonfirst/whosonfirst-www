# whosonfirst-www

whosonfirst.mapzen.com – it's a website.

## What is going on in here?

This is one of those static website things. This one uses a Makefile to turn all the smaller bits of HTML into a site structure we can upload to the Internet.

* `Makefile` - a whole lotta `curl` and `sed` that makes it all go
* `pages` - each section of the site has its own sub-makefile (e.g., `data.mk`)
* `components` - things like header and footers that sandwich the content
* `content` - what it sounds like, these HTML files are the main thing you see on the page
* `www` - where it all gets built to

## Deploying

### tl;dr

```
make build-pages
make www
```

### Cloning to S3

We are using a home-grown tool called `wof-clone-website` which is part of the [go-whosonfirst-www](https://github.com/whosonfirst/go-whosonfirst-www) repo, mostly so that file permissions are set correctly. There is a binary copy for OS X included in this repo so if you're trying to deploy things from not-a-Mac then you will need to build an OS-specific version of the tool, which is left as an exercise to the reader.

## See also

* https://github.com/whosonfirst/whosonfirst-data
* https://github.com/whosonfirst/go-whosonfirst-www
