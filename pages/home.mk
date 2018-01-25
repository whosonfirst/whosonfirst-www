home: home-build-pages

home-build-pages: \
	home-page \
	home-state \
	home-bundles \
	home-what \
	home-download \

home-page:
	@make CONTENT=home.html OUT=index.html build-page-level0

home-what:
	@make CONTENT=what/index.html \
	      OUT=what/index.html \
	      SUBNAV_DIR=what \
	      build-page-level1

home-download:
	@make CONTENT=download/index.html \
	      OUT=download/index.html \
	      SUBNAV_DIR=what \
	      build-page-level1
	
home-state:
	@make CONTENT=state.html \
	      OUT=state/index.html \
	      SUBNAV_DIR=state \
	      build-page-level1

home-interns:
	@make CONTENT=interns.html \
	      OUT=interns/index.html \
	      SUBNAV_DIR=interns \
	      build-page-level1

home-bundles:
	@make CONTENT=bundles.html \
	      OUT=bundles/index.html \
	      SUBNAV_DIR=bundles \
	      build-page-level1

home-sqlite:
	@make CONTENT=sqlite.html \
	      OUT=sqlite/index.html \
	      SUBNAV_DIR=sqlite \
	      build-page-level1
