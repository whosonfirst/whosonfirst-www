home: home-build-pages

home-build-pages: \
	home-page \
	home-state \
	home-interns

home-page:
	@make CONTENT=home.html OUT=index.html build-page-level0

home-state:
	@make CONTENT=state.html \
	      OUT=state/index.html \
	      build-page-level0

home-interns:
	@make CONTENT=interns.html \
	      OUT=interns/index.html \
	      build-page-level0
