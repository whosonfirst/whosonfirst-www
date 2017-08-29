WOF_PROPS_REPO := https://github.com/whosonfirst/whosonfirst-properties/blob/master/
COOKBOOK_REPO := https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/
PLACETYPES_REPO := https://github.com/whosonfirst/whosonfirst-placetypes/blob/master/
PROPERTY_LIST := addr edtf geom lbl mz name resto reversegeo src wof

docs: docs-download-content docs-build-pages

docs-download-content: docs-download-properties docs-download-placetypes
	@make URL=$(COOKBOOK_REPO)definition/brooklyn_integers.md \
	      OUT=docs/properties/brooklynintegers.html \
	      download-content

docs-download-properties:
	@for prop in $(PROPERTY_LIST) ; do \
		make URL=$(WOF_PROPS_REPO)properties/$$prop.md \
			 OUT=docs/properties/$$prop.html \
			 download-content ; \
	done

docs-download-placetypes:
	@echo "Download images/placetypes-latest.png"
	@curl -s -o www/images/placetypes-latest.png https://raw.githubusercontent.com/whosonfirst/whosonfirst-placetypes/master/images/placetypes-latest.png
	@make URL=$(PLACETYPES_REPO)README.md \
		  OUT=docs/placetypes.html \
		  download-content

docs-build-pages: \
	docs-home \
	docs-properties \
	docs-concordances \
	docs-placetypes \
	docs-hierarchies

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

docs-concordances:
	@make CONTENT=docs/concordances.html \
	      OUT=docs/concordances/index.html \
	      PAGE_TITLE='Concordances' \
	      SIDENAV_LINK=concordances \
	      docs-build-page-level2

docs-placetypes:
	@make CONTENT=docs/placetypes.html \
	      OUT=docs/placetypes/index.html \
	      PAGE_TITLE='Placetypes' \
	      SIDENAV_LINK=placetypes \
	      docs-build-page-level2

docs-hierarchies:
	@make CONTENT=docs/hierarchies.html \
	      OUT=docs/hierarchies/index.html \
	      PAGE_TITLE='Hierarchies' \
	      SIDENAV_LINK=hierarchies \
	      docs-build-page-level2
