UNAME_S := $(shell uname -s)

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
	curl -s https://github.com/whosonfirst/whosonfirst-placetypes/blob/master/README.md | pup -i 0 'article.markdown-body' > www/placetypes/content.html
	sed -i -e 's/\/whosonfirst\/whosonfirst-placetypes\/raw\/master\/images/..\/images/' www/placetypes/content.html
	cat www/components/header.html www/placetypes/content.html www/components/footer.html > www/placetypes/index2.html
	sed -i -e 's/\<li id\=\"nav\-item\-placetypes\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-placetypes\" class\=\"section-nav\-item active\">/' www/placetypes/index2.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Placetypes/' www/placetypes/index2.html
	rm www/placetypes/content.html-e
	rm www/placetypes/content.html
	rm www/placetypes/index2.html-e

wof-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/wof.md | pup -i 0 'article.markdown-body' > www/properties/wof-properties-content.html
	cat www/components/header.html www/properties/wof-properties-content.html www/components/footer.html > www/properties/wof-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/wof-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/wof-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - WOF Properties/' www/properties/wof-properties.html
	rm www/properties/wof-properties.html-e
	rm www/properties/wof-properties-content.html
	
src-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/src.md | pup -i 0 'article.markdown-body' > www/properties/src-properties-content.html
	cat www/components/header.html www/properties/src-properties-content.html www/components/footer.html > www/properties/src-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/src-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Src Properties/' www/properties/src-properties.html
	rm www/properties/src-properties.html-e
	rm www/properties/src-properties-content.html

reversegeo-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/reversegeo.md | pup -i 0 'article.markdown-body' > www/properties/reversegeo-properties-content.html
	cat www/components/header.html www/properties/reversegeo-properties-content.html www/components/footer.html > www/properties/reversegeo-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/reversegeo-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - ReverseGeo Properties/' www/properties/reversegeo-properties.html
	rm www/properties/reversegeo-properties.html-e
	rm www/properties/reversegeo-properties-content.html
	
resto-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/resto.md | pup -i 0 'article.markdown-body' > www/properties/resto-properties-content.html
	cat www/components/header.html www/properties/resto-properties-content.html www/components/footer.html > www/properties/resto-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/resto-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Resto Properties/' www/properties/resto-properties.html
	rm www/properties/resto-properties.html-e
	rm www/properties/resto-properties-content.html
	
name-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/name.md | pup -i 0 'article.markdown-body' > www/properties/name-properties-content.html
	cat www/components/header.html www/properties/name-properties-content.html www/components/footer.html > www/properties/name-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/name-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Name Properties/' www/properties/name-properties.html
	rm www/properties/name-properties.html-e
	rm www/properties/name-properties-content.html

mz-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/mz.md | pup -i 0 'article.markdown-body' > www/properties/mz-properties-content.html
	cat www/components/header.html www/properties/mz-properties-content.html www/components/footer.html > www/properties/mz-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/mz-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Mz Properties/' www/properties/mz-properties.html
	rm www/properties/mz-properties.html-e
	rm www/properties/mz-properties-content.html

lbl-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/lbl.md | pup -i 0 'article.markdown-body' > www/properties/lbl-properties-content.html
	cat www/components/header.html www/properties/lbl-properties-content.html www/components/footer.html > www/properties/lbl-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/lbl-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Lbl Properties/' www/properties/lbl-properties.html
	rm www/properties/lbl-properties.html-e
	rm www/properties/lbl-properties-content.html
	
geom-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/geom.md | pup -i 0 'article.markdown-body' > www/properties/geom-properties-content.html
	cat www/components/header.html www/properties/geom-properties-content.html www/components/footer.html > www/properties/geom-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/geom-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Geom Properties/' www/properties/geom-properties.html
	rm www/properties/geom-properties.html-e
	rm www/properties/geom-properties-content.html
	
edtf-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/edtf.md | pup -i 0 'article.markdown-body' > www/properties/edtf-properties-content.html
	cat www/components/header.html www/properties/edtf-properties-content.html www/components/footer.html > www/properties/edtf-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/edtf-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Edtf Properties/' www/properties/edtf-properties.html
	rm www/properties/edtf-properties.html-e
	rm www/properties/edtf-properties-content.html
	
addr-properties:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/addr.md | pup -i 0 'article.markdown-body' > www/properties/addr-properties-content.html
	cat www/components/header.html www/properties/addr-properties-content.html www/components/footer.html > www/properties/addr-properties.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/properties/addr-properties.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Addr Properties/' www/properties/addr-properties.html
	rm www/properties/addr-properties.html-e
	rm www/properties/addr-properties-content.html
	
properties-pages: wof-properties src-properties reversegeo-properties resto-properties name-properties mz-properties lbl-properties geom-properties edtf-properties addr-properties

names:
	curl -s https://github.com/whosonfirst/whosonfirst-names/blob/master/README.md | pup -i 0 'article.markdown-body' > www/docs/names-content.html
	cat www/components/header.html www/docs/names-content.html www/components/footer.html > www/docs/names.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/docs/names.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Names/' www/docs/names.html
	rm www/docs/names.html-e
	rm www/docs/names-content.html
	
geometries:
	curl -s https://github.com/whosonfirst/whosonfirst-geometries/blob/master/README.md | pup -i 0 'article.markdown-body' > www/docs/geometries-content.html
	cat www/components/header.html www/docs/geometries-content.html www/components/footer.html > www/docs/geometries.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/docs/geometries.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Geometries/' www/docs/geometries.html
	rm www/docs/geometries.html-e
	rm www/docs/geometries-content.html
	
alt-geometries:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/creating_alt_geometries.md | pup -i 0 'article.markdown-body' > www/docs/alt-geometries-content.html
	cat www/components/header.html www/docs/alt-geometries-content.html www/components/footer.html > www/docs/alt-geometries.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/docs/alt-geometries.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Alt. Geometries/' www/docs/alt-geometries.html
	rm www/docs/alt-geometries.html-e
	rm www/docs/alt-geometries-content.html
	
geometry-pages: geometries alt-geometries

dates:
	curl -s https://github.com/whosonfirst/whosonfirst-dates/blob/master/README.md | pup -i 0 'article.markdown-body' > www/docs/dates-content.html
	cat www/components/header.html www/docs/dates-content.html www/components/footer.html > www/docs/dates.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/docs/dates.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Dates/' www/docs/dates.html
	rm www/docs/dates.html-e
	rm www/docs/dates-content.html
	
sources:
	curl -s https://github.com/whosonfirst/whosonfirst-sources/blob/master/README.md | pup -i 0 'article.markdown-body' > www/docs/sources-content.html
	cat www/components/header.html www/docs/sources-content.html www/components/footer.html > www/docs/sources.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/docs/sources.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Sources/' www/docs/sources.html
	rm www/docs/sources.html-e
	rm www/docs/sources-content.html
	
source-list:
	curl -s https://github.com/whosonfirst/whosonfirst-sources/blob/master/sources/README.md | pup -i 0 'article.markdown-body' > www/docs/source-list-content.html
	cat www/components/header.html www/docs/source-list-content.html www/components/footer.html > www/docs/source-list.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/docs/source-list.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Source List/' www/docs/source-list.html
	rm www/docs/source-list.html-e
	rm www/docs/source-list-content.html
	
source-pages: sources source-list

tests:
	curl -s https://github.com/whosonfirst/whosonfirst-tests/blob/master/README.md | pup -i 0 'article.markdown-body' > www/docs/tests-content.html
	cat www/components/header.html www/docs/tests-content.html www/components/footer.html > www/docs/tests.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/docs/tests.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Tests/' www/docs/tests.html
	rm www/docs/tests.html-e
	rm www/docs/tests-content.html
	
contributing:
	curl -s https://github.com/whosonfirst/whosonfirst-placetypes/blob/master/CONTRIBUTING.md | pup -i 0 'article.markdown-body' > www/docs/contributing-content.html
	cat www/components/header.html www/docs/contributing-content.html www/components/footer.html > www/docs/contributing.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/docs/contributing.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Contributing/' www/docs/contributing.html
	rm www/docs/contributing.html-e
	rm www/docs/contributing-content.html

licensing:
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/LICENSE.md | pup -i 0 'article.markdown-body' > www/docs/licensing-content.html
	cat www/components/header.html www/docs/licensing-content.html www/components/footer.html > www/docs/licensing.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Licensing/' www/docs/licensing.html
	sed -i -e 's/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-docs\" class\=\"section-nav\-item active\">/' www/docs/licensing.html
	rm www/docs/licensing.html-e
	rm www/docs/licensing-content.html
	
docs: licensing contributing tests source-pages dates geometry-pages names properties-pages
	
pull-request:
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/PULL_REQUEST_TEMPLATE_NEIGHBOURHOOD.md | pup -i 0 'article.markdown-body' > www/data/pull-request-content.html
	cat www/components/header.html www/data/pull-request-content.html www/components/footer.html > www/data/pull-request.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Pull Request Template/' www/data/pull-request.html
	sed -i -e 's/\<li id\=\"nav\-item\-data\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-data\" class\=\"section-nav\-item active\">/' www/data/pull-request.html
	rm www/data/pull-request.html-e
	rm www/data/pull-request-content.html
	
data-known-knowns:
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/README.KNOWN.KNOWNS.md | pup -i 0 'article.markdown-body' > www/data/known-knowns-content.html
	cat www/components/header.html www/data/known-knowns-content.html www/components/footer.html > www/data/known-knowns.html
	sed -i -e 's/Who'\''s On First &#x2014;/Who'\''s On First - Known Knowns/' www/data/known-knowns.html
	sed -i -e 's/\<li id\=\"nav\-item\-data\" class\=\"section-nav\-item\">/\<li id\=\"nav\-item\-data\" class\=\"section-nav\-item active\">/' www/data/known-knowns.html
	rm www/data/known-knowns.html-e
	rm www/data/known-knowns-content.html
	
data: pull-requests data-known-knowns

v2-test:
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/README.KNOWN.KNOWNS.md | pup -i 0 'article.markdown-body h1' > www/test/v2-test-content.html
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/README.KNOWN.KNOWNS.md | pup -i 0 'article.markdown-body :not(h1)' > www/test/v2-test-content-two.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/test/v2-test-content.html
	cat www/componentsv2/head.html www/componentsv2/navbar.html www/componentsv2/subnav1.html www/test/v2-test-content.html www/componentsv2/subnav2.html www/test/v2-test-content-two.html www/componentsv2/footer.html > www/test/v2-test.html
	rm www/test/v2-test-content.html
	rm www/test/v2-test-content-two.html
	
v2-testtwo:
	curl -s https://github.com/whosonfirst/whosonfirst-dates/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/test/v2-test-content-three.html
	curl -s https://github.com/whosonfirst/whosonfirst-dates/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/test/v2-test-content-four.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/test/v2-test-content-three.html
	cat www/componentsv2/head.html www/componentsv2/navbar.html www/componentsv2/subnav1.html www/test/v2-test-content-three.html www/componentsv2/subnav2.html www/test/v2-test-content-four.html www/componentsv2/footer.html > www/test/v2-test-two.html
	rm www/test/v2-test-content-three.html
	rm www/test/v2-test-content-four.html
	
v2-testthree:
	curl -s https://github.com/whosonfirst/whosonfirst-names/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/test/v2-test-content-five.html
	curl -s https://github.com/whosonfirst/whosonfirst-names/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/test/v2-test-content-six.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/test/v2-test-content-five.html
	cat www/componentsv2/head.html www/componentsv2/navbar.html www/componentsv2/subnav1.html www/test/v2-test-content-five.html www/componentsv2/subnav2.html www/test/v2-test-content-six.html www/componentsv2/footer.html > www/test/v2-test-three.html
	rm www/test/v2-test-content-five.html
	rm www/test/v2-test-content-six.html
	
setup:
	ubuntu/setup-nginx.sh

www: www-dev www-prod

www-dev: css
ifeq ($(UNAME_S),Darwin)
	utils/darwin/wof-clone-website -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -s3-bucket whosonfirst.dev.mapzen.com -source www/
else ifeq ($(UNAME_S),Linux)
	utils/linux/wof-clone-website -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -s3-bucket whosonfirst.dev.mapzen.com -source www/
else ifeq ($(UNAME_S),Windows)
	utils/windows/wof-clone-website -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -s3-bucket whosonfirst.dev.mapzen.com -source www/
else
	echo "this OS is not supported yet"
	exit 1
endif

www-prod: css
ifeq ($(UNAME_S),Darwin)
	utils/darwin/wof-clone-website -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -source www/
else ifeq ($(UNAME_S),Linux)
	utils/linux/wof-clone-website -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -source www/
else ifeq ($(UNAME_S),Windows)
	utils/windows/wof-clone-website -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -source www/
else
	echo "this OS is not supported yet"
	exit 1
endif

tools:
	./utils/mk-utils.sh go-whosonfirst-www wof-clone-website 
