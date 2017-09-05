home: home-build-pages

home-build-pages: \
	home-page \
	home-state \
	home-interns \
	home-bundles

home-page:
	@make CONTENT=home.html OUT=index.html build-page-level0

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
