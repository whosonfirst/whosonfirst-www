PROPERTIES_REPO := https://github.com/whosonfirst/whosonfirst-properties/blob/master/
COOKBOOK_REPO := https://github.com/whosonfirst/whosonfirst-cookbook/blob/master/
PLACETYPES_REPO := https://github.com/whosonfirst/whosonfirst-placetypes/blob/master/
NAMES_REPO := https://github.com/whosonfirst/whosonfirst-names/blob/master/
GEOMETRIES_REPO := https://github.com/whosonfirst/whosonfirst-geometries/blob/master/
DATES_REPO := https://github.com/whosonfirst/whosonfirst-dates/blob/master/
CATEGORIES_REPO := https://github.com/whosonfirst/whosonfirst-categories/blob/master/
SOURCES_REPO := https://github.com/whosonfirst/whosonfirst-sources/blob/master/
TESTS_REPO := https://github.com/whosonfirst/whosonfirst-tests/blob/master/

PROPERTY_LIST := addr edtf geom lbl mz name resto reversegeo src wof

docs: docs-download-content docs-build-pages

docs-download-content: \
	docs-download-properties \
	docs-download-brooklynintegers \
	docs-download-placetypes \
	docs-download-names \
	docs-download-geometries \
	docs-download-dates \
	docs-download-categories \
	docs-download-sources \
	docs-download-tests \
	docs-download-contributing \
	docs-download-licenses \
	docs-download-processes \
	docs-download-keyterms

docs-build-pages: \
	docs-home \
	docs-properties \
	docs-concordances \
	docs-placetypes \
	docs-hierarchies \
	docs-names \
	docs-geometries \
	docs-dates \
	docs-categories \
	docs-sources \
	docs-tests \
	docs-contributing \
	docs-licenses \
	docs-processes \
	docs-keyterms \
	docs-spr \
	docs-uris

docs-download-properties:
	@for prop in $(PROPERTY_LIST) ; do \
		make URL=$(PROPERTIES_REPO)properties/$$prop.md \
			 OUT=docs/properties/$$prop.html \
			 download-content ; \
	done

docs-download-brooklynintegers:
	@make URL=$(COOKBOOK_REPO)definition/brooklyn_integers.md \
		  OUT=docs/properties/brooklynintegers.html \
		  download-content

docs-download-placetypes:
	@echo "Download www/images/placetypes-latest.png"
	@curl -s -o www/images/placetypes-latest.png https://raw.githubusercontent.com/whosonfirst/whosonfirst-placetypes/master/images/placetypes-latest.png
	@make URL=$(PLACETYPES_REPO)README.md \
		  OUT=docs/placetypes.html \
		  download-content

docs-download-names:
	@make URL=$(NAMES_REPO)README.md \
		  OUT=docs/names.html \
		  download-content

docs-download-geometries:
	@make URL=$(GEOMETRIES_REPO)README.md \
	      OUT=docs/geometries/geometries.html \
	      download-content
	@make URL=$(COOKBOOK_REPO)how_to/creating_alt_geometries.md \
	      OUT=docs/geometries/alt_geometries.html \
	      download-content

docs-download-dates:
	@make URL=$(DATES_REPO)README.md \
		  OUT=docs/dates.html \
		  download-content

docs-download-categories:
	@echo "Download www/images/chicken.jpg"
	@curl -s -o www/images/chicken.jpg https://github.com/whosonfirst/whosonfirst-categories/raw/master/chicken.jpg
	@make URL=$(CATEGORIES_REPO)README.md \
		  OUT=docs/categories.html \
		  download-content

docs-download-sources:
	@make URL=$(SOURCES_REPO)README.md \
	      OUT=docs/sources/sources.html \
	      download-content
	@make URL=$(SOURCES_REPO)sources/README.md \
	      OUT=docs/sources/source_list.html \
	      download-content

docs-download-tests:
	@make URL=$(TESTS_REPO)README.md \
	      OUT=docs/tests.html \
	      download-content

docs-download-contributing:
	@make URL=$(PROPERTIES_REPO)CONTRIBUTING.md \
	      OUT=docs/contributing.html \
	      download-content

docs-download-licenses:
	@make URL=$(COOKBOOK_REPO)definition/data_licenses.md \
	      OUT=docs/licenses.html \
	      download-content

docs-download-processes: \
	docs-download-processes-cessation-deprecation \
	docs-download-processes-significant-event \
	docs-download-processes-wof-life-cycle \
	docs-download-processes-s3-import \
	docs-download-processes-seattle-neighbourhoods \
	docs-download-processes-san-francisco-neighbourhoods

docs-download-processes-cessation-deprecation:
	@make URL=$(COOKBOOK_REPO)definition/deprecated_vs_cessation.md \
	      OUT=docs/processes/cessation-deprecation.html \
	      download-content

docs-download-processes-significant-event:
	@make URL=$(COOKBOOK_REPO)definition/significant_event.md \
	      OUT=docs/processes/significant-event.html \
	      download-content

docs-download-processes-wof-life-cycle:
	@make URL=$(COOKBOOK_REPO)definition/wof:id_lifecycle.md \
	      OUT=docs/processes/wof-life-cycle.html \
	      download-content

docs-download-processes-s3-import:
	@make URL=$(COOKBOOK_REPO)how_to/requirements_for_s3.md \
	      OUT=docs/processes/s3-import.html \
	      download-content

docs-download-processes-seattle-neighbourhoods:
	@make URL=$(COOKBOOK_REPO)issue_workflows/seattle_neighbourhood_updates.md \
	      OUT=docs/processes/seattle-neighbourhoods.html \
	      download-content

docs-download-processes-san-francisco-neighbourhoods:
	@make URL=$(COOKBOOK_REPO)issue_workflows/sf_neighbourhood_updates_pt_1.md \
	      OUT=docs/processes/san-francisco-neighbourhoods1.html \
	      download-content
	@make URL=$(COOKBOOK_REPO)issue_workflows/sf_neighbourhood_updates_pt_1.md \
	      OUT=docs/processes/san-francisco-neighbourhoods2.html \
	      download-content
	@echo "Merge content/docs/processes/san-francisco-neighbourhoods.html"
	@cat content/docs/processes/san-francisco-neighbourhoods1.html \
	     content/docs/processes/san-francisco-neighbourhoods2.html \
	     > content/docs/processes/san-francisco-neighbourhoods.html
	@rm content/docs/processes/san-francisco-neighbourhoods1.html
	@rm content/docs/processes/san-francisco-neighbourhoods2.html

docs-download-keyterms:
	@make URL=$(COOKBOOK_REPO)definition/key_terms.md \
	      OUT=docs/keyterms.html \
	      download-content

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
	      SUBNAV_LINK=properties \
	      SUBSUBNAV=properties \
	      docs-build-page-level2
	@for prop in $(PROPERTY_LIST) ; do \
		make CONTENT=docs/properties/$$prop.html \
		     OUT=docs/properties/$$prop/index.html \
		     PAGE_TITLE=$$prop \
		     SUBSECTION_TITLE=Properties \
		     SUBNAV_LINK=$$prop \
		     SUBSUBNAV=properties \
		     docs-build-page-level3 ; \
	done
	@make CONTENT=docs/properties/brooklynintegers.html \
	      OUT=docs/properties/brooklynintegers/index.html \
	      PAGE_TITLE='Brooklyn Integers' \
	      SUBSECTION_TITLE=Properties \
	      SUBNAV_LINK='brooklyn integers' \
	      SUBSUBNAV=properties \
	      docs-build-page-level3

docs-concordances:
	@make CONTENT=docs/concordances.html \
	      OUT=docs/concordances/index.html \
	      PAGE_TITLE='Concordances' \
	      SUBNAV_LINK=concordances \
	      docs-build-page-level2

docs-spr:
	@make CONTENT=docs/spr.html \
	      OUT=docs/spr/index.html \
	      PAGE_TITLE='Standard Places Response (SPR)' \
	      SUBNAV_LINK=spr \
	      docs-build-page-level2

docs-uris:
	@make CONTENT=docs/uris.html \
	      OUT=docs/uris/index.html \
	      PAGE_TITLE='URIs' \
	      SUBNAV_LINK=uris \
	      docs-build-page-level2

docs-placetypes:
	@make CONTENT=docs/placetypes.html \
	      OUT=docs/placetypes/index.html \
	      PAGE_TITLE='Placetypes' \
	      SUBNAV_LINK=placetypes \
	      docs-build-page-level2

docs-hierarchies:
	@make CONTENT=docs/hierarchies.html \
	      OUT=docs/hierarchies/index.html \
	      PAGE_TITLE='Hierarchies' \
	      SUBNAV_LINK=hierarchies \
	      docs-build-page-level2

docs-names:
	@make CONTENT=docs/names.html \
	      OUT=docs/names/index.html \
	      PAGE_TITLE='Names' \
	      SUBNAV_LINK=names \
	      docs-build-page-level2

docs-geometries:
	@make CONTENT=docs/geometries/geometries.html \
	      OUT=docs/geometries/index.html \
	      PAGE_TITLE='Geometries' \
	      SUBNAV_LINK=geometries \
	      SUBSUBNAV=geometries \
	      docs-build-page-level2
	@make CONTENT=docs/geometries/alt_geometries.html \
	      OUT=docs/geometries/alt/index.html \
	      PAGE_TITLE='Alt Geometries' \
	      SUBNAV_LINK='alt geometries' \
	      SUBSUBNAV=geometries \
	      docs-build-page-level3

docs-dates:
	@make CONTENT=docs/dates.html \
	      OUT=docs/dates/index.html \
	      PAGE_TITLE='Dates' \
	      SUBNAV_LINK=dates \
	      docs-build-page-level2

docs-categories:
	@make CONTENT=docs/categories.html \
	      OUT=docs/categories/index.html \
	      PAGE_TITLE='Categories' \
	      SUBNAV_LINK=categories \
	      docs-build-page-level2

docs-sources:
	@make CONTENT=docs/sources/sources.html \
	      OUT=docs/sources/index.html \
	      PAGE_TITLE='Sources' \
	      SUBNAV_LINK=sources \
	      SUBSUBNAV=sources \
	      docs-build-page-level2
	@make CONTENT=docs/sources/source_list.html \
	      OUT=docs/sources/list/index.html \
	      PAGE_TITLE='List of Sources' \
	      SUBNAV_LINK='list of sources' \
	      SUBSUBNAV=sources \
	      docs-build-page-level3

docs-tests:
	@make CONTENT=docs/tests.html \
	      OUT=docs/tests/index.html \
	      PAGE_TITLE='Tests' \
	      SUBNAV_LINK=tests \
	      docs-build-page-level2

docs-contributing:
	@make CONTENT=docs/contributing.html \
	      OUT=docs/contributing/index.html \
	      PAGE_TITLE='Contributing' \
	      SUBNAV_LINK=contributing \
	      docs-build-page-level2

docs-licenses:
	@make CONTENT=docs/licenses.html \
	      OUT=docs/licenses/index.html \
	      PAGE_TITLE='Data Licenses' \
	      SUBNAV_LINK='data licenses' \
	      docs-build-page-level2

docs-processes: \
	docs-processes-home \
	docs-processes-cessation-deprecation \
	docs-processes-significant-event \
	docs-processes-wof-life-cycle \
	docs-processes-s3-import \
	docs-processes-seattle-neighbourhoods \
	docs-processes-san-francisco-neighbourhoods \
	docs-processes-wikipedia-concordances

docs-processes-home:
	@make CONTENT=docs/processes/processes.html \
	      OUT=docs/processes/index.html \
	      PAGE_TITLE='Processes and Workflows' \
	      SUBNAV_LINK='processes and workflows' \
	      SUBSUBNAV=processes \
	      docs-build-page-level2

docs-processes-build-page-level3:
	@make SUBSECTION_TITLE='Processes and Workflows' \
	      SUBSUBNAV=processes \
	      docs-build-page-level3

docs-processes-cessation-deprecation:
	@make CONTENT=docs/processes/cessation-deprecation.html \
	      OUT=docs/processes/cessation-deprecation/index.html \
	      PAGE_TITLE='Cessation and Deprecation' \
	      SUBNAV_LINK='cessation and deprecation' \
	      docs-processes-build-page-level3

docs-processes-significant-event:
	@make CONTENT=docs/processes/significant-event.html \
	      OUT=docs/processes/significant-event/index.html \
	      PAGE_TITLE='What is a Significant Event' \
	      SUBNAV_LINK='what is a significant event' \
	      docs-processes-build-page-level3

docs-processes-wof-life-cycle:
	@make CONTENT=docs/processes/wof-life-cycle.html \
	      OUT=docs/processes/wof-life-cycle/index.html \
	      PAGE_TITLE='wof:id life cycle' \
	      SUBNAV_LINK='wof life cycle' \
	      docs-processes-build-page-level3

docs-processes-s3-import:
	@make CONTENT=docs/processes/s3-import.html \
	      OUT=docs/processes/s3-import/index.html \
	      PAGE_TITLE='S3 Import Requirements' \
	      SUBNAV_LINK='s3 import requirements' \
	      docs-processes-build-page-level3

docs-processes-seattle-neighbourhoods:
	@make CONTENT=docs/processes/seattle-neighbourhoods.html \
	      OUT=docs/processes/seattle-neighbourhoods/index.html \
	      PAGE_TITLE='Seattle Neighbourhood Updates' \
	      SUBNAV_LINK='seattle neighbourhoods' \
	      docs-processes-build-page-level3

docs-processes-san-francisco-neighbourhoods:
	@make CONTENT=docs/processes/san-francisco-neighbourhoods.html \
	      OUT=docs/processes/san-francisco-neighbourhoods/index.html \
	      PAGE_TITLE='San Francisco Neighbourhood Updates' \
	      SUBNAV_LINK='san francisco neighbourhoods' \
	      docs-processes-build-page-level3

docs-processes-wikipedia-concordances:
	@make CONTENT=docs/processes/wikipedia-concordances.html \
	      OUT=docs/processes/wikipedia-concordances/index.html \
	      PAGE_TITLE='Wikipedia Concordances' \
	      SUBNAV_LINK='wikipedia concordances' \
	      docs-processes-build-page-level3

docs-keyterms:
	@make CONTENT=docs/keyterms.html \
	      OUT=docs/keyterms/index.html \
	      PAGE_TITLE='Key Terms' \
	      SUBNAV_LINK='key terms' \
	      docs-build-page-level2
