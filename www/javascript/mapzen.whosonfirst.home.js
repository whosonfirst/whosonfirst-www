(function() {

	if (! document.getElementById('chosen-background-image')) {
		return;
	}

	var visualizations = [
		{
			background: '/images/home/berlin.png',
			description: 'venues in Berlin',
			curl: "curl -X GET 'https://places.mapzen.com/v1?method=whosonfirst.places.getDescendants&id=85899637&extras=geom:&api_key=your-mapzen-api-key'",
			response: '{"stat":"ok","places":[{"wof:id":102562251,"wof:parent_id":"85899637","wof:name":"Gerhard Heerlein & S\u00f6hne Ohg","wof:placetype":"venue","wof:country":"DE","wof:repo":"whosonfirst-data-venue-de","geom:bbox":"13.364605,52.492085,13.364605,52.492085","geom:longitude":13.364605,"geom:type":"Point","geom:area":0,"geom:latitude":52.492085}, ... ]}'
		}, {
			background: '/images/home/nyc.png',
			description: 'venues in New York City',
			curl: "curl -X GET 'https://places.mapzen.com/v1?method=whosonfirst.places.getDescendants&id=85869245&extras=geom:&api_key=your-mapzen-api-key'",
			response: '{"stat":"ok","places":[{"wof:id":186010571,"wof:parent_id":"85869245","wof:name":"Opal Center for Massage and Allied Therapies","wof:placetype":"venue","wof:country":"US","wof:repo":"whosonfirst-data-venue-us-ny","geom:bbox":"-73.990638,40.740063,-73.990638,40.740063","geom:longitude":-73.990638,"geom:type":"Point","geom:area":0,"geom:latitude":40.740063,"geom:area_square_m":"0.0"}, ... ]}'
		}, {
			background: '/images/home/seoul.png',
			description: 'neighbourhoods in Seoul',
			curl: "curl -X GET 'https://places.mapzen.com/v1?method=whosonfirst.places.getDescendants&id=102026327&extras=geom:,mz:uri&api_key=your-mapzen-api-key'",
			response: '{"stat":"ok","places":[{"wof:id":85925593,"wof:parent_id":"102026327","wof:name":"\uc5ed\uace11\ub3d9","wof:placetype":"neighbourhood","wof:country":"KO","wof:repo":"whosonfirst-data","geom:longitude":126.815558,"geom:type":"Polygon","geom:area":0.000501,"geom:bbox":"126.802438965,37.4713969976,126.830758003,37.5001147002","geom:latitude":37.485009,"geom:area_square_m":"4912838.48381","mz:uri":"https:\/\/whosonfirst.mapzen.com\/data\/859\/255\/93\/85925593.geojson"}, ... ]}'
		}, {
			background: '/images/home/sf.png',
			description: 'neighbourhoods in San Francisco',
			curl: "curl -X GET 'https://places.mapzen.com/v1?method=whosonfirst.places.getDescendants&id=85922583&extras=geom:,mz:uri&api_key=your-mapzen-api-key'",
			response: '{"stat":"ok","places":[{"wof:id":85810881,"wof:parent_id":"1108830801","wof:name":"Chinatown","wof:placetype":"neighbourhood","wof:country":"US","wof:repo":"whosonfirst-data","geom:longitude":-122.406569,"geom:type":"Polygon","geom:bbox":"-122.410263524,37.790366311,-122.402957361,37.797864612","geom:latitude":37.794492,"geom:area_square_m":"318288.42697","geom:area":3.3e-5,"mz:uri":"https:\/\/whosonfirst.mapzen.com\/data\/858\/108\/81\/85810881.geojson"}, ... ]}'
		}
	];

	var visualization_index = Math.floor(Math.random() * visualizations.length);
	var visualization = visualizations[visualization_index];

	document.getElementById("chosen-background-image").src = visualization.background;
	document.getElementById("whosonfirst-card-map-code-content").innerHTML = visualization.curl;
	document.getElementById("whosonfirst-custom-card-map-explanation-content").innerHTML = visualization.description;
	document.getElementById("whosonfirst-card-map-code-content-response").innerHTML = visualization.response;

})();
