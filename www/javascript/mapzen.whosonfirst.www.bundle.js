var mapzen = mapzen || {};
mapzen.whosonfirst = mapzen.whosonfirst || {};

mapzen.whosonfirst.chrome = (function(){

	var self = {

		'init': function() {

			var host = location.host;

			if (host == "whosonfirst.mapzen.com") {
				return;
			}

			var host_id = host.replace(".", "-");
			
			var host_el = document.createElement("div");
			host_el.setAttribute("id", "wof-host-" + host_id);
			host_el.setAttribute("class", "wof-host");

			host_el.appendChild(document.createTextNode(host));

			document.body.insertBefore(host_el, document.body.childNodes[0]);
		}
	};

	return self;
})();
window.addEventListener("load", function load(event){

	try {
		mapzen.whosonfirst.chrome.init();
	} catch (e) {
		console.log("Failed to initialize mapzen.whosonfirst.chrome, because " + e);
	}
	
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
				 m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
				})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
	
	ga('create', 'UA-47035811-6', 'auto');
	ga('send', 'pageview');
	
});
