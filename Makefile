all: mapzen css

mapzen:
	if test -e www/css/mapzen.css; then cp www/css/mapzen.css www/css/mapzen.css.bak; fi
	curl -s -o www/css/mapzen.css https://mapzen.com/common/styleguide/styles/styleguide.css

css:
	cat www/css/mapzen.css www/css/whosonfirst.css > www/css/mapzen.whosonfirst.bundle.css
	java -jar utils/yuicompressor-2.4.8.jar --type css www/css/mapzen.whosonfirst.bundle.css -o www/css/mapzen.whosonfirst.min.css