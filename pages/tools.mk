tools: tools-download-content tools-build-pages

tools-download-content:

tools-build-pages: tools-home

tools-build-page-level1:
	@make NAV_LINK=tools SUBNAV_DIR=tools build-page-level1

tools-build-page-level2:
	@make SECTION_TITLE='Tools' \
	      NAV_LINK='tools' \
	      SUBNAV_DIR=tools \
	      build-page-level2

tools-home:
	@make CONTENT=tools/tools.html \
	      OUT=tools/index.html \
	      PAGE_TITLE='Tools' \
	      tools-build-page-level1
