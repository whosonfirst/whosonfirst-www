all: mapzen js css placetypes

css:
	curl -s -o www/css/mapzen.whosonfirst.chrome.css https://raw.githubusercontent.com/whosonfirst/css-mapzen-whosonfirst/master/css/mapzen.whosonfirst.chrome.css
	cat www/css/mapzen-styleguide.css www/css/mapzen.whosonfirst.chrome.css www/css/mapzen.whosonfirst.www.css > www/css/mapzen.whosonfirst.www.bundle.css
	java -jar utils/yuicompressor-2.4.8.jar --type css www/css/mapzen.whosonfirst.www.bundle.css -o www/css/mapzen.whosonfirst.www.bundle.min.css

js:
	curl -s -o www/javascript/mapzen.whosonfirst.chrome.js https://raw.githubusercontent.com/whosonfirst/js-mapzen-whosonfirst/master/src/mapzen.whosonfirst.chrome.js
	curl -s -o www/javascript/mapzen.whosonfirst.chrome.init.js https://raw.githubusercontent.com/whosonfirst/js-mapzen-whosonfirst/master/src/mapzen.whosonfirst.chrome.init.js
	cat www/javascript/mapzen.whosonfirst.chrome.js www/javascript/mapzen.whosonfirst.chrome.init.js www/javascript/mapzen.whosonfirst.www.js > www/javascript/mapzen.whosonfirst.www.bundle.js
	java -jar utils/yuicompressor-2.4.8.jar www/javascript/mapzen.whosonfirst.www.bundle.js -o www/javascript/mapzen.whosonfirst.www.bundle.min.js

mapzen:
	curl -s -o www/css/mapzen-styleguide.css https://mapzen.com/common/styleguide/styles/styleguide.css

placetypes:
	curl -s -o www/images/placetypes-latest.png https://raw.githubusercontent.com/whosonfirst/whosonfirst-placetypes/master/images/placetypes-latest.png
	curl -s https://github.com/whosonfirst/whosonfirst-www/blob/sdombkow-nav-newheaderfooter-optiontwo/READMEPLACETYPES.md | pup -i 0 'article.markdown-body' > www/placetypes/content.html
	sed -i -e 's/\/whosonfirst\/whosonfirst-placetypes\/raw\/master\/images/..\/images/' www/placetypes/content.html
	sed -i -e 's/\/whosonfirst\/whosonfirst-placetypes\/blob\/master\/images/..\/images/' www/placetypes/content.html
	cat www/components/header.html www/placetypes/content.html www/components/footer.html > www/placetypes/index2.html
	sed -i -e 's/\<li id\=\"nav\-item\-placetypes\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-placetypes\" class\=\"section-nav\-item active\">/' www/placetypes/index2.html
	rm www/placetypes/content.html-e
	rm www/placetypes/content.html
	rm www/placetypes/index2.html-e

setup:
	ubuntu/setup-nginx.sh

www: www-dev www-prod

www-dev: css
	utils/darwin/wof-clone-website -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -s3-bucket whosonfirst.dev.mapzen.com -source www/

www-prod: css
	utils/darwin/wof-clone-website -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -source www/
