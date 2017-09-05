WOF_DATA_REPO := https://github.com/whosonfirst-data/whosonfirst-data/blob/master/

data: data-download-content data-build-pages

data-download-content: \
	data-download-knownknowns \
	data-download-pullrequest

data-download-knownknowns:
	@make URL=$(WOF_DATA_REPO)README.KNOWN.KNOWNS.md \
	      OUT=data/knownknowns.html \
	      download-content

data-download-pullrequest:
	@make URL=$(WOF_DATA_REPO)PULL_REQUEST_TEMPLATE_NEIGHBOURHOOD.md \
	      OUT=data/pullrequest.html \
	      download-content

data-build-pages: \
	data-home \
	data-principles \
	data-available \
	data-amazon \
	data-github \
	data-knownknowns \
	data-pullrequest

data-build-page-level1:
	@make NAV_LINK=data SUBNAV_DIR=data build-page-level1

data-build-page-level2:
	@make SUBNAV_DIR=data \
	      SECTION_TITLE='Data' \
	      NAV_LINK='data' \
	      build-page-level2

data-home:
	@make CONTENT=data/data.html \
	      OUT=data/index.html \
	      PAGE_TITLE='Data' \
	      data-build-page-level1

data-principles:
	@make CONTENT=data/principles.html \
	      OUT=data/principles/index.html \
	      PAGE_TITLE='Data Principles' \
	      SUBNAV_LINK='data principles' \
	      data-build-page-level2

data-available:
	@make CONTENT=data/available.html \
	      OUT=data/available/index.html \
	      PAGE_TITLE='Available Data' \
	      SUBNAV_LINK='available data' \
	      data-build-page-level2

data-amazon:
	@make CONTENT=data/amazon.html \
	      OUT=data/amazon/index.html \
	      PAGE_TITLE='Amazon S3' \
	      SUBNAV_LINK='amazon s3' \
	      data-build-page-level2

data-github:
	@make CONTENT=data/github.html \
	      OUT=data/github/index.html \
	      PAGE_TITLE='GitHub' \
	      SUBNAV_LINK='github' \
	      data-build-page-level2

data-knownknowns:
	@make CONTENT=data/knownknowns.html \
	      OUT=data/knownknowns/index.html \
	      PAGE_TITLE='Known Knowns' \
	      SUBNAV_LINK='known knowns' \
	      data-build-page-level2

data-pullrequest:
	@make CONTENT=data/pullrequest.html \
	      OUT=data/pullrequest/index.html \
	      PAGE_TITLE='Pull Request Template' \
	      SUBNAV_LINK='pull request template' \
	      data-build-page-level2
