UNAME_S := $(shell uname -s)

all: mapzen js css

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

setup:
	ubuntu/setup-nginx.sh


#Not all new but version 2 specific, from here on below

www: www-dev www-prod

www-dev:
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

www-prod:
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

mk-tools:
	./utils/mk-utils.sh go-whosonfirst-www wof-clone-website 
	
whosonfirst-javascript:
	curl -s -o www/javascript/jquery.min.js https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js
	curl -s -o www/javascript/mapzen.min.js https://mapzen.com/js/mapzen.min.js
	
whosonfirst-css:
	curl -s -o www/css/mapzen.css https://mapzen.com/js/mapzen.css
	
whosonfirst-favicons:
	curl -s -o www/images/favicons/apple-touch-icon.png https://mapzen.com/common/styleguide/images/favicons/apple-touch-icon.png
	curl -s -o www/images/favicons/favicon-16x16.png https://mapzen.com/common/styleguide/images/favicons/favicon-16x16.png
	curl -s -o www/images/favicons/favicon-32x32.png https://mapzen.com/common/styleguide/images/favicons/favicon-32x32.png
	curl -s -o www/images/favicons/manifest.json https://mapzen.com/common/styleguide/images/favicons/manifest.json
	curl -s -o www/images/favicons/safari-pinned-tab.svg https://mapzen.com/common/styleguide/images/favicons/safari-pinned-tab.svg

docs-properties-addr:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/addr.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/addr/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/addr.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/addr/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/addr/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/addr/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/addr/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/addr/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>addr/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>addr/' www/docs/properties/addr/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>addr/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>addr/' www/docs/properties/addr/index.html
	rm www/docs/properties/addr/temp-content1.html
	rm www/docs/properties/addr/temp-content2.html
	rm www/docs/properties/addr/temp-content1.html-e
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Addr\<\/div\>/' www/docs/properties/addr/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/addr/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/addr/index.html
	rm www/docs/properties/addr/index.html-e
	
docs-properties-edtf:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/edtf.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/edtf/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/edtf.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/edtf/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/edtf/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/edtf/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/edtf/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/edtf/index.html
	rm www/docs/properties/edtf/temp-content1.html
	rm www/docs/properties/edtf/temp-content2.html
	rm www/docs/properties/edtf/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>edtf/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>edtf/' www/docs/properties/edtf/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>edtf/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>edtf/' www/docs/properties/edtf/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Edtf\<\/div\>/' www/docs/properties/edtf/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/edtf/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/edtf/index.html
	rm www/docs/properties/edtf/index.html-e

docs-properties-geom:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/geom.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/geom/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/geom.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/geom/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/geom/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/geom/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/geom/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/geom/index.html
	rm www/docs/properties/geom/temp-content1.html
	rm www/docs/properties/geom/temp-content2.html
	rm www/docs/properties/geom/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>geom\</whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>geom\</' www/docs/properties/geom/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>geom/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>geom/' www/docs/properties/geom/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Geom\<\/div\>/' www/docs/properties/geom/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/geom/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/geom/index.html
	rm www/docs/properties/geom/index.html-e
	
docs-properties-lbl:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/lbl.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/lbl/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/lbl.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/lbl/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/lbl/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/lbl/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/lbl/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/lbl/index.html
	rm www/docs/properties/lbl/temp-content1.html
	rm www/docs/properties/lbl/temp-content2.html
	rm www/docs/properties/lbl/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>lb/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>lbl/' www/docs/properties/lbl/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>lbl/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>lbl/' www/docs/properties/lbl/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Lbl\<\/div\>/' www/docs/properties/lbl/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/lbl/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/lbl/index.html
	rm www/docs/properties/lbl/index.html-e
	
docs-properties-mz:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/mz.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/mz/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/mz.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/mz/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/mz/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/mz/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/mz/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/mz/index.html
	rm www/docs/properties/mz/temp-content1.html
	rm www/docs/properties/mz/temp-content2.html
	rm www/docs/properties/mz/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>mz/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>mz/' www/docs/properties/mz/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>mz/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>mz/' www/docs/properties/mz/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Mz\<\/div\>/' www/docs/properties/mz/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/mz/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/mz/index.html
	rm www/docs/properties/mz/index.html-e
	
docs-properties-name:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/name.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/name/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/name.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/name/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/name/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/name/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/name/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/name/index.html
	rm www/docs/properties/name/temp-content1.html
	rm www/docs/properties/name/temp-content2.html
	rm www/docs/properties/name/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>name\</whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>name\</' www/docs/properties/name/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>name/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>name/' www/docs/properties/name/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Name\<\/div\>/' www/docs/properties/name/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/name/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/name/index.html
	rm www/docs/properties/name/index.html-e
	
docs-properties-resto:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/resto.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/resto/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/resto.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/resto/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/resto/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/resto/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/resto/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/resto/index.html
	rm www/docs/properties/resto/temp-content1.html
	rm www/docs/properties/resto/temp-content2.html
	rm www/docs/properties/resto/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>resto/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>resto/' www/docs/properties/resto/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>resto/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>resto/' www/docs/properties/resto/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Resto\<\/div\>/' www/docs/properties/resto/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/resto/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/resto/index.html
	rm www/docs/properties/resto/index.html-e
	
docs-properties-reversegeo:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/reversegeo.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/reversegeo/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/reversegeo.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/reversegeo/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/reversegeo/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/reversegeo/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/reversegeo/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/reversegeo/index.html
	rm www/docs/properties/reversegeo/temp-content1.html
	rm www/docs/properties/reversegeo/temp-content2.html
	rm www/docs/properties/reversegeo/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>reversegeo/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>reversegeo/' www/docs/properties/reversegeo/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>reversegeo/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>reversegeo/' www/docs/properties/reversegeo/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Reverse Geo\<\/div\>/' www/docs/properties/reversegeo/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/reversegeo/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/reversegeo/index.html
	rm www/docs/properties/reversegeo/index.html-e
	
docs-properties-src:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/src.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/src/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/src.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/src/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/src/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/src/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/src/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/src/index.html
	rm www/docs/properties/src/temp-content1.html
	rm www/docs/properties/src/temp-content2.html
	rm www/docs/properties/src/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>src/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>src/' www/docs/properties/src/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>src/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>src/' www/docs/properties/src/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Src\<\/div\>/' www/docs/properties/src/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/src/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/src/index.html
	rm www/docs/properties/src/index.html-e
	
	
docs-properties-wof:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/wof.md | pup -i 0 'article.markdown-body h1' > www/docs/properties/wof/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/properties/wof.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/wof/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/wof/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/wof/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/wof/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/wof/index.html
	rm www/docs/properties/wof/temp-content1.html
	rm www/docs/properties/wof/temp-content2.html
	rm www/docs/properties/wof/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>wof/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>wof/' www/docs/properties/wof/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>wof/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>wof/' www/docs/properties/wof/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Wof\<\/div\>/' www/docs/properties/wof/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/wof/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/wof/index.html
	rm www/docs/properties/wof/index.html-e
	
docs-properties-brooklynintegers:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/brooklyn_integers.md| pup -i 0 'article.markdown-body h1' > www/docs/properties/brooklynintegers/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/brooklyn_integers.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/properties/brooklynintegers/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/brooklynintegers/temp-content1.html
	cat www/components/head/head-oneleveldown.html www/components/navbar/navbar-oneleveldown.html www/components/subnav/docs/properties/subnav-top-oneleveldown.html www/docs/properties/brooklynintegers/temp-content1.html www/components/subnav/docs/properties/subnav-bottom-oneleveldown.html  www/docs/properties/brooklynintegers/temp-content2.html www/components/footer/footer-oneleveldown.html > www/docs/properties/brooklynintegers/index.html
	rm www/docs/properties/brooklynintegers/temp-content1.html
	rm www/docs/properties/brooklynintegers/temp-content2.html
	rm www/docs/properties/brooklynintegers/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>brooklynintegers/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>brooklynintegers/' www/docs/properties/brooklynintegers/index.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>brooklynintegers/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>src/' www/docs/properties/brooklynintegers/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Properties\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Brooklyn Integers\<\/div\>/' www/docs/properties/brooklynintegers/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/brooklynintegers/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/properties/brooklynintegers/index.html
	rm www/docs/properties/brooklynintegers/index.html-e
	
docs-properties-index:
	cat www/content/docs/properties/properties.html | pup -i 0 'body h1'  > www/docs/properties/temp-content1.html
	cat www/content/docs/properties/properties.html | pup -i 0 'body :not(h1)'  > www/docs/properties/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/properties/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/properties/subnav-top.html www/docs/properties/temp-content1.html www/components/subnav/docs/properties/subnav-bottom.html  www/docs/properties/temp-content2.html www/components/footer/footer.html > www/docs/properties/index.html
	rm www/docs/properties/temp-content1.html
	rm www/docs/properties/temp-content2.html
	rm www/docs/properties/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>properties/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>properties/' www/docs/properties/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>properties/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>properties/' www/docs/properties/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/properties/index.html
	rm www/docs/properties/index.html-e
	
docs-properties: docs-properties-addr docs-properties-edtf docs-properties-geom docs-properties-lbl docs-properties-mz docs-properties-name docs-properties-resto docs-properties-reversegeo docs-properties-src docs-properties-wof docs-properties-brooklynintegers docs-properties-index

docs-concordances:
	cat www/content/docs/concordances/concordances.html | pup -i 0 'body h1' > www/docs/concordances/temp-content1.html
	cat www/content/docs/concordances/concordances.html | pup -i 0 'body :not(h1)' > www/docs/concordances/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/concordances/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/subnav-top.html www/docs/concordances/temp-content1.html www/components/subnav/docs/subnav-bottom.html  www/docs/concordances/temp-content2.html www/components/footer/footer.html > www/docs/concordances/index.html
	rm www/docs/concordances/temp-content1.html
	rm www/docs/concordances/temp-content2.html
	rm www/docs/concordances/temp-content1.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/concordances/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>concordances/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>concordances/' www/docs/concordances/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>concordances/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>concordances/' www/docs/concordances/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Docs\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Concordances\<\/div\>/' www/docs/concordances/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/concordances/index.html
	rm www/docs/concordances/index.html-e
	
docs-placetypes:
	curl -s -o www/images/placetypes-latest.png https://raw.githubusercontent.com/whosonfirst/whosonfirst-placetypes/master/images/placetypes-latest.png
	curl -s https://github.com/whosonfirst/whosonfirst-placetypes/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/docs/placetypes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-placetypes/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/placetypes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/placetypes/temp-content1.html
	sed -i -e 's/\/whosonfirst\/whosonfirst-placetypes\/raw\/master\/images/..\/..\/images/' 	www/docs/placetypes/temp-content2.html
	sed -i -e 's/\/whosonfirst\/whosonfirst\-placetypes\/blob\/master\/images/..\/..\/images/' 	www/docs/placetypes/temp-content2.html 
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/subnav-top.html www/docs/placetypes/temp-content1.html www/components/subnav/docs/subnav-bottom.html  www/docs/placetypes/temp-content2.html www/components/footer/footer.html > www/docs/placetypes/index.html
	rm www/docs/placetypes/temp-content1.html
	rm www/docs/placetypes/temp-content2.html
	rm www/docs/placetypes/temp-content1.html-e
	rm www/docs/placetypes/temp-content2.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/placetypes/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>placetypes/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>placetypes/' www/docs/placetypes/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>placetypes/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>placetypes/' www/docs/placetypes/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Docs\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Placetypes\<\/div\>/' www/docs/placetypes/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/placetypes/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/placetypes/index.html
	rm www/docs/placetypes/index.html-e
	
docs-hierachies-index:
	cat www/content/docs/hierachies/hierachies.html | pup -i 0 'body h1' > www/docs/hierachies/temp-content1.html
	cat www/content/docs/hierachies/hierachies.html | pup -i 0 'body :not(h1)' > www/docs/hierachies/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/hierachies/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/hierachies/subnav-top.html www/docs/hierachies/temp-content1.html www/components/subnav/docs/hierachies/subnav-bottom.html  www/docs/hierachies/temp-content2.html www/components/footer/footer.html > www/docs/hierachies/index.html
	rm www/docs/hierachies/temp-content1.html
	rm www/docs/hierachies/temp-content2.html
	rm www/docs/hierachies/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>hierachies\</whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>hierachies\</' www/docs/hierachies/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>hierachies/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>hierachies/' www/docs/hierachies/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/hierachies/index.html
	rm www/docs/hierachies/index.html-e

docs-hierachies-disputedareas:
	cat www/content/docs/hierachies/disputedareas.html | pup -i 0 'body h1' > www/docs/hierachies/temp-content1.html
	cat www/content/docs/hierachies/disputedareas.html | pup -i 0 'body :not(h1)' > www/docs/hierachies/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/hierachies/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/hierachies/subnav-top.html www/docs/hierachies/temp-content1.html www/components/subnav/docs/hierachies/subnav-bottom.html  www/docs/hierachies/temp-content2.html www/components/footer/footer.html > www/docs/hierachies/disputedareas.html
	rm www/docs/hierachies/temp-content1.html
	rm www/docs/hierachies/temp-content2.html
	rm www/docs/hierachies/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>disputed areas\</whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>disputed areas\</' www/docs/hierachies/disputedareas.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>disputed areas/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>disputed areas/' www/docs/hierachies/disputedareas.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Hierachies\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Disputed Areas\<\/div\>/' www/docs/hierachies/disputedareas.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/hierachies/disputedareas.html
	rm www/docs/hierachies/disputedareas.html-e

docs-hierachies-superseded:
	cat www/content/docs/hierachies/superseded.html | pup -i 0 'body h1' > www/docs/hierachies/temp-content1.html
	cat www/content/docs/hierachies/superseded.html | pup -i 0 'body :not(h1)' > www/docs/hierachies/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/hierachies/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/hierachies/subnav-top.html www/docs/hierachies/temp-content1.html www/components/subnav/docs/hierachies/subnav-bottom.html  www/docs/hierachies/temp-content2.html www/components/footer/footer.html > www/docs/hierachies/superseded.html
	rm www/docs/hierachies/temp-content1.html
	rm www/docs/hierachies/temp-content2.html
	rm www/docs/hierachies/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\-twoliner\"\>supersedes/\whosonfirst\-sidenav\-link\-twoliner whosonfirst\-nav\-active\"\>supersedes/' www/docs/hierachies/superseded.html
	sed -i -e 's/whosonfirst\-smallnav\-link\-twoliner\"\>supersedes/whosonfirst\-smallnav\-link\-twoliner whosonfirst-nav-active\"\>supersedes/' www/docs/hierachies/superseded.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Hierachies\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Supersedes \/ Superseded By\<\/div\>/' www/docs/hierachies/superseded.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/hierachies/superseded.html
	rm www/docs/hierachies/superseded.html-e
	
docs-hierachies: docs-hierachies-index docs-hierachies-disputedareas docs-hierachies-superseded

docs-names:
	curl -s https://github.com/whosonfirst/whosonfirst-names/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/docs/names/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-names/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/names/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/names/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/subnav-top.html www/docs/names/temp-content1.html www/components/subnav/docs/subnav-bottom.html  www/docs/names/temp-content2.html www/components/footer/footer.html > www/docs/names/index.html
	rm www/docs/names/temp-content1.html
	rm www/docs/names/temp-content2.html
	rm www/docs/names/temp-content1.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/names/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>names/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>names/' www/docs/names/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>names/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>names/' www/docs/names/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Docs\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Names\<\/div\>/' www/docs/names/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/names/index.html
	rm www/docs/names/index.html-e
	
docs-geometries-index:
	curl -s https://github.com/whosonfirst/whosonfirst-geometries | pup -i 0 'article.markdown-body h1' > www/docs/geometries/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-geometries | pup -i 0 'article.markdown-body :not(h1)' > www/docs/geometries/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/geometries/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/geometries/subnav-top.html www/docs/geometries/temp-content1.html www/components/subnav/docs/geometries/subnav-bottom.html  www/docs/geometries/temp-content2.html www/components/footer/footer.html > www/docs/geometries/index.html
	rm www/docs/geometries/temp-content1.html
	rm www/docs/geometries/temp-content2.html
	rm www/docs/geometries/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>geometries\</whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>geometries\</' www/docs/geometries/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>geometries/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>geometries/' www/docs/geometries/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/geometries/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/geometries/index.html
	rm www/docs/geometries/index.html-e
	
docs-geometries-altgeometries:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/creating_alt_geometries.md | pup -i 0 'article.markdown-body h1' > www/docs/geometries/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/creating_alt_geometries.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/geometries/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/geometries/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/geometries/subnav-top.html www/docs/geometries/temp-content1.html www/components/subnav/docs/geometries/subnav-bottom.html  www/docs/geometries/temp-content2.html www/components/footer/footer.html > www/docs/geometries/altgeometries.html
	rm www/docs/geometries/temp-content1.html
	rm www/docs/geometries/temp-content2.html
	rm www/docs/geometries/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>creating/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>creating/' www/docs/geometries/altgeometries.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>creating/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>creating/' www/docs/geometries/altgeometries.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Geometries\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Creating Alt Geometries\<\/div\>/' www/docs/geometries/altgeometries.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/geometries/altgeometries.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/geometries/altgeometries.html
	rm www/docs/geometries/altgeometries.html-e
	
docs-geometries: docs-geometries-index docs-geometries-altgeometries

docs-dates:
	curl -s https://github.com/whosonfirst/whosonfirst-dates | pup -i 0 'article.markdown-body h1' > www/docs/dates/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-dates | pup -i 0 'article.markdown-body :not(h1)' > www/docs/dates/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/dates/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/subnav-top.html www/docs/dates/temp-content1.html www/components/subnav/docs/subnav-bottom.html  www/docs/dates/temp-content2.html www/components/footer/footer.html > www/docs/dates/index.html
	rm www/docs/dates/temp-content1.html
	rm www/docs/dates/temp-content2.html
	rm www/docs/dates/temp-content1.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/dates/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>dates/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>dates/' www/docs/dates/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>dates/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>dates/' www/docs/dates/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Docs\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Dates\<\/div\>/' www/docs/dates/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/dates/index.html
	rm www/docs/dates/index.html-e
	
docs-categories:
	curl -s -o www/images/chicken.jpg https://raw.githubusercontent.com/whosonfirst/whosonfirst-categories/master/chicken.jpg
	curl -s https://github.com/whosonfirst/whosonfirst-categories/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/docs/categories/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-categories/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/categories/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/categories/temp-content1.html
	sed -i -e 's/\/whosonfirst\/whosonfirst\-categories\/blob\/master/..\/..\/images/' 	www/docs/categories/temp-content2.html 
	sed -i -e 's/\/whosonfirst\/whosonfirst\-categories\/raw\/master/..\/..\/images/' 	www/docs/categories/temp-content2.html 
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/subnav-top.html www/docs/categories/temp-content1.html www/components/subnav/docs/subnav-bottom.html  www/docs/categories/temp-content2.html www/components/footer/footer.html > www/docs/categories/index.html
	rm www/docs/categories/temp-content1.html
	rm www/docs/categories/temp-content2.html
	rm www/docs/categories/temp-content1.html-e
	rm www/docs/categories/temp-content2.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/categories/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>categories/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>categories/' www/docs/categories/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>categories/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>categories/' www/docs/categories/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Docs\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Categories\<\/div\>/' www/docs/categories/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/categories/index.html
	rm www/docs/categories/index.html-e
	
docs-sources-index:
	curl -s https://github.com/whosonfirst/whosonfirst-sources | pup -i 0 'article.markdown-body h1' > www/docs/sources/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-sources | pup -i 0 'article.markdown-body :not(h1)' > www/docs/sources/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/sources/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/sources/subnav-top.html www/docs/sources/temp-content1.html www/components/subnav/docs/sources/subnav-bottom.html  www/docs/sources/temp-content2.html www/components/footer/footer.html > www/docs/sources/index.html
	rm www/docs/sources/temp-content1.html
	rm www/docs/sources/temp-content2.html
	rm www/docs/sources/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>sources\</whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>sources\</' www/docs/sources/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>sources/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>sources/' www/docs/sources/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/sources/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/sources/index.html
	rm www/docs/sources/index.html-e
	
	
docs-sources-source-list:
	curl -s https://github.com/whosonfirst/whosonfirst-sources/blob/master/sources/README.md | pup -i 0 'article.markdown-body h1' > www/docs/sources/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-sources/blob/master/sources/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/sources/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/sources/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/sources/subnav-top.html www/docs/sources/temp-content1.html www/components/subnav/docs/sources/subnav-bottom.html  www/docs/sources/temp-content2.html www/components/footer/footer.html > www/docs/sources/listofsources.html
	rm www/docs/sources/temp-content1.html
	rm www/docs/sources/temp-content2.html
	rm www/docs/sources/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>list/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>list/' www/docs/sources/listofsources.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>list/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>list/' www/docs/sources/listofsources.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Sources\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>List of Sources\<\/div\>/' www/docs/sources/listofsources.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/sources/listofsources.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/sources/listofsources.html
	rm www/docs/sources/listofsources.html-e
	
docs-sources: docs-sources-index docs-sources-source-list

docs-tests:
	curl -s https://github.com/whosonfirst/whosonfirst-tests/blob/master/README.md | pup -i 0 'article.markdown-body h1' > www/docs/tests/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-tests/blob/master/README.md | pup -i 0 'article.markdown-body :not(h1)' > www/docs/tests/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/tests/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/subnav-top.html www/docs/tests/temp-content1.html www/components/subnav/docs/subnav-bottom.html  www/docs/tests/temp-content2.html www/components/footer/footer.html > www/docs/tests/index.html
	rm www/docs/tests/temp-content1.html
	rm www/docs/tests/temp-content2.html
	rm www/docs/tests/temp-content1.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/tests/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>tests/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>tests/' www/docs/tests/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>tests/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>tests/' www/docs/tests/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Docs\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Tests\<\/div\>/' www/docs/tests/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/tests/index.html
	rm www/docs/tests/index.html-e
	
docs-contributing:
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/CONTRIBUTING.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/contributing/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-properties/blob/master/CONTRIBUTING.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/contributing/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/contributing/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/subnav-top.html www/docs/contributing/temp-content1.html www/components/subnav/docs/subnav-bottom.html  www/docs/contributing/temp-content2.html www/components/footer/footer.html > www/docs/contributing/index.html
	rm www/docs/contributing/temp-content1.html
	rm www/docs/contributing/temp-content2.html
	rm www/docs/contributing/temp-content1.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/contributing/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>contributing/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>contributing/' www/docs/contributing/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>contributing/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>contributing/' www/docs/contributing/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Docs\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Contributing\<\/div\>/' www/docs/contributing/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/contributing/index.html
	rm www/docs/contributing/index.html-e
	
docs-licensing-datalicenses:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/data_licenses.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/licensing/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/data_licenses.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/licensing/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/licensing/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/licensing/subnav-top.html www/docs/licensing/temp-content1.html www/components/subnav/docs/licensing/subnav-bottom.html  www/docs/licensing/temp-content2.html www/components/footer/footer.html > www/docs/licensing/datalicenses.html
	rm www/docs/licensing/temp-content1.html
	rm www/docs/licensing/temp-content2.html
	rm www/docs/licensing/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\-twoliner\"\>acceptable/whosonfirst\-sidenav\-link\-twoliner whosonfirst\-nav\-active\"\>acceptable/' www/docs/licensing/datalicenses.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>acceptable/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>acceptable/' www/docs/licensing/datalicenses.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Licensing\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Acceptable Data Licenses\<\/div\>/' www/docs/licensing/datalicenses.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/licensing/datalicenses.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/licensing/datalicenses.html
	rm www/docs/licensing/datalicenses.html-e
	
docs-licensing-index:
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/LICENSE.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/licensing/temp-content1.html
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/LICENSE.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/licensing/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/licensing/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/licensing/subnav-top.html www/docs/licensing/temp-content1.html www/components/subnav/docs/licensing/subnav-bottom.html  www/docs/licensing/temp-content2.html www/components/footer/footer.html > www/docs/licensing/index.html
	rm www/docs/licensing/temp-content1.html
	rm www/docs/licensing/temp-content2.html
	rm www/docs/licensing/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>licensing\</whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>licensing\</' www/docs/licensing/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>licensing/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>licensing/' www/docs/licensing/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/licensing/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/licensing/index.html
	rm www/docs/licensing/index.html-e

docs-licensing: docs-licensing-index docs-licensing-datalicenses
	
docs-keyterms:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/key_terms.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/keyterms/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/key_terms.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/keyterms/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/keyterms/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/subnav-top.html www/docs/keyterms/temp-content1.html www/components/subnav/docs/subnav-bottom.html  www/docs/keyterms/temp-content2.html www/components/footer/footer.html > www/docs/keyterms/index.html
	rm www/docs/keyterms/temp-content1.html
	rm www/docs/keyterms/temp-content2.html
	rm www/docs/keyterms/temp-content1.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/keyterms/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>key/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>key/' www/docs/keyterms/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\-last\"\>key/whosonfirst\-extrasmall\-nav\-link\-collapsed\-last whosonfirst\-nav\-active\"\>key/' www/docs/keyterms/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Docs\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Key Terms\<\/div\>/' www/docs/keyterms/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/keyterms/index.html
	rm www/docs/keyterms/index.html-e
	
docs-processes-index:
	cat www/content/docs/processes/processes.html | pup -i 0 'body h1'  > www/docs/processes/temp-content1.html
	cat www/content/docs/processes/processes.html | pup -i 0 'body :not(h1)'  > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/processes/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html www/components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html www/components/footer/footer.html > www/docs/processes/index.html
	rm www/docs/processes/temp-content1.html
	rm www/docs/processes/temp-content2.html
	rm www/docs/processes/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>processes/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>processes/' www/docs/processes/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>processes/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>processes/' www/docs/processes/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/processes/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/processes/index.html
	rm www/docs/processes/index.html-e
	
docs-processes-significantevent:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/significant_event.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/significant_event.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/processes/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html www/components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html www/components/footer/footer.html > www/docs/processes/significantevent.html
	rm www/docs/processes/temp-content1.html
	rm www/docs/processes/temp-content2.html
	rm www/docs/processes/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\-twoliner\"\>what is a/whosonfirst\-sidenav\-link\-twoliner whosonfirst\-nav\-active\"\>what is a/' www/docs/processes/significantevent.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>what is a/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>what is a/' www/docs/processes/significantevent.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Processes and Workflows\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>What is a Significant Event\<\/div\>/' www/docs/processes/significantevent.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/processes/significantevent.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/processes/significantevent.html
	rm www/docs/processes/significantevent.html-e
	
docs-processes-assigningcessation:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/deprecated_vs_cessation.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/deprecated_vs_cessation.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/processes/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html www/components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html www/components/footer/footer.html > www/docs/processes/assigningcessation.html
	rm www/docs/processes/temp-content1.html
	rm www/docs/processes/temp-content2.html
	rm www/docs/processes/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\-twoliner\"\>assigning/whosonfirst\-sidenav\-link\-twoliner whosonfirst\-nav\-active\"\>assigning/' www/docs/processes/assigningcessation.html
	sed -i -e 's/whosonfirst\-smallnav\-link\-twoliner\"\>assigning/whosonfirst\-smallnav\-link\-twoliner whosonfirst\-nav\-active\"\>assigning/' www/docs/processes/assigningcessation.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Processes and Workflows\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Assigning Cessation and Deprecated Dates\<\/div\>/' www/docs/processes/assigningcessation.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/processes/assigningcessation.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/processes/assigningcessation.html
	rm www/docs/processes/assigningcessation.html-e
	
docs-processes-s3requirements:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/requirements_for_s3.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/requirements_for_s3.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/processes/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html www/components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html www/components/footer/footer.html > www/docs/processes/s3requirements.html
	rm www/docs/processes/temp-content1.html
	rm www/docs/processes/temp-content2.html
	rm www/docs/processes/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\-twoliner\"\>what is required/whosonfirst\-sidenav\-link\-twoliner whosonfirst\-nav\-active\"\>what is required/' www/docs/processes/s3requirements.html
	sed -i -e 's/whosonfirst\-smallnav\-link\-twoliner"\>what is required/whosonfirst\-smallnav\-link\-twoliner whosonfirst\-nav\-active\"\>what is required/' www/docs/processes/s3requirements.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Processes and Workflows\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>What is Required for S3 Import Files\<\/div\>/' www/docs/processes/s3requirements.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/processes/s3requirements.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/processes/s3requirements.html
	rm www/docs/processes/s3requirements.html-e
		
docs-processes-wikipediaconcordances:
	cat www/content/docs/processes/wikipediaconcordances.html | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	cat www/content/docs/processes/wikipediaconcordances.html | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/processes/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html www/components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html www/components/footer/footer.html > www/docs/processes/wikipediaconcordances.html
	rm www/docs/processes/temp-content1.html
	rm www/docs/processes/temp-content2.html
	rm www/docs/processes/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\-twoliner\"\>wikipedia/whosonfirst\-sidenav\-link\-twoliner whosonfirst\-nav\-active\"\>wikipedia/' www/docs/processes/wikipediaconcordances.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>wikipedia/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>wikipedia/' www/docs/processes/wikipediaconcordances.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Processes and Workflows\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Wikipedia Concordances\<\/div\>/' www/docs/processes/wikipediaconcordances.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/processes/wikipediaconcordances.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/processes/wikipediaconcordances.html
	rm www/docs/processes/wikipediaconcordances.html-e
	
docs-processes-seattleneighborhoodupdates:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/seattle_neighbourhood_updates.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/seattle_neighbourhood_updates.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/processes/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html www/components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html www/components/footer/footer.html > www/docs/processes/seattleneighborhoodupdates.html
	rm www/docs/processes/temp-content1.html
	rm www/docs/processes/temp-content2.html
	rm www/docs/processes/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\-twoliner\"\>seattle/whosonfirst\-sidenav\-link\-twoliner whosonfirst\-nav\-active\"\>seattle/' www/docs/processes/seattleneighborhoodupdates.html
	sed -i -e 's/whosonfirst\-smallnav\-link\-twoliner\"\>seattle/whosonfirst\-smallnav\-link\-twoliner whosonfirst\-nav\-active\"\>seattle/' www/docs/processes/seattleneighborhoodupdates.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Processes and Workflows\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Seattle Neighborhood Updates\<\/div\>/' www/docs/processes/seattleneighborhoodupdates.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/processes/seattleneighborhoodupdates.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/processes/updatingsanfrancisconeighborhoods.html
	rm www/docs/processes/seattleneighborhoodupdates.html-e
	
docs-processes-updatingsanfrancisconeighborhoods:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_2.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content3.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/processes/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html www/components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html www/docs/processes/temp-content3.html www/components/footer/footer.html > www/docs/processes/updatingsanfrancisconeighborhoods.html
	rm www/docs/processes/temp-content1.html
	rm www/docs/processes/temp-content2.html
	rm www/docs/processes/temp-content3.html
	rm www/docs/processes/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\-twoliner\"\>san/whosonfirst\-sidenav\-link\-twoliner whosonfirst\-nav\-active\"\>san/' www/docs/processes/updatingsanfrancisconeighborhoods.html
	sed -i -e 's/whosonfirst\-smallnav\-link\-twoliner\"\>san/whosonfirst\-smallnav\-link\-twoliner whosonfirst\-nav\-active\"\>san/' www/docs/processes/updatingsanfrancisconeighborhoods.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Processes and Workflows\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>San Francisco Neighborhood Updates\<\/div\>/' www/docs/processes/updatingsanfrancisconeighborhoods.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/processes/updatingsanfrancisconeighborhoods.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/processes/updatingsanfrancisconeighborhoods.html
	rm www/docs/processes/updatingsanfrancisconeighborhoods.html-e

	
docs-processes-woflifecycle:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/wof:id_lifecycle.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/wof:id_lifecycle.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/processes/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html www/components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html www/components/footer/footer.html > www/docs/processes/woflifecycle.html
	rm www/docs/processes/temp-content1.html
	rm www/docs/processes/temp-content2.html
	rm www/docs/processes/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>wof/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>wof/' www/docs/processes/woflifecycle.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>wof/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>wof/' www/docs/processes/woflifecycle.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Processes and Workflows\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>WOF Lifecycle\<\/div\>/' www/docs/processes/woflifecycle.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/processes/woflifecycle.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/processes/woflifecycle.html
	rm www/docs/processes/woflifecycle.html-e
	
docs-processes: docs-processes-significantevent docs-processes-assigningcessation docs-processes-s3requirements docs-processes-wikipediaconcordances docs-processes-seattleneighborhoodupdates docs-processes-updatingsanfrancisconeighborhoods docs-processes-woflifecycle docs-processes-index

docs-index:
	cat www/content/docs/docs.html | pup -i 0 'body h1'  > www/docs/temp-content1.html
	cat www/content/docs/docs.html | pup -i 0 'body :not(h1)'  > www/docs/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/docs/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/docs/subnav-top-onelevelup.html www/docs/temp-content1.html www/components/subnav/docs/subnav-bottom-onelevelup.html  www/docs/temp-content2.html www/components/footer/footer-onelevelup.html > www/docs/index.html
	rm www/docs/temp-content1.html
	rm www/docs/temp-content2.html
	rm www/docs/temp-content1.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/index.html
	rm www/docs/index.html-e

docs: docs-processes docs-keyterms docs-licensing docs-contributing docs-tests docs-sources docs-categories docs-dates docs-geometries docs-names docs-hierachies docs-placetypes docs-concordances docs-properties docs-index

data-pullrequest:
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/PULL_REQUEST_TEMPLATE_NEIGHBOURHOOD.md | pup -i 0 'article.markdown-body h1:first-of-type' > www/allthedata/pullrequest/temp-content1.html
	curl -s https://github.com/whosonfirst-data/whosonfirst-data/blob/master/PULL_REQUEST_TEMPLATE_NEIGHBOURHOOD.md | pup -i 0 'article.markdown-body :not(h1:first-of-type)' > www/allthedata/pullrequest/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/pullrequest/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/subnav-top.html www/allthedata/pullrequest/temp-content1.html www/components/subnav/data/subnav-bottom.html  www/allthedata/pullrequest/temp-content2.html www/components/footer/footer.html > www/allthedata/pullrequest/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/pullrequest/index.html
	rm www/allthedata/pullrequest/temp-content1.html
	rm www/allthedata/pullrequest/temp-content2.html
	rm www/allthedata/pullrequest/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>pull/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>pull/' www/allthedata/pullrequest/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\-last\"\>pull/whosonfirst\-extrasmall\-nav\-link\-collapsed\-last whosonfirst\-nav\-active\"\>pull/' www/allthedata/pullrequest/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Data\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Pull Request Template\<\/div\>/' www/allthedata/pullrequest/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/allthedata/pullrequest/index.html
	rm www/allthedata/pullrequest/index.html-e
	
data-principles:
	cat www/content/data/principles/principles.html | pup -i 0 'body h1' > www/allthedata/principles/temp-content1.html
	cat www/content/data/principles/principles.html | pup -i 0 'body :not(h1)' > www/allthedata/principles/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/principles/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/subnav-top.html www/allthedata/principles/temp-content1.html www/components/subnav/data/subnav-bottom.html  www/allthedata/principles/temp-content2.html www/components/footer/footer.html > www/allthedata/principles/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/principles/index.html
	rm www/allthedata/principles/temp-content1.html
	rm www/allthedata/principles/temp-content2.html
	rm www/allthedata/principles/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>data/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>data/' www/allthedata/principles/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>data/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data/' www/allthedata/principles/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Data\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Data Principles\<\/div\>/' www/allthedata/principles/index.html
	rm www/allthedata/principles/index.html-e
	
data-home:
	cat www/content/data/data.html | pup -i 0 'body h1' > www/allthedata/temp-content1.html
	cat www/content/data/data.html | pup -i 0 'body :not(h1)' > www/allthedata/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/data/subnav-top-onelevelup.html www/allthedata/temp-content1.html www/components/subnav/data/subnav-bottom-onelevelup.html  www/allthedata/temp-content2.html www/components/footer/footer-onelevelup.html > www/allthedata/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/index.html
	rm www/allthedata/temp-content1.html
	rm www/allthedata/temp-content2.html
	rm www/allthedata/temp-content1.html-e
	rm www/allthedata/index.html-e
	
data-home-two:
	cat www/content/data/data.html | pup -i 0 'body h1' > www/allthedata/temp-content1.html
	cat www/content/data/data.html | pup -i 0 'body :not(h1)' > www/allthedata/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/data/subnav-top-onelevelup.html www/allthedata/temp-content1.html www/components/subnav/data/subnav-bottom-onelevelup.html  www/allthedata/temp-content2.html www/components/footer/footer-onelevelup.html > www/all-the-data.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/all-the-data.html
	rm www/allthedata/temp-content1.html
	rm www/allthedata/temp-content2.html
	rm www/allthedata/temp-content1.html-e
	rm www/all-the-data.html-e
	
data-available-index:
	cat www/content/data/available/available.html | pup -i 0 'body h1' > www/allthedata/available/temp-content1.html
	cat www/content/data/available/available.html | pup -i 0 'body :not(h1)' > www/allthedata/available/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/available/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/available/subnav-top.html www/allthedata/available/temp-content1.html www/components/subnav/data/available/subnav-bottom.html  www/allthedata/available/temp-content2.html www/components/footer/footer.html > www/allthedata/available/index.html
	rm www/allthedata/available/temp-content1.html
	rm www/allthedata/available/temp-content2.html
	rm www/allthedata/available/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>available/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>available/' www/allthedata/available/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>available/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>available/' www/allthedata/available/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/available/index.html
	rm www/allthedata/available/index.html-e
	
data-available-administrative:
	cat www/content/data/available/administrative.html | pup -i 0 'body h1' > www/allthedata/available/temp-content1.html
	cat www/content/data/available/administrative.html | pup -i 0 'body :not(h1)' > www/allthedata/available/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/available/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/available/subnav-top.html www/allthedata/available/temp-content1.html www/components/subnav/data/available/subnav-bottom.html  www/allthedata/available/temp-content2.html www/components/footer/footer.html > www/allthedata/available/administrative.html
	rm www/allthedata/available/temp-content1.html
	rm www/allthedata/available/temp-content2.html
	rm www/allthedata/available/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>administrative/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>administrative/' www/allthedata/available/administrative.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>administrative/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>administrative/' www/allthedata/available/administrative.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Available Data\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Administrative Data\<\/div\>/' www/allthedata/available/administrative.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/available/administrative.html
	rm www/allthedata/available/administrative.html-e
	
data-available-venue:
	cat www/content/data/available/venue.html | pup -i 0 'body h1' > www/allthedata/available/temp-content1.html
	cat www/content/data/available/venue.html | pup -i 0 'body :not(h1)' > www/allthedata/available/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/available/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/available/subnav-top.html www/allthedata/available/temp-content1.html www/components/subnav/data/available/subnav-bottom.html  www/allthedata/available/temp-content2.html www/components/footer/footer.html > www/allthedata/available/venue.html
	rm www/allthedata/available/temp-content1.html
	rm www/allthedata/available/temp-content2.html
	rm www/allthedata/available/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>venue/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>venue/' www/allthedata/available/venue.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>venue/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>venue/' www/allthedata/available/venue.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Available Data\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Venue Data\<\/div\>/' www/allthedata/available/venue.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/available/venue.html
	rm www/allthedata/available/venue.html-e
	
data-available-other:
	cat www/content/data/available/other.html | pup -i 0 'body h1' > www/allthedata/available/temp-content1.html
	cat www/content/data/available/other.html | pup -i 0 'body :not(h1)' > www/allthedata/available/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/available/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/available/subnav-top.html www/allthedata/available/temp-content1.html www/components/subnav/data/available/subnav-bottom.html  www/allthedata/available/temp-content2.html www/components/footer/footer.html > www/allthedata/available/other.html
	rm www/allthedata/available/temp-content1.html
	rm www/allthedata/available/temp-content2.html
	rm www/allthedata/available/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>other/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>other/' www/allthedata/available/other.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>other/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>other/' www/allthedata/available/other.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Available Data\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Other Data\<\/div\>/' www/allthedata/available/other.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/available/other.html
	rm www/allthedata/available/other.html-e
	
data-available: data-available-index data-available-administrative data-available-venue data-available-other

data-amazon:
	cat www/content/data/amazon/amazon.html | pup -i 0 'body h1' > www/allthedata/amazon/temp-content1.html
	cat www/content/data/amazon/amazon.html | pup -i 0 'body :not(h1)' > www/allthedata/amazon/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/amazon/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/subnav-top.html www/allthedata/amazon/temp-content1.html www/components/subnav/data/subnav-bottom.html  www/allthedata/amazon/temp-content2.html www/components/footer/footer.html > www/allthedata/amazon/index.html
	rm www/allthedata/amazon/temp-content1.html
	rm www/allthedata/amazon/temp-content2.html
	rm www/allthedata/amazon/temp-content1.html-e
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/amazon/index.html
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>amazon/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>amazon/' www/allthedata/amazon/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>amazon/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>amazon/' www/allthedata/amazon/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Data\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Amazon S3\<\/div\>/' www/allthedata/amazon/index.html
	rm www/allthedata/amazon/index.html-e
	
data-github-index:
	cat www/content/data/github/github.html | pup -i 0 'body h1' > www/allthedata/github/temp-content1.html
	cat www/content/data/github/github.html | pup -i 0 'body :not(h1)' > www/allthedata/github/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/github/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/github/subnav-top.html www/allthedata/github/temp-content1.html www/components/subnav/data/github/subnav-bottom.html  www/allthedata/github/temp-content2.html www/components/footer/footer.html > www/allthedata/github/index.html
	rm www/allthedata/github/temp-content1.html
	rm www/allthedata/github/temp-content2.html
	rm www/allthedata/github/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>github\</whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>github\</' www/allthedata/github/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>github/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>github/' www/allthedata/github/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/github/index.html
	rm www/allthedata/github/index.html-e
	
data-github-largefiles:
	cat www/content/data/github/gitlargefiles.html | pup -i 0 'body h1' > www/allthedata/github/temp-content1.html
	cat www/content/data/github/gitlargefiles.html | pup -i 0 'body :not(h1)' > www/allthedata/github/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/github/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/github/subnav-top.html www/allthedata/github/temp-content1.html www/components/subnav/data/github/subnav-bottom.html  www/allthedata/github/temp-content2.html www/components/footer/footer.html > www/allthedata/github/gitlargefiles.html
	rm www/allthedata/github/temp-content1.html
	rm www/allthedata/github/temp-content2.html
	rm www/allthedata/github/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>git and/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>git and/' www/allthedata/github/gitlargefiles.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>git and/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>git and/' www/allthedata/github/gitlargefiles.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Github\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Git and Large Files\<\/div\>/' www/allthedata/github/gitlargefiles.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/github/gitlargefiles.html
	rm www/allthedata/github/gitlargefiles.html-e
	
data-github-reponaming:
	cat www/content/data/github/reponaming.html | pup -i 0 'body h1' > www/allthedata/github/temp-content1.html
	cat www/content/data/github/reponaming.html | pup -i 0 'body :not(h1)' > www/allthedata/github/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/github/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/github/subnav-top.html www/allthedata/github/temp-content1.html www/components/subnav/data/github/subnav-bottom.html  www/allthedata/github/temp-content2.html www/components/footer/footer.html > www/allthedata/github/reponaming.html
	rm www/allthedata/github/temp-content1.html
	rm www/allthedata/github/temp-content2.html
	rm www/allthedata/github/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\-twoliner\"\>repo/whosonfirst\-sidenav\-link\-twoliner whosonfirst\-nav\-active\"\>repo/' www/allthedata/github/reponaming.html
	sed -i -e 's/whosonfirst\-subnav\-secondlevel\"\>repo/whosonfirst\-subnav\-secondlevel whosonfirst\-nav\-active\"\>repo/' www/allthedata/github/reponaming.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Github\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Repo Naming Conventions\<\/div\>/' www/allthedata/github/reponaming.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/github/reponaming.html
	rm www/allthedata/github/reponaming.html-e
	
data-github: data-github-index data-github-largefiles data-github-reponaming

data-knownknowns:
	cat www/content/data/knownknowns/knownknowns.html | pup -i 0 'body h1' > www/allthedata/knownknowns/temp-content1.html
	cat www/content/data/knownknowns/knownknowns.html | pup -i 0 'body :not(h1)' > www/allthedata/knownknowns/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/allthedata/knownknowns/temp-content1.html
	cat www/components/head/head.html www/components/navbar/navbar.html www/components/subnav/data/subnav-top.html www/allthedata/knownknowns/temp-content1.html www/components/subnav/data/subnav-bottom.html  www/allthedata/knownknowns/temp-content2.html www/components/footer/footer.html > www/allthedata/knownknowns/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>data\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>data\<\/a\>/' www/allthedata/knownknowns/index.html
	rm www/allthedata/knownknowns/temp-content1.html
	rm www/allthedata/knownknowns/temp-content2.html
	rm www/allthedata/knownknowns/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>known/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>known/' www/allthedata/knownknowns/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>known/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>known/' www/allthedata/knownknowns/index.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Data\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Known Knowns\<\/div\>/' www/allthedata/knownknowns/index.html
	rm www/allthedata/knownknowns/index.html-e
	
data: data-pullrequest data-principles data-available data-amazon data-github data-knownknowns data-home data-home-two

blog-withalltheblogfolder:
	cat www/content/blog/blog.html | pup -i 0 'body h1' > www/alltheblog/temp-content1.html
	cat www/content/blog/blog.html | pup -i 0 'body :not(h1)' > www/alltheblog/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/alltheblog/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/blog/subnav-top.html www/alltheblog/temp-content1.html www/components/subnav/blog/subnav-bottom.html  www/alltheblog/temp-content2.html www/components/footer/footer-onelevelup.html > www/alltheblog/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>blog\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>blog\<\/a\>/' www/alltheblog/index.html
	rm www/alltheblog/temp-content1.html
	rm www/alltheblog/temp-content2.html
	rm www/alltheblog/temp-content1.html-e
	rm www/alltheblog/index.html-e
	
blog:
	cat www/content/blog/blog.html | pup -i 0 'body h1' > www/blog/temp-content1.html
	cat www/content/blog/blog.html | pup -i 0 'body :not(h1)' > www/blog/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/blog/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/blog/subnav-top.html www/blog/temp-content1.html www/components/subnav/blog/subnav-bottom.html  www/blog/temp-content2.html www/components/footer/footer-onelevelup.html > www/blog/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>blog\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>blog\<\/a\>/' www/blog/index.html
	rm www/blog/temp-content1.html
	rm www/blog/temp-content2.html
	rm www/blog/temp-content1.html-e
	rm www/blog/index.html-e
	
tools-index:
	cat www/content/tools/tools.html | pup -i 0 'body h1' > www/tools/temp-content1.html
	cat www/content/tools/tools.html | pup -i 0 'body :not(h1)' > www/tools/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/tools/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/tools/subnav-top.html www/tools/temp-content1.html www/components/subnav/tools/subnav-bottom.html  www/tools/temp-content2.html www/components/footer/footer-onelevelup.html > www/tools/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>tools\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>tools\<\/a\>/' www/tools/index.html
	rm www/tools/temp-content1.html
	rm www/tools/temp-content2.html
	rm www/tools/temp-content1.html-e
	rm www/tools/index.html-e
	
tools-availabletools:
	cat www/content/tools/availabletools.html | pup -i 0 'body h1' > www/tools/temp-content1.html
	cat www/content/tools/availabletools.html | pup -i 0 'body :not(h1)' > www/tools/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/tools/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/tools/subnav-top.html www/tools/temp-content1.html www/components/subnav/tools/subnav-bottom.html  www/tools/temp-content2.html www/components/footer/footer-onelevelup.html > www/tools/availabletools.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>tools\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>tools\<\/a\>/' www/tools/availabletools.html
	rm www/tools/temp-content1.html
	rm www/tools/temp-content2.html
	rm www/tools/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>available/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>available/' www/tools/availabletools.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\-last\"\>available/whosonfirst\-extrasmall\-nav\-link\-collapsed\-last whosonfirst\-nav\-active\"\>available/' www/tools/availabletools.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Tools\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Available Tools\<\/div\>/' www/tools/availabletools.html
	rm www/tools/availabletools.html-e
	
tools: tools-index tools-availabletools

state:
	cat www/content/state/state.html | pup -i 0 'body h1' > www/state/temp-content1.html
	cat www/content/state/state.html | pup -i 0 'body :not(h1)' > www/state/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/state/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/state/subnav-top.html www/state/temp-content1.html www/components/subnav/state/subnav-bottom.html  www/state/temp-content2.html www/components/footer/footer-onelevelup.html > www/state/index.html
	rm www/state/temp-content1.html
	rm www/state/temp-content2.html
	rm www/state/temp-content1.html-e
	
getstarted-index:
	cat www/content/getstarted/getstarted.html | pup -i 0 'body h1' > www/getstarted/temp-content1.html
	cat www/content/getstarted/getstarted.html | pup -i 0 'body :not(h1)' > www/getstarted/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/getstarted/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/getstarted/subnav-top.html www/getstarted/temp-content1.html www/components/subnav/getstarted/subnav-bottom.html  www/getstarted/temp-content2.html www/components/footer/footer-onelevelup.html > www/getstarted/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>get started\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>get started\<\/a\>/' www/getstarted/index.html
	rm www/getstarted/temp-content1.html
	rm www/getstarted/temp-content2.html
	rm www/getstarted/temp-content1.html-e
	rm www/getstarted/index.html-e
	
getstarted-retrievevenues:
	cat www/content/getstarted/retrievevenues.html | pup -i 0 'body h1' > www/getstarted/temp-content1.html
	cat www/content/getstarted/retrievevenues.html | pup -i 0 'body :not(h1)' > www/getstarted/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/getstarted/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/getstarted/subnav-top.html www/getstarted/temp-content1.html www/components/subnav/getstarted/subnav-bottom.html  www/getstarted/temp-content2.html www/components/footer/footer-onelevelup.html > www/getstarted/retrievevenues.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>get started\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>get started\<\/a\>/' www/getstarted/retrievevenues.html
	rm www/getstarted/temp-content1.html
	rm www/getstarted/temp-content2.html
	rm www/getstarted/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>retrieve v/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>retrieve v/' www/getstarted/retrievevenues.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>retrieve v/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>retrieve v/' www/getstarted/retrievevenues.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Get Started\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Retrieve Venues\<\/div\>/' www/getstarted/retrievevenues.html
	rm www/getstarted/retrievevenues.html-e
	
getstarted-retrieveneighbourhoods:
	cat www/content/getstarted/retrieveneighbourhoods.html | pup -i 0 'body h1' > www/getstarted/temp-content1.html
	cat www/content/getstarted/retrieveneighbourhoods.html | pup -i 0 'body :not(h1)' > www/getstarted/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/getstarted/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/getstarted/subnav-top.html www/getstarted/temp-content1.html www/components/subnav/getstarted/subnav-bottom.html  www/getstarted/temp-content2.html www/components/footer/footer-onelevelup.html > www/getstarted/retrieveneighbourhoods.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>get started\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>get started\<\/a\>/' www/getstarted/retrieveneighbourhoods.html
	rm www/getstarted/temp-content1.html
	rm www/getstarted/temp-content2.html
	rm www/getstarted/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>retrieve n/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>retrieve n/' www/getstarted/retrieveneighbourhoods.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed-last\"\>retrieve n/whosonfirst\-extrasmall\-nav\-link\-collapsed-last whosonfirst\-nav\-active\"\>retrieve n/' www/getstarted/retrieveneighbourhoods.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Get Started\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Retrieve Neighbourhoods\<\/div\>/' www/getstarted/retrieveneighbourhoods.html
	rm www/getstarted/retrieveneighbourhoods.html-e
	
getstarted: getstarted-index getstarted-retrievevenues getstarted-retrieveneighbourhoods

interns:
	cat www/content/interns/interns.html | pup -i 0 'body h1' > www/interns/temp-content1.html
	cat www/content/interns/interns.html | pup -i 0 'body :not(h1)' > www/interns/temp-content2.html
	sed -i -e 's/\<h1\>/\<h1 class\=\"whosonfirst\-subpage\-header\"\>/' www/interns/temp-content1.html
	cat www/components/head/head-onelevelup.html www/components/navbar/navbar-onelevelup.html www/components/subnav/interns/subnav-top.html www/interns/temp-content1.html www/components/subnav/interns/subnav-bottom.html  www/interns/temp-content2.html www/components/footer/footer-onelevelup.html > www/interns/index.html
	rm www/interns/temp-content1.html
	rm www/interns/temp-content2.html
	rm www/interns/temp-content1.html-e