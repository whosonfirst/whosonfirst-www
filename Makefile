mapzen:
	if test -e www/css/mapzen.css; then cp www/css/mapzen.css www/css/mapzen.css.bak; fi
	curl -s -o www/css/mapzen.css https://mapzen.com/common/styleguide/styles/blog.css