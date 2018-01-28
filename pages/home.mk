home: home-build-pages

home-build-pages: \
	home-page \
	home-what \
	home-download \
	home-code \
	home-api \
	home-spelunker \
	home-404 

home-page:
	@make CONTENT=home.html OUT=index.html build-page-level0

home-api:
	@make CONTENT=api/index.html \
		OUT=api/index.html \
		SUBNAV_DIR=common \
		build-page-level1

home-spelunker:
	@make CONTENT=spelunker/index.html \
		OUT=spelunker/index.html \
		SUBNAV_DIR=common \
		build-page-level1

home-404:
	@make CONTENT=404.html \
		OUT=404.html \
	        SUBNAV_DIR=common \
		build-page-level1

home-code:
	@make CONTENT=code/index.html \
	      OUT=code/index.html \
	      SUBNAV_DIR=common \
	      build-page-level1

home-what:
	@make CONTENT=what/index.html \
	      OUT=what/index.html \
	      SUBNAV_DIR=common \
	      build-page-level1

home-download:
	@make CONTENT=download/index.html \
	      OUT=download/index.html \
	      SUBNAV_DIR=common \
	      build-page-level1

home-interns:
	@make CONTENT=interns.html \
	      OUT=interns/index.html \
	      SUBNAV_DIR=interns \
	      build-page-level1
