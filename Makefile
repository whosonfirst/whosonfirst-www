all: mapzen css placetypes

mapzen:
	curl -s -o www/css/mapzen-styleguide.css https://mapzen.com/common/styleguide/styles/styleguide.css

css:
	cat www/css/mapzen-styleguide.css www/css/whosonfirst.css > www/css/mapzen.whosonfirst.bundle.css
	java -jar utils/yuicompressor-2.4.8.jar --type css www/css/mapzen.whosonfirst.bundle.css -o www/css/mapzen.whosonfirst.min.css

placetypes:
	curl -s -o www/images/placetypes-latest.png https://raw.githubusercontent.com/whosonfirst/whosonfirst-placetypes/master/images/placetypes-latest.png
