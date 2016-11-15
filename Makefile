all: mapzen css

mapzen:
	curl -s -o www/css/mapzen-styleguide.css https://mapzen.com/common/styleguide/styles/styleguide.css
	# if test -e www/js/mapzen-styleguide.js; then cp www/js/mapzen-styleguide.js www/js/mapzen-styleguide.js.bak; fi
	# curl -s -o www/js/mapzen-styleguide.js https://mapzen.com/common/styleguide/scripts/styleguide.css

css:
	cat www/css/mapzen-styleguide.css www/css/whosonfirst.css > www/css/mapzen.whosonfirst.bundle.css
	java -jar utils/yuicompressor-2.4.8.jar --type css www/css/mapzen.whosonfirst.bundle.css -o www/css/mapzen.whosonfirst.min.css
