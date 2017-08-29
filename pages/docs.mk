WOF_PROPS_REPO := https://github.com/whosonfirst/whosonfirst-properties/blob/master/

docs: docs-download-content docs-build-pages

docs-download-content:
	@make URL=$(WOF_PROPS_REPO)properties/addr.md \
	      OUT=docs/properties/addr.html \
	      download-content

docs-build-pages: docs-home docs-processes docs-keyterms docs-licensing docs-contributing docs-tests docs-sources docs-categories docs-dates docs-geometries docs-names docs-hierachies docs-placetypes docs-concordances docs-properties

docs-build-page-level1:
	@make NAV_LINK=docs SUBNAV_DIR=docs build-page-level1

docs-build-page-level2:
	@make SECTION_TITLE='Docs' \
	      NAV_LINK='docs' \
	      SUBNAV_DIR=docs \
	      build-page-level2

docs-build-page-level3:
	@make SECTION_TITLE='Docs' \
	      NAV_LINK='docs' \
	      SUBNAV_DIR=docs \
	      build-page-level3

docs-home:
	@make CONTENT=docs/docs.html \
	      OUT=docs/index.html \
	      PAGE_TITLE='Docs' \
	      docs-build-page-level1

docs-properties-home:
	@make CONTENT=docs/properties/properties.html \
	      OUT=docs/properties/index.html \
	      PAGE_TITLE='Properties' \
	      SIDENAV_LINK=properties \
	      SUBSUBNAV=properties \
	      docs-build-page-level2

docs-properties-addr:
	@make CONTENT=docs/properties/addr.html \
	      OUT=docs/properties/addr/index.html \
	      PAGE_TITLE=addr \
	      SUBSECTION_TITLE=Properties \
	      SIDENAV_LINK=addr \
	      SUBSUBNAV=properties \
	      docs-build-page-level3

docs-properties: docs-properties-addr docs-properties-edtf docs-properties-geom docs-properties-lbl docs-properties-mz docs-properties-name docs-properties-resto docs-properties-reversegeo docs-properties-src docs-properties-wof docs-properties-brooklynintegers docs-properties-index
