OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')

PUP="utils/$(OS)/pup"
WOF_CLONE_WEBSITE="utils/$(OS)/wof-clone-website"

all: mapzen favicons js css home data docs tools

include pages/docs.mk
include pages/data.mk
include pages/tools.mk

blog:
	utils/clone-blog.sh

download: \
	data-download-content \
	docs-download-content \
	tools-download-content

build-pages: \
	home-build-pages \
	data-build-pages \
	docs-build-pages \
	tools-build-pages

home: home-build-pages

home-build-pages:
	@make CONTENT=home.html OUT=index.html build-page-level0
	@make CONTENT=state.html \
	      OUT=state/index.html \
	      build-page-level0

setup: mk-tools
	ubuntu/setup-nginx.sh

mk-tools:
	./utils/mk-utils.sh go-whosonfirst-www wof-clone-website

mapzen:
	@echo "Downloading mapzen assets"
	@curl -s -o www/javascript/mapzen.min.js https://mapzen.com/js/mapzen.min.js
	@curl -s -o www/css/mapzen.css https://mapzen.com/js/mapzen.css

favicons:
	@echo "Downloading favicons"
	@curl -s -o www/images/favicons/apple-touch-icon.png https://mapzen.com/common/styleguide/images/favicons/apple-touch-icon.png
	@curl -s -o www/images/favicons/favicon-16x16.png https://mapzen.com/common/styleguide/images/favicons/favicon-16x16.png
	@curl -s -o www/images/favicons/favicon-32x32.png https://mapzen.com/common/styleguide/images/favicons/favicon-32x32.png
	@curl -s -o www/images/favicons/manifest.json https://mapzen.com/common/styleguide/images/favicons/manifest.json
	@curl -s -o www/images/favicons/safari-pinned-tab.svg https://mapzen.com/common/styleguide/images/favicons/safari-pinned-tab.svg

js:
	@echo "Downloading javascript"
	@curl -s -o www/javascript/mapzen.whosonfirst.chrome.js https://raw.githubusercontent.com/whosonfirst/js-mapzen-whosonfirst/master/src/mapzen.whosonfirst.chrome.js
	@curl -s -o www/javascript/mapzen.whosonfirst.chrome.init.js https://raw.githubusercontent.com/whosonfirst/js-mapzen-whosonfirst/master/src/mapzen.whosonfirst.chrome.init.js
	@curl -s -o www/javascript/jquery.min.js https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js

js-bundle:
	cat www/javascript/mapzen.whosonfirst.chrome.js www/javascript/mapzen.whosonfirst.chrome.init.js www/javascript/mapzen.whosonfirst.www.js > www/javascript/mapzen.whosonfirst.www.bundle.js
	java -jar utils/yuicompressor-2.4.8.jar www/javascript/mapzen.whosonfirst.www.bundle.js -o www/javascript/mapzen.whosonfirst.www.bundle.min.js

css:
	@echo "Downloading css"
	@curl -s -o www/css/mapzen.whosonfirst.chrome.css https://raw.githubusercontent.com/whosonfirst/css-mapzen-whosonfirst/master/css/mapzen.whosonfirst.chrome.css

css-bundle:
	cat www/css/mapzen.whosonfirst.chrome.css www/css/mapzen.whosonfirst.www.css > www/css/mapzen.whosonfirst.www.bundle.css
	java -jar utils/yuicompressor-2.4.8.jar --type css www/css/mapzen.whosonfirst.www.bundle.css -o www/css/mapzen.whosonfirst.www.bundle.min.css

www: www-dev www-prod

www-dev: css
	$(WOF_CLONE_WEBSITE) -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -s3-bucket whosonfirst.dev.mapzen.com -source www/

www-prod: css
	$(WOF_CLONE_WEBSITE) -ignore \~ -ignore .DS_Store -ignore .gitignore -strict -source www/

download-content:
	@echo "Download content/$(OUT)"
	@curl -s $(URL) > temp.html
	@tr '\n' ' ' < temp.html > temp_flat.html
	@grep -E -o '<article.+>.+</article>' temp_flat.html > temp_article.html
	@sed -i -e "s/<article[^>]*>//" temp_article.html
	@sed -i -e "s/<\/article>//" temp_article.html
	@sed -i -e "s/<svg[^>]*>//g" temp_article.html
	@sed -i -e "s/<\/svg>//g" temp_article.html
	@sed -i -e "s/<path[^>]*>//g" temp_article.html
	@sed -i -e "s/<\/path>//g" temp_article.html
	@sed -i -e "s/<a[^>]*><\/a>//g" temp_article.html
	@sed -i -e -E 's/".+\/master\/images\//"\/images\//' temp_article.html
	@mv temp_article.html content/$(OUT)
	@rm temp*

build-page-content:
	@cp content/$(CONTENT) page-content.html
	@sed -i -e "s/<h1[^>]*>.*<\/h1>//g" page-content.html

build-page-title:
	@echo "<h1 class=\"whosonfirst-subpage-header\">" > page-title.html
	@cat content/$(CONTENT) | $(PUP) -i 0 'body h1 text{}' >> page-title.html
	@echo "</h1>" >> page-title.html

build-page-cleanup:
	@rm page-title.html
	@rm page-content.html*
	@rm www/$(OUT)-e

build-page-level0:
	@echo "Build www/$(OUT)"
	@cat components/head.html \
	     content/$(CONTENT) \
	     components/footer.html > www/$(OUT)

build-page-level1:
	@echo "Build www/$(OUT)"
	@make build-page-content
	@make build-page-title
	@cat components/head.html \
	     components/subnav/$(SUBNAV_DIR)/subnav-top.html \
	     page-title.html \
	     components/subnav/$(SUBNAV_DIR)/subnav-bottom.html \
	     page-content.html \
	     components/subnav/subnav-footer.html \
	     components/footer.html > www/$(OUT)
	@sed -i -e "s/whosonfirst\-nav\-link\-collapsed\"\>$(NAV_LINK)\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>$(NAV_LINK)\<\/a\>/" www/$(OUT)
	@sed -i -e "s/<title>Who’s On First<\/title>/<title>Who’s On First | $(PAGE_TITLE)<\/title>/" www/$(OUT)
	@make build-page-cleanup

build-page-level2:
	@echo "Build www/$(OUT)"
	@make build-page-title
	@make build-page-content
ifdef SUBSUBNAV
	@split -p '<!-- $(SUBSUBNAV) -->' components/subnav/$(SUBNAV_DIR)/subnav-top.html subnav-top-
	@split -p '<!-- $(SUBSUBNAV) -->' components/subnav/$(SUBNAV_DIR)/subnav-bottom.html subnav-bottom-
	@cat components/head.html \
	     subnav-top-aa \
	     components/subnav/$(SUBNAV_DIR)/$(SUBSUBNAV)-top.html \
	     subnav-top-ab \
	     page-title.html \
	     subnav-bottom-aa \
	     components/subnav/$(SUBNAV_DIR)/$(SUBSUBNAV)-bottom.html \
	     subnav-bottom-ab \
	     page-content.html \
	     components/subnav/subnav-footer.html \
	     components/footer.html > www/$(OUT)
	@rm subnav-top-aa
	@rm subnav-top-ab
	@rm subnav-bottom-aa
	@rm subnav-bottom-ab
else
	@cat components/head.html \
	     components/subnav/$(SUBNAV_DIR)/subnav-top.html \
	     page-title.html \
	     components/subnav/$(SUBNAV_DIR)/subnav-bottom.html \
	     page-content.html \
	     components/subnav/subnav-footer.html \
	     components/footer.html > www/$(OUT)
endif
	@sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>$(NAV_LINK)\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>$(NAV_LINK)\<\/a\>/' www/$(OUT)
	@sed -i -e 's/whosonfirst\-sidenav\-link\"\>$(SIDENAV_LINK)/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>$(SIDENAV_LINK)/' www/$(OUT)
	@sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>$(SIDENAV_LINK)/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>$(SIDENAV_LINK)/' www/$(OUT)
	@sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>$(SECTION_TITLE)\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>$(PAGE_TITLE)\<\/div\>/' www/$(OUT)
	@sed -i -e 's/<title>Who’s On First<\/title>/<title>Who’s On First | $(SECTION_TITLE) | $(PAGE_TITLE)<\/title>/' www/$(OUT)
	@make build-page-cleanup

build-page-level3:
	@echo "Build www/$(OUT)"
	@make build-page-title
	@make build-page-content
	@split -p '<!-- $(SUBSUBNAV) -->' components/subnav/$(SUBNAV_DIR)/subnav-top.html subnav-top-
	@split -p '<!-- $(SUBSUBNAV) -->' components/subnav/$(SUBNAV_DIR)/subnav-bottom.html subnav-bottom-
	@cat components/head.html \
	     subnav-top-aa \
	     components/subnav/$(SUBNAV_DIR)/$(SUBSUBNAV)-top.html \
	     subnav-top-ab \
	     page-title.html \
		 subnav-bottom-aa \
	     components/subnav/$(SUBNAV_DIR)/$(SUBSUBNAV)-bottom.html \
	     subnav-bottom-ab \
	     page-content.html \
	     components/subnav/subnav-footer.html \
	     components/footer.html > www/$(OUT)
	@rm subnav-top-aa
	@rm subnav-top-ab
	@rm subnav-bottom-aa
	@rm subnav-bottom-ab
	@sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>$(NAV_LINK)\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>$(NAV_LINK)\<\/a\>/' www/$(OUT)
	@sed -i -e 's/whosonfirst\-sidenav\-link\"\>$(SIDENAV_LINK)/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>$(SIDENAV_LINK)/' www/$(OUT)
	@sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>$(SIDENAV_LINK)/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>$(SIDENAV_LINK)/' www/$(OUT)
	@sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>$(SECTION_TITLE)\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>$(PAGE_TITLE)\<\/div\>/' www/$(OUT)
	@sed -i -e 's/<title>Who’s On First<\/title>/<title>Who’s On First | $(SECTION_TITLE) | $(SUBSECTION_TITLE) | $(PAGE_TITLE)<\/title>/' www/$(OUT)
	@make build-page-cleanup

docs-processes-index:
	cat content/docs/processes/processes.html | $(PUP) 'body h1'  > www/docs/processes/temp-content1.html
	cat content/docs/processes/processes.html | $(PUP) 'body :not(h1)'  > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/docs/processes/temp-content1.html
	cat components/head/head.html components/navbar/navbar.html components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html components/footer/footer.html > www/docs/processes/index.html
	rm www/docs/processes/temp-content1.html
	rm www/docs/processes/temp-content2.html
	rm www/docs/processes/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>processes/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>processes/' www/docs/processes/index.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>processes/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>processes/' www/docs/processes/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>docs\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>docs\<\/a\>/' www/docs/processes/index.html
	sed -i -e -E 's/id\=\"user-content\-([^\"]*)\" class\=\"anchor\"/id\=\"\1" class\=\"anchor\"/' www/docs/processes/index.html
	rm www/docs/processes/index.html-e

docs-processes-significantevent:
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/significant_event.md | $(PUP) 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/significant_event.md | $(PUP) 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/docs/processes/temp-content1.html
	cat components/head/head.html components/navbar/navbar.html components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html components/footer/footer.html > www/docs/processes/significantevent.html
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
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/deprecated_vs_cessation.md | $(PUP) 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/deprecated_vs_cessation.md | $(PUP) 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/docs/processes/temp-content1.html
	cat components/head/head.html components/navbar/navbar.html components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html components/footer/footer.html > www/docs/processes/assigningcessation.html
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
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/requirements_for_s3.md | $(PUP) 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/how_to/requirements_for_s3.md | $(PUP) 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/docs/processes/temp-content1.html
	cat components/head/head.html components/navbar/navbar.html components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html components/footer/footer.html > www/docs/processes/s3requirements.html
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
	cat content/docs/processes/wikipediaconcordances.html | $(PUP) 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	cat content/docs/processes/wikipediaconcordances.html | $(PUP) 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/docs/processes/temp-content1.html
	cat components/head/head.html components/navbar/navbar.html components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html components/footer/footer.html > www/docs/processes/wikipediaconcordances.html
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
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/seattle_neighbourhood_updates.md | $(PUP) 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/seattle_neighbourhood_updates.md | $(PUP) 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/docs/processes/temp-content1.html
	cat components/head/head.html components/navbar/navbar.html components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html components/footer/footer.html > www/docs/processes/seattleneighborhoodupdates.html
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
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md | $(PUP) 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_1.md | $(PUP) 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/issue_workflows/sf_neighbourhood_updates_pt_2.md | $(PUP) 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content3.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/docs/processes/temp-content1.html
	cat components/head/head.html components/navbar/navbar.html components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html www/docs/processes/temp-content3.html components/footer/footer.html > www/docs/processes/updatingsanfrancisconeighborhoods.html
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
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/wof:id_lifecycle.md | $(PUP) 'article.markdown-body h1:first-of-type' > www/docs/processes/temp-content1.html
	curl -s https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/definition/wof:id_lifecycle.md | $(PUP) 'article.markdown-body :not(h1:first-of-type)' > www/docs/processes/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/docs/processes/temp-content1.html
	cat components/head/head.html components/navbar/navbar.html components/subnav/docs/processes/subnav-top.html www/docs/processes/temp-content1.html components/subnav/docs/processes/subnav-bottom.html  www/docs/processes/temp-content2.html components/footer/footer.html > www/docs/processes/woflifecycle.html
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

blog-withalltheblogfolder:
	cat content/blog/blog.html | $(PUP) 'body h1' > www/alltheblog/temp-content1.html
	cat content/blog/blog.html | $(PUP) 'body :not(h1)' > www/alltheblog/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/alltheblog/temp-content1.html
	cat components/head/head-onelevelup.html components/navbar/navbar-onelevelup.html components/subnav/blog/subnav-top.html www/alltheblog/temp-content1.html components/subnav/blog/subnav-bottom.html  www/alltheblog/temp-content2.html components/footer/footer-onelevelup.html > www/alltheblog/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>blog\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>blog\<\/a\>/' www/alltheblog/index.html
	rm www/alltheblog/temp-content1.html
	rm www/alltheblog/temp-content2.html
	rm www/alltheblog/temp-content1.html-e
	rm www/alltheblog/index.html-e

blog-home:
	cat content/blog/blog.html | $(PUP) 'body h1' > www/blog/temp-content1.html
	cat content/blog/blog.html | $(PUP) 'body :not(h1)' > www/blog/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/blog/temp-content1.html
	cat components/head/head-onelevelup.html components/navbar/navbar-onelevelup.html components/subnav/blog/subnav-top.html www/blog/temp-content1.html components/subnav/blog/subnav-bottom.html  www/blog/temp-content2.html components/footer/footer-onelevelup.html > www/blog/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>blog\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>blog\<\/a\>/' www/blog/index.html
	rm www/blog/temp-content1.html
	rm www/blog/temp-content2.html
	rm www/blog/temp-content1.html-e
	rm www/blog/index.html-e

blog-mesoshapes:
	cat content/blog/mesoshapes/mesoshapes.html | $(PUP) 'body h1' > www/blog/mesoshapes/temp-content1.html
	cat content/blog/mesoshapes/mesoshapes.html | $(PUP) 'body :not(h1)' > www/blog/mesoshapes/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/blog/mesoshapes/temp-content1.html
	cat components/head/head.html components/navbar/navbar.html components/subnav/blog/subnav-top.html www/blog/mesoshapes/temp-content1.html components/subnav/blog/subnav-bottom.html  www/blog/mesoshapes/temp-content2.html components/footer/footer.html > www/blog/mesoshapes/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>blog\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>blog\<\/a\>/' www/blog/mesoshapes/index.html
	rm www/blog/mesoshapes/temp-content1.html
	rm www/blog/mesoshapes/temp-content2.html
	rm www/blog/mesoshapes/temp-content1.html-e
	rm www/blog/mesoshapes/index.html-e

state:
	cat content/state/state.html | $(PUP) 'body h1' > www/state/temp-content1.html
	cat content/state/state.html | $(PUP) 'body :not(h1)' > www/state/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/state/temp-content1.html
	cat components/head/head-onelevelup.html components/navbar/navbar-onelevelup.html components/subnav/state/subnav-top.html www/state/temp-content1.html components/subnav/state/subnav-bottom.html  www/state/temp-content2.html components/footer/footer-onelevelup.html > www/state/index.html
	rm www/state/temp-content1.html
	rm www/state/temp-content2.html
	rm www/state/temp-content1.html-e

getstarted-index:
	cat content/getstarted/getstarted.html | $(PUP) 'body h1' > www/getstarted/temp-content1.html
	cat content/getstarted/getstarted.html | $(PUP) 'body :not(h1)' > www/getstarted/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/getstarted/temp-content1.html
	cat components/head/head-onelevelup.html components/navbar/navbar-onelevelup.html components/subnav/getstarted/subnav-top.html www/getstarted/temp-content1.html components/subnav/getstarted/subnav-bottom.html  www/getstarted/temp-content2.html components/footer/footer-onelevelup.html > www/getstarted/index.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>get started\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>get started\<\/a\>/' www/getstarted/index.html
	rm www/getstarted/temp-content1.html
	rm www/getstarted/temp-content2.html
	rm www/getstarted/temp-content1.html-e
	rm www/getstarted/index.html-e

getstarted-retrievevenues:
	cat content/getstarted/retrievevenues.html | $(PUP) 'body h1' > www/getstarted/temp-content1.html
	cat content/getstarted/retrievevenues.html | $(PUP) 'body :not(h1)' > www/getstarted/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/getstarted/temp-content1.html
	cat components/head/head-onelevelup.html components/navbar/navbar-onelevelup.html components/subnav/getstarted/subnav-top.html www/getstarted/temp-content1.html components/subnav/getstarted/subnav-bottom.html  www/getstarted/temp-content2.html components/footer/footer-onelevelup.html > www/getstarted/retrievevenues.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>get started\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>get started\<\/a\>/' www/getstarted/retrievevenues.html
	rm www/getstarted/temp-content1.html
	rm www/getstarted/temp-content2.html
	rm www/getstarted/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>retrieve v/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>retrieve v/' www/getstarted/retrievevenues.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>retrieve v/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>retrieve v/' www/getstarted/retrievevenues.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Get Started\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Retrieve Venues\<\/div\>/' www/getstarted/retrievevenues.html
	rm www/getstarted/retrievevenues.html-e

getstarted-retrieveneighbourhoods:
	cat content/getstarted/retrieveneighbourhoods.html | $(PUP) 'body h1' > www/getstarted/temp-content1.html
	cat content/getstarted/retrieveneighbourhoods.html | $(PUP) 'body :not(h1)' > www/getstarted/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/getstarted/temp-content1.html
	cat components/head/head-onelevelup.html components/navbar/navbar-onelevelup.html components/subnav/getstarted/subnav-top.html www/getstarted/temp-content1.html components/subnav/getstarted/subnav-bottom.html  www/getstarted/temp-content2.html components/footer/footer-onelevelup.html > www/getstarted/retrieveneighbourhoods.html
	sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>get started\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>get started\<\/a\>/' www/getstarted/retrieveneighbourhoods.html
	rm www/getstarted/temp-content1.html
	rm www/getstarted/temp-content2.html
	rm www/getstarted/temp-content1.html-e
	sed -i -e 's/whosonfirst\-sidenav\-link\"\>retrieve n/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>retrieve n/' www/getstarted/retrieveneighbourhoods.html
	sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed-last\"\>retrieve n/whosonfirst\-extrasmall\-nav\-link\-collapsed-last whosonfirst\-nav\-active\"\>retrieve n/' www/getstarted/retrieveneighbourhoods.html
	sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Get Started\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>Retrieve Neighbourhoods\<\/div\>/' www/getstarted/retrieveneighbourhoods.html
	rm www/getstarted/retrieveneighbourhoods.html-e

interns:
	cat content/interns/interns.html | $(PUP) 'body h1' > www/interns/temp-content1.html
	cat content/interns/interns.html | $(PUP) 'body :not(h1)' > www/interns/temp-content2.html
	sed -i -e 's/\<h1/\<h1 class\=\"whosonfirst\-subpage\-header\"/' www/interns/temp-content1.html
	cat components/head/head-onelevelup.html components/navbar/navbar-onelevelup.html components/subnav/interns/subnav-top.html www/interns/temp-content1.html components/subnav/interns/subnav-bottom.html  www/interns/temp-content2.html components/footer/footer-onelevelup.html > www/interns/index.html
	rm www/interns/temp-content1.html
	rm www/interns/temp-content2.html
	rm www/interns/temp-content1.html-e
