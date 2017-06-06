# whosonfirst-www

whosonfirst.mapzen.com – it's a website.

## Deploying

### tl;dr

```
make www
```

### The long version

We are using a home-grown tool called `wof-clone-website` which is part of the [go-whosonfirst-www](https://github.com/whosonfirst/go-whosonfirst-www) repo, mostly so that file permissions are set correctly. There is a binary copy for OS X included in this repo so if you're trying to deploy things from not-a-Mac then you will need to build an OS-specific version of the tool, which is left as an exercise to the reader.

## See also

* https://github.com/whosonfirst/whosonfirst-data
* https://github.com/whosonfirst/go-whosonfirst-www
