data-page-level1:
	@make NAV_LINK=data SUBNAV=data page-level1

data-page-level2:
	@make NAV_LINK=data \
	      SUBNAV=data \
	      TAB_SELECTION_SEARCH='Data' \
	      page-level2

data-home:
	@make CONTENT=data/data.html \
	      OUT=data/index.html \
	      TITLE='Who’s On First | Data' \
	      data-page-level1

data-principles:
	@make CONTENT=data/principles/principles.html \
	      OUT=data/principles/index.html \
	      TITLE='Who’s On First | Data | Principles' \
	      TAB_SELECTION_REPLACE='Data Principles' \
	      data-page-level2
