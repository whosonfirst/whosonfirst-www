OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')

# we don't need to do any android-specific compiling (for Go things) and can rely
# on the default linux binaries but leaving these here just in case...
# ifeq ($(OSTYPE), android)
# 	OS:= $(OSTYPE)
# endif

# https://github.com/ericchiang/pup
PUP="utils/$(OS)/pup"

# Ummm... I forget. Let that be a lesson.
WOF_CLONE_WEBSITE="utils/$(OS)/wof-clone-website"

# https://github.com/whosonfirst/go-blog
WOF_MD2HTML="utils/$(OS)/wof-md2html"
WOF_MD2FEED="utils/$(OS)/wof-md2feed"
WOF_MD2IDX="utils/$(OS)/wof-md2idx"

local:
	utils/$(OS)/fileserver -root ./www

debug: blog local

# The weblog which is handled separately from the rest of the site content.
# tl;dr is "Markdown files and Golang templates that are converted to HTML
# using the whosonfirst/go-blog package (above).

blog:
	$(WOF_MD2HTML) -templates templates/common -templates templates/blog/post -header blog_post_header -footer blog_post_footer -writer fs=./www -mode directory www/blog/
	$(WOF_MD2IDX) -templates templates/common -templates templates/blog/index -header blog_index_header -footer blog_index_footer -writer fs=. www/blog/
	$(WOF_MD2IDX) -templates templates/common -templates templates/blog/index -header blog_index_header -footer blog_index_footer -writer fs=. -mode authors www/blog/
	$(WOF_MD2IDX) -templates templates/common -templates templates/blog/index -header blog_index_header -footer blog_index_footer -writer fs=. -mode tags www/blog/
	$(WOF_MD2FEED) -templates templates/blog/feed -format rss_20 www/blog/
	$(WOF_MD2FEED) -templates templates/blog/feed -format atom_10 www/blog/


# The not-weblog parts of the website. Remember there were valid reasons for doing it
# this way at the time this code was written. Those reasons may not really track anymore
# but there hasn't been the time or the space to refactor everything. See README.md for
# details.

all: mapzen favicons js css home docs tools

include pages/home.mk
include pages/docs.mk
include pages/tools.mk
include pages/getstarted.mk

download: \
	data-download-content \
	docs-download-content \
	tools-download-content \
	getstarted-download-content

build-pages: \
	home-build-pages \
	docs-build-pages \
	tools-build-pages 

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
	$(WOF_CLONE_WEBSITE) -ignore \~ -ignore .DS_Store -ignore .gitignore -ignore README.md -strict -s3-bucket whosonfirst.dev.mapzen.com -source www/

www-prod: css
	$(WOF_CLONE_WEBSITE) -ignore \~ -ignore .DS_Store -ignore .gitignore -ignore README.md -strict -source www/

download-content:
	@echo "Download content/$(OUT)"
	@curl -s $(URL) > temp.html
	@tr '\n' ' ' < temp.html > temp_flat.html
	@echo "<!-- $(URL) -->" > temp_article.html
	@grep -E -o '<article.+>.+</article>' temp_flat.html >> temp_article.html
	@sed -i -e "s/<article[^>]*>//" temp_article.html
	@sed -i -e "s/<\/article>//" temp_article.html
	@sed -i -e "s/<svg[^>]*>//g" temp_article.html
	@sed -i -e "s/<\/svg>//g" temp_article.html
	@sed -i -e "s/<path[^>]*>//g" temp_article.html
	@sed -i -e "s/<\/path>//g" temp_article.html
	@sed -E 's/<h([1-9])><a id="user-content-([^"]+)[^>]*><\/a>/<h\1 id="\2">/g' temp_article.html > temp_content.html
	@sed -i -e -E 's/".+\/master\/images\//"\/images\//' temp_content.html
	@cp temp_content.html content/$(OUT)
	@rm temp_*.html

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
	if test -f www/$(OUT)-e; then rm www/$(OUT)-e; fi

build-page-level0:
	@echo "Build www/$(OUT)"
	@cat components/head.html \
	     content/$(CONTENT) \
	     components/footer.html > www/$(OUT)

build-page-level1:
	@echo "Build www/$(OUT)"
	$(eval ROOT := $(shell dirname ./www/$(OUT)))
	if test ! -d $(ROOT); then mkdir -p $(ROOT); fi
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
	$(eval ROOT := $(shell dirname ./www/$(OUT)))
	if test ! -d $(ROOT); then mkdir -p $(ROOT); fi
	@make build-page-title
	@make build-page-content
ifdef SUBSUBNAV
	@split -p '<!-- $(SUBSUBNAV) -->' components/subnav/$(SUBNAV_DIR)/subnav-top.html subnav-top-
	@split -p '<!-- $(SUBSUBNAV) -->' components/subnav/$(SUBNAV_DIR)/subnav-bottom.html subnav-bottom-
	@cat components/head.html \
	     components/subnav/$(SUBNAV_DIR)/$(SUBSUBNAV)-top.html \
	     page-title.html \
	     components/subnav/$(SUBNAV_DIR)/$(SUBSUBNAV)-bottom.html \
	     page-content.html \
	     components/subnav/subnav-footer.html \
	     components/footer.html > www/$(OUT)
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
	@sed -i -e 's/whosonfirst\-sidenav\-link\"\>$(SUBNAV_LINK)/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>$(SUBNAV_LINK)/' www/$(OUT)
	@sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>$(SUBNAV_LINK)/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>$(SUBNAV_LINK)/' www/$(OUT)
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
	     components/subnav/$(SUBNAV_DIR)/$(SUBSUBNAV)-top.html \
	     page-title.html \
		 subnav-bottom-aa \
	     components/subnav/$(SUBNAV_DIR)/$(SUBSUBNAV)-bottom.html \
	     page-content.html \
	     components/subnav/subnav-footer.html \
	     components/footer.html > www/$(OUT)
	@sed -i -e 's/whosonfirst\-nav\-link\-collapsed\"\>$(NAV_LINK)\<\/a\>/whosonfirst\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>$(NAV_LINK)\<\/a\>/' www/$(OUT)
	@sed -i -e 's/whosonfirst\-sidenav\-link\"\>$(SUBNAV_LINK)/whosonfirst\-sidenav\-link whosonfirst\-nav\-active\"\>$(SUBNAV_LINK)/' www/$(OUT)
	@sed -i -e 's/whosonfirst\-extrasmall\-nav\-link\-collapsed\"\>$(SUBNAV_LINK)/whosonfirst\-extrasmall\-nav\-link\-collapsed whosonfirst\-nav\-active\"\>$(SUBNAV_LINK)/' www/$(OUT)
	@sed -i -e 's/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>$(SECTION_TITLE)\<\/div\>/\<div class\=\"whosonfirst\-extrasmall\-tab\-selection\"\>$(PAGE_TITLE)\<\/div\>/' www/$(OUT)
	@sed -i -e 's/<title>Who’s On First<\/title>/<title>Who’s On First | $(SECTION_TITLE) | $(SUBSECTION_TITLE) | $(PAGE_TITLE)<\/title>/' www/$(OUT)
	@make build-page-cleanup
