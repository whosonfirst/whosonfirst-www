WOF_PROPS_REPO := https://github.com/whosonfirst/whosonfirst-properties/blob/master/
COOKBOOK_REPO := https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/
PROPERTY_LIST := addr edtf geom lbl mz name resto reversegeo src wof

docs: docs-download-content docs-build-pages

docs-download-properties:
	@for prop in $(PROPERTY_LIST) ; do \
		make URL=$(WOF_PROPS_REPO)properties/$$prop.md \
			 OUT=docs/properties/$$prop.html \
			 download-content ; \
	done

docs-download-content: docs-download-properties
	@make URL=$(COOKBOOK_REPO)definition/brooklyn_integers.md \
	      OUT=docs/properties/brooklynintegers.html \
	      download-content

docs-build-pages: docs-home docs-properties

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

docs-properties:
	@make CONTENT=docs/properties/properties.html \
	      OUT=docs/properties/index.html \
	      PAGE_TITLE='Properties' \
	      SIDENAV_LINK=properties \
	      SUBSUBNAV=properties \
	      docs-build-page-level2
	@for prop in $(PROPERTY_LIST) ; do \
		make CONTENT=docs/properties/$$prop.html \
		     OUT=docs/properties/$$prop/index.html \
		     PAGE_TITLE=$$prop \
		     SUBSECTION_TITLE=Properties \
		     SIDENAV_LINK=$$prop \
		     SUBSUBNAV=properties \
		     docs-build-page-level3 ; \
	done
	@make CONTENT=docs/properties/brooklynintegers.html \
	      OUT=docs/properties/brooklynintegers/index.html \
	      PAGE_TITLE='Brooklyn Integers' \
	      SUBSECTION_TITLE=Properties \
	      SIDENAV_LINK='brooklyn integers' \
	      SUBSUBNAV=properties \
	      docs-build-page-level3
