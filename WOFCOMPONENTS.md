# WOF Components

All WOF pages (except for the home page) are built utilizing components. The current website has four different types of components: head components, footer components, navbar components, and subnav components (in which there are subnav-top and subnav-bottom components). These components along with content from GitHub and custom html pages make up all of the subpages on the WOF website.

## Head Components

Currently, there are three head components. A component for first level pages (head-onelevelup.html), second level pages (head.html), and third level pages (head-oneleveldown.html). The pages only differ in their url and the number of levels those urls traverse back.

The head.html file looks like:

```
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Who’s On First</title>
        <meta name='description' content="Who's on First is a gazetteer of places.">
        <link rel='apple-touch-icon' href='../../images/favicons/apple-touch-icon.png' sizes='180x180'>
        <link rel='icon' type='image/png' href='../../images/favicons/favicon-16x16.png' sizes='16x16'>
        <link rel='icon' type='image/png' href='../../images/favicons/favicon-32x32.png' sizes='32x32'>
        <link rel='manifest' href='../../images/favicons/manifest.json'>
        <link rel='mask-icon' href='../../images/favicons/safari-pinned-tab.svg' color='#2C1E3F'>

        <link rel="stylesheet" href="../../css/bootstrap.min.css">
        <link rel="stylesheet" href="../../css/mapzen.whosonfirst.css">
    </head>
    <body>
        <div class="whosonfirst-wrapper">
```
The head component includes the beginning html tag, the head content, and the very beginning of the body.

## Footer Components

Currently, there are three footer components. A component for first level pages (footer-onelevelup.html), second level pages (footer.html), and third level pages (footer-oneleveldown.html). The pages only differ in their url and the number of levels those urls traverse back.

The footer.html looks like:

```
								</div>
							</div>
						</article>
					</div>
					<div class="col-lg-2 col-md-0 col-sm-0 col-xs-0"></div>
				</div>
			</div>
		</div>
		<footer>
			<nav class="navbar navbar-default navbar-bottom">
				<div class="container">
					<!-- Collect the nav links, forms, and other content for toggling -->
                    <ul class="nav navbar-nav navbar-right whosonfirst-footer">
                        <li class="whosonfirst-nav-link-nounderline whoosonfooter-gig">who's on first is a <a href="https://mapzen.com/" class="whosonfirst-nav-link whosonfirst-nav-link-innounderline">mapzen</a> gig</li>
                        <li><a href="../../docs/contributing/" class="whosonfirst-nav-link whosonfirst-footer-nav-link">contributing</a></li>
                        <li><a href="../../docs/licensing/" class="whosonfirst-nav-link whosonfirst-footer-nav-link">licensing</a></li>
                        <li><a href="https://github.com/whosonfirst" class="whosonfirst-nav-link whosonfirst-footer-nav-link">code github</a></li>
                        <li><a href="https://github.com/whosonfirst-data" class="whosonfirst-nav-link whosonfirst-footer-nav-link">data github</a></li>
                        <li><a href="https://twitter.com/alloftheplaces/" class="whosonfirst-nav-link whosonfirst-footer-nav-link">twitter</a></li>
                    </ul>
                </div>
            </nav>
        </footer>
		
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="../../javascript/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="../../javascript/bootstrap.min.js"></script>
        <script src="../../javascript/mapzen.whosonfirst.subpage.js"></script>
    </body>
</html>
```
The footer component includes a bunch of closing div tags, the last column div tags, the footer, and all necessary JavaScript scripts.

## Navbar Components

Currently, there are three navbar components. A component for first level pages (navbar-onelevelup.html), second level pages (navbar.html), and third level pages (navbar-oneleveldown.html). The pages only differ in their url and the number of levels those urls traverse back.

Only first levels that have a second level are included in the navbar. If a first level does not have a second level, it should not be in the navbar, but should have a card on the home page.

The navbar.html looks like:

```
<nav class="navbar navbar-default navbar-fixed-top whosonfirst-fixed-subpage-navbar">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="../../">Who's On First</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<li class="whosonfirst-navbar-element-collapsed">
					<a href="../../allthedata/" class="whosonfirst-nav-link whosonfirst-nav-link-collapsed">data</a>
				</li>
				<li class="whosonfirst-navbar-element-collapsed">
					<a href="../../docs/" class="whosonfirst-nav-link whosonfirst-nav-link-collapsed">docs</a>
				</li>
				<li class="whosonfirst-navbar-element-collapsed">
					<a href="../../tools/" class="whosonfirst-nav-link whosonfirst-nav-link-collapsed">tools</a>
				</li>
				<li class="whosonfirst-navbar-element-collapsed">
					<a href="../../blog/" class="whosonfirst-nav-link whosonfirst-nav-link-collapsed">blog</a>
				</li>
				<li class="whosonfirst-navbar-element-collapsed">
					<a href="../../getstarted/" class="whosonfirst-nav-link whosonfirst-nav-link-collapsed">get started</a>
				</li>
			</ul>
		</div><!-- /.navbar-collapse -->
	</div><!-- /.container-fluid -->
</nav>
```
The navbar component includes the navbar including the toggle button for mobile screen sizes and the necessary links.

## Subnav Components

Currently, there are around twenty or thirty so subnav components. These are seperated by based on first levels. Some of those first levels have folders with second level folders. Within each folder, you will be able to find top and bottom subnavs. The subnavs are either for that specific layer (subnav-top.html), the layer above (subnav-top-onelevelup.html), or the layer below (subnav-top-oneleveldown.html).

### Subnav Top Components

A subnav-top.html file looks like:

```
<div class="container whosonfirst-subpage-container">
	<div class="row">
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-0">
			<aside>
				<div class="whosonfirst-sidenav-container">
					<ul class="whosonfirst-sidenav-list">
						<li class="whosonfirst-sidenav-list-element">
							<a href="../properties/" class="whosonfirst-nav-link whosonfirst-sidenav-link">properties</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/addr/" class="whosonfirst-nav-link whosonfirst-sidenav-link">addr</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/edtf/" class="whosonfirst-nav-link whosonfirst-sidenav-link">edtf</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/geom/" class="whosonfirst-nav-link whosonfirst-sidenav-link">geom</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/lbl/" class="whosonfirst-nav-link whosonfirst-sidenav-link">lbl</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/mz/" class="whosonfirst-nav-link whosonfirst-sidenav-link">mz</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/name/" class="whosonfirst-nav-link whosonfirst-sidenav-link">name</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/resto/" class="whosonfirst-nav-link whosonfirst-sidenav-link">resto</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/reversegeo/" class="whosonfirst-nav-link whosonfirst-sidenav-link">reversegeo</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/src/" class="whosonfirst-nav-link whosonfirst-sidenav-link">src</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/wof/" class="whosonfirst-nav-link whosonfirst-sidenav-link">wof</a>
						</li>
						<li class="whosonfirst-sidenav-list-element whosonfirst-sidenav-list-element-secondlevel">
							<a href="../properties/brooklynintegers/" class="whosonfirst-nav-link whosonfirst-sidenav-link">brooklyn integers</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../concordances/" class="whosonfirst-nav-link whosonfirst-sidenav-link">concordances</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../placetypes/" class="whosonfirst-nav-link whosonfirst-sidenav-link">placetypes</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../hierachies/" class="whosonfirst-nav-link whosonfirst-sidenav-link">hierachies</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../names/" class="whosonfirst-nav-link whosonfirst-sidenav-link">names</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../geometries/" class="whosonfirst-nav-link whosonfirst-sidenav-link">geometries</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../dates/" class="whosonfirst-nav-link whosonfirst-sidenav-link">dates</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../categories/" class="whosonfirst-nav-link whosonfirst-sidenav-link">categories</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../sources/" class="whosonfirst-nav-link whosonfirst-sidenav-link">sources</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../tests/" class="whosonfirst-nav-link whosonfirst-sidenav-link">tests</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../contributing/" class="whosonfirst-nav-link whosonfirst-sidenav-link">contributing</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../licensing/" class="whosonfirst-nav-link whosonfirst-sidenav-link">licensing</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../processes/" class="whosonfirst-nav-link whosonfirst-sidenav-link">processes and workflows</a>
						</li>
						<li class="whosonfirst-sidenav-list-element">
							<a href="../keyterms/" class="whosonfirst-nav-link whosonfirst-sidenav-link">key terms</a>
						</li>
					</ul>
				</div>
			</aside>
		</div>
		<div class="col-lg-7 col-md-9 col-sm-9 col-xs-12">
			<article>
```

The subnav-top component includes all the necessary second-level and third-level links for the related first-level.

### Subnav Bottom Components

A subnav-bottom.html files looks like:

```
<div class="whosonfirst-fulltabs-container">
	<div class="whosonfirst-extrasmall-tabs-menu">
		<div class="whosonfirst-extrasmall-tabs-menu-content">
			<div class="whosonfirst-extrasmall-tabs-menu-content-header">
				<div class="row whosonfirst-extrasmall-menu-row">
					<div class="col-xs-11">
						<div class="whosonfirst-extrasmall-tab-selection">Properties</div>
					</div>
					<div class="col-xs-1 whosonfirst-extrasmall-menu-chevron-col">
						<button type="button" class="navbar-toggle collapsed whosonfirst-extrasmall-menu-chevron-down" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2" aria-expanded="false">
							<span id="glyphicon-one" class="glyphicon glyphicon-menu-down whosonfirst-extrasmall-menu-actual-chevron-down"></span>
						</button>
					</div>
				</div>
			</div>
			<div class="collapse" id="bs-example-navbar-collapse-2">
				<div class="whosonfirst-extrasmall-nav-collection">
					<ul class="nav navbar-nav navbar-right whosonfirst-extrasmall-nav">
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">properties</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/addr/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">addr</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/edtf/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">edtf</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/geom/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">geom</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/lbl/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">lbl</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/mz/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">mz</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/name/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">name</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/resto/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">resto</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/reversegeo/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">reversegeo</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/src/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">src</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/wof/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">wof</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../properties/brooklynintegers/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-subnav-secondlevel">brooklyn integers</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../concordances/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">concordances</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../placetypes/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">placetypes</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../hierachies/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">hierachies</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../names/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">names</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../geometries/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">geometries</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../dates/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">dates</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../categories/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">categories</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../sources/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">sources</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../tests/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">tests</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../contributing/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">contributing</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../licensing/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">licensing</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element">
							<a href="../processes/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed">processes and workflows</a>
						</li>
						<li class="whosonfirst-navbar-element-collapsed whosonfirst-extrasmall-nav-element  whosonfirst-extrasmall-nav-link-collapsed-last">
							<a href="../keyterms/" class="whosonfirst-nav-link whosonfirst-extrasmall-nav-link-collapsed whosonfirst-extrasmall-nav-link-collapsed-last">key terms</a>
						</li>
					</ul>
				</div>
			</div><!-- /.navbar-collapse -->
		</div>
	</div>
	<div class="whosonfirst-tabs-content">
```

The subnav-bottom component includes all the necessary second-level and third-level links for the related first-level.