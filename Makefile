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
	rm www/test/v2-test-content.html-e
	
v2-testtwo:
	curl -s https://github.com/whosonfirst/whosonfirst-dates/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/test/v2-test-content-three.html
	curl -s https://github.com/whosonfirst/whosonfirst-dates/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/test/v2-test-content-four.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/test/v2-test-content-three.html
	cat www/componentsv2/head.html www/componentsv2/navbar.html www/componentsv2/subnav1.html www/test/v2-test-content-three.html www/componentsv2/subnav2.html www/test/v2-test-content-four.html www/componentsv2/footer.html > www/test/v2-test-two.html
	rm www/test/v2-test-content-three.html
	rm www/test/v2-test-content-four.html
	rm www/test/v2-test-content-three.html-e
	
v2-testthree:
	curl -s https://github.com/whosonfirst/whosonfirst-names/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/test/v2-test-content-five.html
	curl -s https://github.com/whosonfirst/whosonfirst-names/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/test/v2-test-content-six.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/test/v2-test-content-five.html
	cat www/componentsv2/head.html www/componentsv2/navbar.html www/componentsv2/subnav1.html www/test/v2-test-content-five.html www/componentsv2/subnav2.html www/test/v2-test-content-six.html www/componentsv2/footer.html > www/test/v2-test-three.html
	rm www/test/v2-test-content-five.html
	rm www/test/v2-test-content-six.html
	rm www/test/v2-test-content-five.html-e
	
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

v2-documents-properties-addr:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/addr.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/addr.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/addr.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties-edtf:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/edtf.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/edtf.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/edtf.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e

v2-documents-properties-geom:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/geom.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/geom.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/geom.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties-lbl:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/lbl.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/lbl.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/lbl.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties-mz:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/mz.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/mz.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/mz.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties-name:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/name.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/name.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/name.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties-resto:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/resto.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/resto.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/resto.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties-reversegeo:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/reversegeo.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/reversegeo.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/reversegeo.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties-src:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/src.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/src.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/src.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties-wof:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/wof.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/wof.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/wof.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties-brooklynintegers:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/brooklyn_integers.md| pup -i 0 'article.markdown-body h1' > www/v2/docs/properties/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/brooklyn_integers.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/properties/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/properties/subnav-top.html www/v2/docs/properties/temp-content1.html www/v2/components/subnav/docs/properties/subnav-bottom.html  www/v2/docs/properties/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/properties/brooklynintegers.html
	rm www/v2/docs/properties/temp-content1.html
	rm www/v2/docs/properties/temp-content2.html
	rm www/v2/docs/properties/temp-content1.html-e
	
v2-documents-properties: v2-documents-properties-addr v2-documents-properties-edtf v2-documents-properties-geom v2-documents-properties-lbl v2-documents-properties-mz v2-documents-properties-name v2-documents-properties-resto v2-documents-properties-reversegeo v2-documents-properties-src v2-documents-properties-wof v2-documents-properties-brooklynintegers

v2-documents-concordances:
	cat www/v2/content/docs/concordances/concordances.html | pup -i 0 'body h1' > www/v2/docs/concordances/temp-content1.html
	cat www/v2/content/docs/concordances/concordances.html | pup -i 0 'body :not(h1)' > www/v2/docs/concordances/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/concordances/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/concordances/subnav-top.html www/v2/docs/concordances/temp-content1.html www/v2/components/subnav/docs/concordances/subnav-bottom.html  www/v2/docs/concordances/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/concordances/index.html
	rm www/v2/docs/concordances/temp-content1.html
	rm www/v2/docs/concordances/temp-content2.html
	rm www/v2/docs/concordances/temp-content1.html-e
	
v2-documents-placetypes:
	curl -s https://github.com/whosonfirst/whosonfirst-placetypes/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/placetypes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-placetypes/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/placetypes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/placetypes/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/placetypes/subnav-top.html www/v2/docs/placetypes/temp-content1.html www/v2/components/subnav/docs/placetypes/subnav-bottom.html  www/v2/docs/placetypes/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/placetypes/index.html
	rm www/v2/docs/placetypes/temp-content1.html
	rm www/v2/docs/placetypes/temp-content2.html
	rm www/v2/docs/placetypes/temp-content1.html-e
	
v2-documents-hierachies-index:
	cat www/v2/content/docs/hierachies/hierachies.html | pup -i 0 'body h1' > www/v2/docs/hierachies/temp-content1.html
	cat www/v2/content/docs/hierachies/hierachies.html | pup -i 0 'body :not(h1)' > www/v2/docs/hierachies/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/hierachies/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/hierachies/subnav-top.html www/v2/docs/hierachies/temp-content1.html www/v2/components/subnav/docs/hierachies/subnav-bottom.html  www/v2/docs/hierachies/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/hierachies/index.html
	rm www/v2/docs/hierachies/temp-content1.html
	rm www/v2/docs/hierachies/temp-content2.html
	rm www/v2/docs/hierachies/temp-content1.html-e

v2-documents-hierachies-disputedareas:
	cat www/v2/content/docs/hierachies/disputedareas.html | pup -i 0 'body h1' > www/v2/docs/hierachies/temp-content1.html
	cat www/v2/content/docs/hierachies/disputedareas.html | pup -i 0 'body :not(h1)' > www/v2/docs/hierachies/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/hierachies/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/hierachies/subnav-top.html www/v2/docs/hierachies/temp-content1.html www/v2/components/subnav/docs/hierachies/subnav-bottom.html  www/v2/docs/hierachies/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/hierachies/disputedareas.html
	rm www/v2/docs/hierachies/temp-content1.html
	rm www/v2/docs/hierachies/temp-content2.html
	rm www/v2/docs/hierachies/temp-content1.html-e

v2-documents-hierachies-superseded:
	cat www/v2/content/docs/hierachies/superseded.html | pup -i 0 'body h1' > www/v2/docs/hierachies/temp-content1.html
	cat www/v2/content/docs/hierachies/superseded.html | pup -i 0 'body :not(h1)' > www/v2/docs/hierachies/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/hierachies/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/hierachies/subnav-top.html www/v2/docs/hierachies/temp-content1.html www/v2/components/subnav/docs/hierachies/subnav-bottom.html  www/v2/docs/hierachies/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/hierachies/superseded.html
	rm www/v2/docs/hierachies/temp-content1.html
	rm www/v2/docs/hierachies/temp-content2.html
	rm www/v2/docs/hierachies/temp-content1.html-e
	
v2-documents-hierachies: v2-documents-hierachies-index v2-documents-hierachies-disputedareas v2-documents-hierachies-superseded

v2-documents-names:
	curl -s https://github.com/whosonfirst/whosonfirst-names/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/names/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-names/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/names/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/names/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/names/subnav-top.html www/v2/docs/names/temp-content1.html www/v2/components/subnav/docs/names/subnav-bottom.html  www/v2/docs/names/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/names/index.html
	rm www/v2/docs/names/temp-content1.html
	rm www/v2/docs/names/temp-content2.html
	rm www/v2/docs/names/temp-content1.html-e
	
v2-documents-geometries-index:
	curl -s https://github.com/whosonfirst/whosonfirst-geometries | pup -i 0 'article.markdown-body h1' > www/v2/docs/geometries/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-geometries | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/geometries/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/geometries/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/geometries/subnav-top.html www/v2/docs/geometries/temp-content1.html www/v2/components/subnav/docs/geometries/subnav-bottom.html  www/v2/docs/geometries/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/geometries/index.html
	rm www/v2/docs/geometries/temp-content1.html
	rm www/v2/docs/geometries/temp-content2.html
	rm www/v2/docs/geometries/temp-content1.html-e
	
v2-documents-geometries-altgeometries:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/creating_alt_geometries.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/geometries/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/creating_alt_geometries.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/geometries/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/geometries/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/geometries/subnav-top.html www/v2/docs/geometries/temp-content1.html www/v2/components/subnav/docs/geometries/subnav-bottom.html  www/v2/docs/geometries/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/geometries/altgeometries.html
	rm www/v2/docs/geometries/temp-content1.html
	rm www/v2/docs/geometries/temp-content2.html
	rm www/v2/docs/geometries/temp-content1.html-e
	
v2-documents-geometries: v2-documents-geometries-index v2-documents-geometries-altgeometries

v2-documents-dates:
	curl -s https://github.com/whosonfirst/whosonfirst-dates | pup -i 0 'article.markdown-body h1' > www/v2/docs/dates/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-dates | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/dates/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/dates/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/dates/subnav-top.html www/v2/docs/dates/temp-content1.html www/v2/components/subnav/docs/dates/subnav-bottom.html  www/v2/docs/dates/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/dates/index.html
	rm www/v2/docs/dates/temp-content1.html
	rm www/v2/docs/dates/temp-content2.html
	rm www/v2/docs/dates/temp-content1.html-e
	
v2-documents-categories:
	curl -s https://github.com/whosonfirst/whosonfirst-categories/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/categories/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-categories/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/categories/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/categories/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/categories/subnav-top.html www/v2/docs/categories/temp-content1.html www/v2/components/subnav/docs/categories/subnav-bottom.html  www/v2/docs/categories/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/categories/index.html
	rm www/v2/docs/categories/temp-content1.html
	rm www/v2/docs/categories/temp-content2.html
	rm www/v2/docs/categories/temp-content1.html-e
	
v2-documents-sources-index:
	curl -s https://github.com/whosonfirst/whosonfirst-sources | pup -i 0 'article.markdown-body h1' > www/v2/docs/sources/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-sources | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/sources/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/sources/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/sources/subnav-top.html www/v2/docs/sources/temp-content1.html www/v2/components/subnav/docs/sources/subnav-bottom.html  www/v2/docs/sources/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/sources/index.html
	rm www/v2/docs/sources/temp-content1.html
	rm www/v2/docs/sources/temp-content2.html
	rm www/v2/docs/sources/temp-content1.html-e
	
v2-documents-sources-source-list:
	curl -s https://github.com/whosonfirst/whosonfirst-sources/blob/master/sources/README.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/sources/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-sources/blob/master/sources/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/sources/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/sources/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/sources/subnav-top.html www/v2/docs/sources/temp-content1.html www/v2/components/subnav/docs/sources/subnav-bottom.html  www/v2/docs/sources/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/sources/listofsources.html
	rm www/v2/docs/sources/temp-content1.html
	rm www/v2/docs/sources/temp-content2.html
	rm www/v2/docs/sources/temp-content1.html-e
	
v2-documents-sources: v2-documents-sources-index v2-documents-sources-source-list

v2-documents-tests:
	curl -s https://github.com/whosonfirst/whosonfirst-tests/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/v2/docs/tests/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-tests/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/v2/docs/tests/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/tests/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/tests/subnav-top.html www/v2/docs/tests/temp-content1.html www/v2/components/subnav/docs/tests/subnav-bottom.html  www/v2/docs/tests/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/tests/index.html
	rm www/v2/docs/tests/temp-content1.html
	rm www/v2/docs/tests/temp-content2.html
	rm www/v2/docs/tests/temp-content1.html-e
	
v2-documents-contributing:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/CONTRIBUTING.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/contributing/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/CONTRIBUTING.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/contributing/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/contributing/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/contributing/subnav-top.html www/v2/docs/contributing/temp-content1.html www/v2/components/subnav/docs/contributing/subnav-bottom.html  www/v2/docs/contributing/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/contributing/index.html
	rm www/v2/docs/contributing/temp-content1.html
	rm www/v2/docs/contributing/temp-content2.html
	rm www/v2/docs/contributing/temp-content1.html-e
	
v2-documents-licensing-datalicenses:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/data_licenses.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/licensing/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/data_licenses.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/licensing/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/licensing/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/licensing/subnav-top.html www/v2/docs/licensing/temp-content1.html www/v2/components/subnav/docs/licensing/subnav-bottom.html  www/v2/docs/licensing/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/licensing/datalicenses.html
	rm www/v2/docs/licensing/temp-content1.html
	rm www/v2/docs/licensing/temp-content2.html
	rm www/v2/docs/licensing/temp-content1.html-e
	
v2-documents-licensing-index:
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/LICENSE.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/licensing/temp-content1.html
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/LICENSE.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/licensing/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/licensing/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/licensing/subnav-top.html www/v2/docs/licensing/temp-content1.html www/v2/components/subnav/docs/licensing/subnav-bottom.html  www/v2/docs/licensing/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/licensing/index.html
	rm www/v2/docs/licensing/temp-content1.html
	rm www/v2/docs/licensing/temp-content2.html
	rm www/v2/docs/licensing/temp-content1.html-e

v2-documents-licensing: v2-documents-licensing-index v2-documents-licensing-datalicenses
	
v2-documents-keyterms:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/key_terms.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/keyterms/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/key_terms.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/keyterms/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/keyterms/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/keyterms/subnav-top.html www/v2/docs/keyterms/temp-content1.html www/v2/components/subnav/docs/keyterms/subnav-bottom.html  www/v2/docs/keyterms/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/keyterms/index.html
	rm www/v2/docs/keyterms/temp-content1.html
	rm www/v2/docs/keyterms/temp-content2.html
	rm www/v2/docs/keyterms/temp-content1.html-e
	
v2-documents-processes-significantevent:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/significant_event.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/significant_event.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/processes/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/processes/subnav-top.html www/v2/docs/processes/temp-content1.html www/v2/components/subnav/docs/processes/subnav-bottom.html  www/v2/docs/processes/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/processes/significantevent.html
	rm www/v2/docs/processes/temp-content1.html
	rm www/v2/docs/processes/temp-content2.html
	rm www/v2/docs/processes/temp-content1.html-e
	
v2-documents-processes-assigningcessation:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/deprecated_vs_cessation.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/deprecated_vs_cessation.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/processes/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/processes/subnav-top.html www/v2/docs/processes/temp-content1.html www/v2/components/subnav/docs/processes/subnav-bottom.html  www/v2/docs/processes/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/processes/assigningcessation.html
	rm www/v2/docs/processes/temp-content1.html
	rm www/v2/docs/processes/temp-content2.html
	rm www/v2/docs/processes/temp-content1.html-e
	
v2-documents-processes-s3requirements:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/requirements_for_s3.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/requirements_for_s3.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/processes/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/processes/subnav-top.html www/v2/docs/processes/temp-content1.html www/v2/components/subnav/docs/processes/subnav-bottom.html  www/v2/docs/processes/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/processes/s3requirements.html
	rm www/v2/docs/processes/temp-content1.html
	rm www/v2/docs/processes/temp-content2.html
	rm www/v2/docs/processes/temp-content1.html-e
	
		
v2-documents-processes-wikipediaconcordances:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/wikipedia_concordances.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/wikipedia_concordances.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/processes/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/processes/subnav-top.html www/v2/docs/processes/temp-content1.html www/v2/components/subnav/docs/processes/subnav-bottom.html  www/v2/docs/processes/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/processes/wikipediaconcordances.html
	rm www/v2/docs/processes/temp-content1.html
	rm www/v2/docs/processes/temp-content2.html
	rm www/v2/docs/processes/temp-content1.html-e
	
v2-documents-processes-seattleneighborhoodupdates:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/seattle_neighbourhood_updates.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/seattle_neighbourhood_updates.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/processes/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/processes/subnav-top.html www/v2/docs/processes/temp-content1.html www/v2/components/subnav/docs/processes/subnav-bottom.html  www/v2/docs/processes/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/processes/seattleneighborhoodupdates.html
	rm www/v2/docs/processes/temp-content1.html
	rm www/v2/docs/processes/temp-content2.html
	rm www/v2/docs/processes/temp-content1.html-e
	
v2-documents-processes-updatingsanfrancisconeighborhoods:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/processes/temp-content2.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_2.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/processes/temp-content3.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/processes/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/processes/subnav-top.html www/v2/docs/processes/temp-content1.html www/v2/components/subnav/docs/processes/subnav-bottom.html  www/v2/docs/processes/temp-content2.html www/v2/docs/processes/temp-content3.html www/v2/components/footer/footer.html > www/v2/docs/processes/updatingsanfrancisconeighborhoods.html
	rm www/v2/docs/processes/temp-content1.html
	rm www/v2/docs/processes/temp-content2.html
	rm www/v2/docs/processes/temp-content3.html
	rm www/v2/docs/processes/temp-content1.html-e
	
v2-documents-processes-woflifecycle:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/wof:id_lifecycle.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/wof:id_lifecycle.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/docs/processes/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/docs-navbar.html www/v2/components/subnav/docs/processes/subnav-top.html www/v2/docs/processes/temp-content1.html www/v2/components/subnav/docs/processes/subnav-bottom.html  www/v2/docs/processes/temp-content2.html www/v2/components/footer/footer.html > www/v2/docs/processes/woflifecycle.html
	rm www/v2/docs/processes/temp-content1.html
	rm www/v2/docs/processes/temp-content2.html
	rm www/v2/docs/processes/temp-content1.html-e
	
v2-documents-processes: v2-documents-processes-significantevent v2-documents-processes-assigningcessation v2-documents-processes-s3requirements v2-documents-processes-wikipediaconcordances v2-documents-processes-seattleneighborhoodupdates v2-documents-processes-updatingsanfrancisconeighborhoods v2-documents-processes-woflifecycle

v2-documents: v2-documents-processes v2-documents-keyterms v2-documents-licensing v2-documents-contributing v2-documents-tests v2-documents-sources v2-documents-categories v2-documents-dates v2-documents-geometries v2-documents-names v2-documents-hierachies v2-documents-placetypes v2-documents-concordances v2-documents-properties

v2-data-pullrequest:
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/PULL_REQUEST_TEMPLATE_NEIGHBOURHOOD.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/v2/data/pullrequest/temp-content1.html
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/PULL_REQUEST_TEMPLATE_NEIGHBOURHOOD.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/v2/data/pullrequest/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/pullrequest/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/pullrequest/subnav-top.html www/v2/data/pullrequest/temp-content1.html www/v2/components/subnav/data/pullrequest/subnav-bottom.html  www/v2/data/pullrequest/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/pullrequest/index.html
	rm www/v2/data/pullrequest/temp-content1.html
	rm www/v2/data/pullrequest/temp-content2.html
	rm www/v2/data/pullrequest/temp-content1.html-e
	
v2-data-principles:
	cat www/v2/content/data/principles/principles.html | pup -i 0 'body h1' > www/v2/data/principles/temp-content1.html
	cat www/v2/content/data/principles/principles.html | pup -i 0 'body :not(h1)' > www/v2/data/principles/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/principles/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/principles/subnav-top.html www/v2/data/principles/temp-content1.html www/v2/components/subnav/data/principles/subnav-bottom.html  www/v2/data/principles/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/principles/index.html
	rm www/v2/data/principles/temp-content1.html
	rm www/v2/data/principles/temp-content2.html
	rm www/v2/data/principles/temp-content1.html-e
	
v2-data-home:
	cat www/v2/content/data/data.html | pup -i 0 'body h1' > www/v2/data/temp-content1.html
	cat www/v2/content/data/data.html | pup -i 0 'body :not(h1)' > www/v2/data/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/temp-content1.html
	cat www/v2/components/head/head-onelevelup.html www/v2/components/navbar/data-navbar-onelevelup.html www/v2/components/subnav/data/home/subnav-top.html www/v2/data/temp-content1.html www/v2/components/subnav/data/home/subnav-bottom.html  www/v2/data/temp-content2.html www/v2/components/footer/footer-onelevelup.html > www/v2/data/index.html
	rm www/v2/data/temp-content1.html
	rm www/v2/data/temp-content2.html
	rm www/v2/data/temp-content1.html-e
	
v2-data-available-index:
	cat www/v2/content/data/available/available.html | pup -i 0 'body h1' > www/v2/data/available/temp-content1.html
	cat www/v2/content/data/available/available.html | pup -i 0 'body :not(h1)' > www/v2/data/available/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/available/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/available/subnav-top.html www/v2/data/available/temp-content1.html www/v2/components/subnav/data/available/subnav-bottom.html  www/v2/data/available/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/available/index.html
	rm www/v2/data/available/temp-content1.html
	rm www/v2/data/available/temp-content2.html
	rm www/v2/data/available/temp-content1.html-e
	
v2-data-available-administrative:
	cat www/v2/content/data/available/administrative.html | pup -i 0 'body h1' > www/v2/data/available/temp-content1.html
	cat www/v2/content/data/available/administrative.html | pup -i 0 'body :not(h1)' > www/v2/data/available/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/available/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/available/subnav-top.html www/v2/data/available/temp-content1.html www/v2/components/subnav/data/available/subnav-bottom.html  www/v2/data/available/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/available/administrative.html
	rm www/v2/data/available/temp-content1.html
	rm www/v2/data/available/temp-content2.html
	rm www/v2/data/available/temp-content1.html-e
	
v2-data-available-venue:
	cat www/v2/content/data/available/venue.html | pup -i 0 'body h1' > www/v2/data/available/temp-content1.html
	cat www/v2/content/data/available/venue.html | pup -i 0 'body :not(h1)' > www/v2/data/available/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/available/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/available/subnav-top.html www/v2/data/available/temp-content1.html www/v2/components/subnav/data/available/subnav-bottom.html  www/v2/data/available/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/available/venue.html
	rm www/v2/data/available/temp-content1.html
	rm www/v2/data/available/temp-content2.html
	rm www/v2/data/available/temp-content1.html-e
	
v2-data-available-other:
	cat www/v2/content/data/available/other.html | pup -i 0 'body h1' > www/v2/data/available/temp-content1.html
	cat www/v2/content/data/available/other.html | pup -i 0 'body :not(h1)' > www/v2/data/available/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/available/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/available/subnav-top.html www/v2/data/available/temp-content1.html www/v2/components/subnav/data/available/subnav-bottom.html  www/v2/data/available/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/available/other.html
	rm www/v2/data/available/temp-content1.html
	rm www/v2/data/available/temp-content2.html
	rm www/v2/data/available/temp-content1.html-e
	
v2-data-available: v2-data-available-index v2-data-available-administrative v2-data-available-venue v2-data-available-other

v2-data-amazon:
	cat www/v2/content/data/amazon/amazon.html | pup -i 0 'body h1' > www/v2/data/amazon/temp-content1.html
	cat www/v2/content/data/amazon/amazon.html | pup -i 0 'body :not(h1)' > www/v2/data/amazon/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/amazon/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/amazon/subnav-top.html www/v2/data/amazon/temp-content1.html www/v2/components/subnav/data/amazon/subnav-bottom.html  www/v2/data/amazon/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/amazon/index.html
	rm www/v2/data/amazon/temp-content1.html
	rm www/v2/data/amazon/temp-content2.html
	rm www/v2/data/amazon/temp-content1.html-e
	
v2-data-github-index:
	cat www/v2/content/data/github/github.html | pup -i 0 'body h1' > www/v2/data/github/temp-content1.html
	cat www/v2/content/data/github/github.html | pup -i 0 'body :not(h1)' > www/v2/data/github/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/github/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/github/subnav-top.html www/v2/data/github/temp-content1.html www/v2/components/subnav/data/github/subnav-bottom.html  www/v2/data/github/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/github/index.html
	rm www/v2/data/github/temp-content1.html
	rm www/v2/data/github/temp-content2.html
	rm www/v2/data/github/temp-content1.html-e
	
v2-data-github-largefiles:
	cat www/v2/content/data/github/gitlargefiles.html | pup -i 0 'body h1' > www/v2/data/github/temp-content1.html
	cat www/v2/content/data/github/gitlargefiles.html | pup -i 0 'body :not(h1)' > www/v2/data/github/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/github/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/github/subnav-top.html www/v2/data/github/temp-content1.html www/v2/components/subnav/data/github/subnav-bottom.html  www/v2/data/github/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/github/gitlargefiles.html
	rm www/v2/data/github/temp-content1.html
	rm www/v2/data/github/temp-content2.html
	rm www/v2/data/github/temp-content1.html-e
	
v2-data-github-reponaming:
	cat www/v2/content/data/github/reponaming.html | pup -i 0 'body h1' > www/v2/data/github/temp-content1.html
	cat www/v2/content/data/github/reponaming.html | pup -i 0 'body :not(h1)' > www/v2/data/github/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/github/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/github/subnav-top.html www/v2/data/github/temp-content1.html www/v2/components/subnav/data/github/subnav-bottom.html  www/v2/data/github/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/github/reponaming.html
	rm www/v2/data/github/temp-content1.html
	rm www/v2/data/github/temp-content2.html
	rm www/v2/data/github/temp-content1.html-e
	
v2-data-github: v2-data-github-index v2-data-github-largefiles v2-data-github-reponaming

v2-data-knownknowns:
	cat www/v2/content/data/knownknowns/knownknowns.html | pup -i 0 'body h1' > www/v2/data/knownknowns/temp-content1.html
	cat www/v2/content/data/knownknowns/knownknowns.html | pup -i 0 'body :not(h1)' > www/v2/data/knownknowns/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/data/knownknowns/temp-content1.html
	cat www/v2/components/head/head.html www/v2/components/navbar/data-navbar.html www/v2/components/subnav/data/knownknowns/subnav-top.html www/v2/data/knownknowns/temp-content1.html www/v2/components/subnav/data/knownknowns/subnav-bottom.html  www/v2/data/knownknowns/temp-content2.html www/v2/components/footer/footer.html > www/v2/data/knownknowns/index.html
	rm www/v2/data/knownknowns/temp-content1.html
	rm www/v2/data/knownknowns/temp-content2.html
	rm www/v2/data/knownknowns/temp-content1.html-e
	
v2-data: v2-data-pullrequest v2-data-principles v2-data-available v2-data-amazon v2-data-github v2-data-knownknowns v2-data-home

v2-blog:
	cat www/v2/content/blog/blog.html | pup -i 0 'body h1' > www/v2/blog/temp-content1.html
	cat www/v2/content/blog/blog.html | pup -i 0 'body :not(h1)' > www/v2/blog/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/blog/temp-content1.html
	cat www/v2/components/head/head-onelevelup.html www/v2/components/navbar/blog-navbar-onelevelup.html www/v2/components/subnav/blog/home/subnav-top.html www/v2/blog/temp-content1.html www/v2/components/subnav/blog/home/subnav-bottom.html  www/v2/blog/temp-content2.html www/v2/components/footer/footer-onelevelup.html > www/v2/blog/index.html
	rm www/v2/blog/temp-content1.html
	rm www/v2/blog/temp-content2.html
	rm www/v2/blog/temp-content1.html-e
	
v2-tools-index:
	cat www/v2/content/tools/tools.html | pup -i 0 'body h1' > www/v2/tools/temp-content1.html
	cat www/v2/content/tools/tools.html | pup -i 0 'body :not(h1)' > www/v2/tools/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/tools/temp-content1.html
	cat www/v2/components/head/head-onelevelup.html www/v2/components/navbar/tools-navbar-onelevelup.html www/v2/components/subnav/tools/home/subnav-top.html www/v2/tools/temp-content1.html www/v2/components/subnav/tools/home/subnav-bottom.html  www/v2/tools/temp-content2.html www/v2/components/footer/footer-onelevelup.html > www/v2/tools/index.html
	rm www/v2/tools/temp-content1.html
	rm www/v2/tools/temp-content2.html
	rm www/v2/tools/temp-content1.html-e
	
v2-tools-availabletools:
	cat www/v2/content/tools/availabletools.html | pup -i 0 'body h1' > www/v2/tools/temp-content1.html
	cat www/v2/content/tools/availabletools.html | pup -i 0 'body :not(h1)' > www/v2/tools/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/v2/tools/temp-content1.html
	cat www/v2/components/head/head-onelevelup.html www/v2/components/navbar/tools-navbar-onelevelup.html www/v2/components/subnav/tools/available/subnav-top.html www/v2/tools/temp-content1.html www/v2/components/subnav/tools/available/subnav-bottom.html  www/v2/tools/temp-content2.html www/v2/components/footer/footer-onelevelup.html > www/v2/tools/availabletools.html
	rm www/v2/tools/temp-content1.html
	rm www/v2/tools/temp-content2.html
	rm www/v2/tools/temp-content1.html-e
	
v2-tools: v2-tools-index v2-tools-availabletools