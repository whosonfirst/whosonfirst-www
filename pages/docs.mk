docs: docs-download-content docs-build-pages

docs-download-content:

docs-build-pages: docs-home docs-processes docs-keyterms docs-licensing docs-contributing docs-tests docs-sources docs-categories docs-dates docs-geometries docs-names docs-hierachies docs-placetypes docs-concordances docs-properties

docs-build-page-level1:
	@make NAV_LINK=docs SUBNAV_DIR=docs build-page-level1

docs-build-page-level2:
	@make SUBNAV_DIR=docs \
	      SECTION_TITLE='Docs' \
	      NAV_LINK='docs' \
	      build-page-level2

docs-home:
	@make CONTENT=docs/docs.html \
	      OUT=docs/index.html \
	      PAGE_TITLE='Docs' \
	      docs-build-page-level1
