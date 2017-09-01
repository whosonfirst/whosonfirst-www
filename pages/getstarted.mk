getstarted: getstarted-download-content getstarted-build-pages

getstarted-download-content:

getstarted-clone-posts:
	utils/clone-getstarted.sh

getstarted-build-pages: \
	getstarted-home \
	getstarted-retrievevenues \
	getstarted-retrieveneighbourhoods

getstarted-build-page-level1:
	@make NAV_LINK='get started' SUBNAV_DIR=getstarted build-page-level1

getstarted-build-page-level2:
	@make SUBNAV_DIR=getstarted \
	      SECTION_TITLE='Get Started' \
	      NAV_LINK='get started' \
	      build-page-level2

getstarted-home:
	@make CONTENT=getstarted/getstarted.html \
	      OUT=getstarted/index.html \
	      PAGE_TITLE='get started' \
	      getstarted-build-page-level1

getstarted-retrievevenues:
	@make CONTENT=getstarted/retrievevenues.html \
	      OUT=getstarted/retrievevenues/index.html \
	      PAGE_TITLE='Retrieve Venues' \
	      SIDENAV_LINK='retrieve venues' \
	      getstarted-build-page-level2

getstarted-retrieveneighbourhoods:
	@make CONTENT=getstarted/retrieveneighbourhoods.html \
	      OUT=getstarted/retrieveneighbourhoods/index.html \
	      PAGE_TITLE='Retrieve Neighbourhoods' \
	      SIDENAV_LINK='retrieve neighbourhoods' \
	      getstarted-build-page-level2
