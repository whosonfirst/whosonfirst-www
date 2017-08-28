data-pages: data-page-home data-page-principles data-page-available data-pullrequest data-amazon data-github data-knownknowns

data-page-level1:
	@make NAV_LINK=data SUBNAV_DIR=data page-level1

data-page-level2:
	@make SUBNAV_DIR=data \
	      SECTION_TITLE='Data' \
	      NAV_LINK='data' \
	      page-level2

data-page-home:
	@make CONTENT=data/data.html \
	      OUT=data/index.html \
	      PAGE_TITLE='Data' \
	      data-page-level1

data-page-principles:
	@make CONTENT=data/principles/principles.html \
	      OUT=data/principles/index.html \
	      PAGE_TITLE='Data Principles' \
	      SIDENAV_LINK='data principles' \
	      data-page-level2

data-page-available:
	@make CONTENT=data/available/available.html \
	      OUT=data/available/index.html \
	      PAGE_TITLE='Available Data' \
	      SIDENAV_LINK='available data' \
	      data-page-level2
