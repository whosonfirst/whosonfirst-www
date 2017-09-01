blog: blog-download-content blog-build-pages

blog-download-content:

blog-clone-posts:
	utils/clone-blog.sh

blog-build-pages: \
	blog-home

blog-build-page-level1:
	@make NAV_LINK=blog SUBNAV_DIR=blog build-page-level1

blog-home:
	@make CONTENT=blog/blog.html \
	      OUT=blog/index.html \
	      PAGE_TITLE='Blog' \
	      blog-build-page-level1
