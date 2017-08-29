data: data-download-pages data-pages

data-pages: data-home data-principles data-available data-amazon data-github data-knownknowns data-pullrequest

data-download-pages:
	@make OUT=data/knownknowns.html \
	      URL=$(WOF_DATA_REPO)README.KNOWN.KNOWNS.md \
	      page-download
	@make OUT=data/pullrequest.html \
	      URL=$(WOF_DATA_REPO)PULL_REQUEST_TEMPLATE_NEIGHBOURHOOD.md \
	      page-download

data-page-level1:
	@make NAV_LINK=data SUBNAV_DIR=data page-level1

data-page-level2:
	@make SUBNAV_DIR=data \
	      SECTION_TITLE='Data' \
	      NAV_LINK='data' \
	      page-level2

data-home:
	@make CONTENT=data/data.html \
	      OUT=data/index.html \
	      PAGE_TITLE='Data' \
	      data-page-level1

data-principles:
	@make CONTENT=data/principles.html \
	      OUT=data/principles/index.html \
	      PAGE_TITLE='Data Principles' \
	      SIDENAV_LINK='data principles' \
	      data-page-level2

data-available:
	@make CONTENT=data/available.html \
	      OUT=data/available/index.html \
	      PAGE_TITLE='Available Data' \
	      SIDENAV_LINK='available data' \
	      data-page-level2

data-amazon:
	@make CONTENT=data/amazon.html \
	      OUT=data/amazon/index.html \
	      PAGE_TITLE='Amazon S3' \
	      SIDENAV_LINK='amazon s3' \
	      data-page-level2

data-github:
	@make CONTENT=data/github.html \
	      OUT=data/github/index.html \
	      PAGE_TITLE='GitHub' \
	      SIDENAV_LINK='github' \
	      data-page-level2

data-knownknowns:
	@make CONTENT=data/knownknowns.html \
	      OUT=data/knownknowns/index.html \
	      PAGE_TITLE='Known Knowns' \
	      SIDENAV_LINK='known knowns' \
	      data-page-level2

data-pullrequest:
	@make CONTENT=data/pullrequest.html \
	      OUT=data/pullrequest/index.html \
	      PAGE_TITLE='Pull Request Template' \
	      SIDENAV_LINK='pull request template' \
	      data-page-level2
