// Add a Mapzen API key
// To generate your key, go to https://mapzen.com/developers/
var api_key = 'mapzen-aetZmeQ';
// Add a map to the 'map' div
var melbournelocation = [-37.813963,144.965188,85775095,16,"Melbourne's Museum neighborhood"]
var chosenLocation = melbournelocation;

var map = L.Mapzen.map('map', {
    maxZoom: chosenLocation[3],
    scrollWheelZoom: false,
    tangramOptions: {
        scene: {
            import: [
                'https://mapzen.com/carto/refill-style/8/refill-style.zip', 'https://mapzen.com/carto/refill-style/8/themes/color-gray.zip',
				'https://mapzen.com/carto/refill-style/8/themes/detail-4.zip'
			],
            global: {
                sdk_mapzen_api_key: api_key,
                sdk_building_extrude: 'false'
            }
        }
    }
});

var lat = chosenLocation[0];
var lon = chosenLocation[1];
map.setView([lat, lon], chosenLocation[3]);
var locator = L.Mapzen.locator();
locator.setPosition('bottomright');
locator.addTo(map);

var markerStyle = {
    "weight": 2,
    "opacity": .6,
	"fillOpacity": .2,
    "radius": 9,
    "fillColor": "#888888",
	"color": "#888888"
};

// How we should handle each API result
var show_venue = function(place) {
    var marker = L.circleMarker({
        lat: place['geom:latitude'],
        lng: place['geom:longitude']
    }, markerStyle);
	map.addLayer(marker);
};

var create_venue_card = function(place) {
	var name = place['wof:name'];
	var id = place['wof:id'];
	var latitude = place['geom:latitude'];
	var longitude = place['geom:longitude'];
	var newdiv = document.createElement("DIV");
	newdiv.classList.add("whosonfirst-tutorial-result");
	newdiv.innerHTML = '<div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-interaction-id">34248723</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-header">San Sebastian</div><div class="whosonfirst-tutorial-individual-result-subheader">this is a county in El Salvador</div></div><div class="row whosonfirst-tutorial-result-subresults-container"><div class="whosonfirst-tutorial-subresult-row"><div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-key">belongs to</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col"><div><div class="whosonfirst-tutorial-individual-result-answer whosonfirst-tutorial-underline-interactive-answer">San Sebastian</div><div class="whosonfirst-tutorial-individual-result-answer-clue">(county)</div></div><div><div class="whosonfirst-tutorial-individual-result-answer whosonfirst-tutorial-underline-interactive-answer">San Sebastian</div><div class="whosonfirst-tutorial-individual-result-answer-clue">(county)</div></div><div><div class="whosonfirst-tutorial-individual-result-answer whosonfirst-tutorial-underline-interactive-answer">San Sebastian</div><div class="whosonfirst-tutorial-individual-result-answer-clue">(county)</div></div></div></div><div class="whosonfirst-tutorial-subresult-row"><div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-key">country</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col "><div class="whosonfirst-tutorial-individual-result-answer">US</div></div></div><div class="whosonfirst-tutorial-subresult-row"><div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-key">geomhash</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col "><div class="whosonfirst-tutorial-individual-result-answer">213123761238</div></div></div><div class="whosonfirst-tutorial-subresult-row"><div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-key">repo</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col "><div class="whosonfirst-tutorial-individual-result-answer">whosonfirst-data</div></div></div></div><button type="button" class="btn btn-default btn-lg btn-block whosonfirst-tutorial-button">view descendants</button>';
	newdiv.getElementsByClassName("whosonfirst-tutorial-interaction-id")[0].innerHTML = id;
	document.getElementById("whosonfirst-tutorial-result-box-container").append(newdiv);
}

// NOOP (we are using onprogress instead)
var onsuccess = function() { 
	console.log("Succesful query");
	return; 
};

// Just log errors to the JS console
var onerror = function(rsp) {
    console.error(rsp);
};

// Take all the API results and show them on the map
var onprogress = function(rsp) {
    console.log(rsp);
	if (rsp.places.length == 0) {
		console.log("Empty Response");
	}
    for (var i = 0; i < rsp.places.length; i++) {
        var place = rsp.places[i];
        show_venue(place);
		create_venue_card(place);
		console.log("Place Instance")
    }
};

function runWhosOnFirstAPI() {
    // Setup the API key
    mapzen.whosonfirst.api.set_handler('authentication', function() {
        return api_key;
    });
    // Get all the venues in the Flatiron District
    // See: https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getDescendants
	console.log(chosenLocation);
    var parent_id = chosenLocation[2];
    var method = 'whosonfirst.places.getDescendants';
    var data = {
        id: parent_id,
        per_page: 50,
        extras: 'geom:' // this gets us lat/lng coords
    };
    // Ok now we actually call the API
    mapzen.whosonfirst.api.execute_method(method, data, onprogress, onerror);
	
	//Tutorial Method Posted in Lower Box
	document.getElementById("tutorial-api-method").innerHTML = method;
	document.getElementById("whosonfirst-tutorial-form-longitude").value = chosenLocation[1];
	document.getElementById("whosonfirst-tutorial-form-latitude").value = chosenLocation[0];
	document.getElementById("whosonfirst-tutorial-form-radius").value = 21;
	document.getElementById("whosonfirst-tutorial-form-max-longitude").value = chosenLocation[1];
	document.getElementById("whosonfirst-tutorial-form-max-latitude").value = chosenLocation[0];
	document.getElementById("whosonfirst-tutorial-form-min-longitude").value = chosenLocation[1];
	document.getElementById("whosonfirst-tutorial-form-min-latitude").value = chosenLocation[0];
};

function retrieveInputCoordinates() {
	console.log(document.getElementById("whosonfirst-tutorial-form-longitude").value);
	var chosenParent = document.getElementById("whosonfirst-tutorial-form-longitude").value;
	
	document.getElementById("whosonfirst-tutorial-result-box-container").innerHTML = "";
	
	/*
	while (document.getElementById("whosonfirst-tutorial-result-box-container").firstChild) {
		document.getElementById("whosonfirst-tutorial-result-box-container").removeChild();
	};
	*/
	
	console.log("Cleared all children")
	// Setup the API key
    mapzen.whosonfirst.api.set_handler('authentication', function() {
        return api_key;
    });
    // Get all the venues in the Flatiron District
    // See: https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getDescendants
    var parent_id = chosenParent;
    var method = 'whosonfirst.places.getDescendants';
    var data = {
        id: parent_id,
        per_page: 50,
        extras: 'geom:' // this gets us lat/lng coords
    };
    // Ok now we actually call the API
    mapzen.whosonfirst.api.execute_method(method, data, onprogress, onerror);
	
	//Tutorial Method Posted in Lower Box
	document.getElementById("whosonfirst-tutorial-form-longitude").value = chosenParent;
	document.getElementById("whosonfirst-tutorial-form-latitude").value = chosenParent;
	document.getElementById("whosonfirst-tutorial-form-radius").value = chosenParent;
	
	console.log("Updated Input Selections");
	
	/*Using Filderstatt where Stuttgart has an airport, id is 101761809*/
}

function clickPointButton() {
	if (document.getElementById("whosonfirst-tutorial-top-side-plane-button").classList.contains("whosonfirst-tutorial-top-side-button-activate")) {
		document.getElementById("whosonfirst-tutorial-top-side-plane-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		document.getElementById("whosonfirst-tutorial-input-plane-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated");
		document.getElementById("whosonfirst-tutorial-top-side-point-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		setTimeout(function() {document.getElementById("whosonfirst-tutorial-input-point-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated")},1600);
	} else {
		document.getElementById("whosonfirst-tutorial-top-side-point-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		document.getElementById("whosonfirst-tutorial-input-point-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated");
	}
}

function clickPlaneButton() {
	if (document.getElementById("whosonfirst-tutorial-top-side-point-button").classList.contains("whosonfirst-tutorial-top-side-button-activate")) {
		document.getElementById("whosonfirst-tutorial-top-side-point-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		document.getElementById("whosonfirst-tutorial-input-point-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated");
		document.getElementById("whosonfirst-tutorial-top-side-plane-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		setTimeout(function() {document.getElementById("whosonfirst-tutorial-input-plane-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated")},1600);
	} else {
		document.getElementById("whosonfirst-tutorial-top-side-plane-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		document.getElementById("whosonfirst-tutorial-input-plane-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated");
	}
}

function deactivateTutorialInfo() {
	document.getElementById("whosonfirst-tutorial-info-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},1600);
	document.getElementById("whosonfirst-tutorial-results-container").classList.toggle("whosonfirst-tutorial-results-container-activated");
	document.getElementsByClassName("leaflet-right")[1].classList.toggle("leaflet-right-activated");
}

function customSearch() {
	console.log(document.getElementById("search-text-go").value);
	
	document.getElementById("whosonfirst-tutorial-result-box-container").innerHTML = "";
	
	while (document.getElementById("whosonfirst-tutorial-result-box-container").firstChild) {
		document.getElementById("whosonfirst-tutorial-result-box-container").removeChild();
	};
	
	console.log("Cleared all children")
	// Setup the API key
    mapzen.whosonfirst.api.set_handler('authentication', function() {
        return api_key;
    });
    // Get all the venues in the Flatiron District
    // See: https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getDescendants
    var search_terms = document.getElementById("search-text-go").value;
	console.log("Search Terms: " + search_terms);
    var method = 'whosonfirst.places.search';
    var data = {
        q: search_terms,
		locality_id: 101933229,
        per_page: 50,
        extras: 'geom:' // this gets us lat/lng coords
    };
	console.log(data);
	
    // Ok now we actually call the API
    mapzen.whosonfirst.api.execute_method(method, data, onprogress, onerror);
	
	//Tutorial Method Posted in Lower Box
	document.getElementById("whosonfirst-tutorial-form-longitude").value = search_terms;
	document.getElementById("whosonfirst-tutorial-form-latitude").value = search_terms;
	document.getElementById("whosonfirst-tutorial-form-radius").value = search_terms;
	
	console.log("Updated Input Selections");
	
	/*Using Filderstatt where Stuttgart has an airport, id is 101761809*/
}

function getByLatLonRadius() {
	
	document.getElementById("whosonfirst-tutorial-result-box-container").innerHTML = "";
	
	while (document.getElementById("whosonfirst-tutorial-result-box-container").firstChild) {
		document.getElementById("whosonfirst-tutorial-result-box-container").removeChild();
	};
	
	console.log("Cleared all children")
	// Setup the API key
    mapzen.whosonfirst.api.set_handler('authentication', function() {
        return api_key;
    });
    // Get all the venues in the Flatiron District
    // See: https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getDescendants
    var search_latitude = document.getElementById("whosonfirst-tutorial-form-latitude").value;
	var search_longtitude = document.getElementById("whosonfirst-tutorial-form-longitude").value;
	var search_radius = document.getElementById("whosonfirst-tutorial-form-radius").value;
	if (search_radius == null || search_radius == "") {
		search_radius = 1;
	}
	
	console.log("Search Terms: " + search_radius + search_latitude + search_longtitude);
	
    var method = 'whosonfirst.places.getNearby';
    var data = {
        latitude: search_latitude,
		longitude: search_longtitude,
		radius: search_radius,
        per_page: 50,
        extras: 'geom:' // this gets us lat/lng coords
    };
	console.log(data);
	
    // Ok now we actually call the API
    mapzen.whosonfirst.api.execute_method(method, data, onprogress, onerror);
	
	
	console.log("Updated Input Selections");
	
	/*Using Filderstatt where Stuttgart has an airport, id is 101761809*/
}

function getByMaxAndMinLatLonRadius() {
	
	document.getElementById("whosonfirst-tutorial-result-box-container").innerHTML = "";
	
	while (document.getElementById("whosonfirst-tutorial-result-box-container").firstChild) {
		document.getElementById("whosonfirst-tutorial-result-box-container").removeChild();
	};
	
	console.log("Cleared all children")
	// Setup the API key
    mapzen.whosonfirst.api.set_handler('authentication', function() {
        return api_key;
    });
    // Get all the venues in the Flatiron District
    // See: https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getDescendants
    var search_max_latitude = document.getElementById("whosonfirst-tutorial-form-max-latitude").value;
	var search_min_latitude = document.getElementById("whosonfirst-tutorial-form-min-latitude").value;
	var search_max_longtitude = document.getElementById("whosonfirst-tutorial-form-max-longitude").value;
	var search_min_longtitude = document.getElementById("whosonfirst-tutorial-form-min-longitude").value;

	console.log("Search Terms: max" + search_max_latitude + "min" + search_min_latitude + "max" + search_max_longtitude + "min" + search_min_longtitude);
	
    var method = 'whosonfirst.places.getIntersects';
    var data = {
        max_latitude: search_max_latitude,
		min_latitude: search_min_latitude,
		max_longitude: search_max_longtitude,
		min_longitude: search_min_longtitude,
        per_page: 50,
        extras: 'geom:' // this gets us lat/lng coords
    };
	console.log(data);
	
    // Ok now we actually call the API
    mapzen.whosonfirst.api.execute_method(method, data, onprogress, onerror);
	
	
	console.log("Updated Input Selections");
	
	/*Using Filderstatt where Stuttgart has an airport, id is 101761809*/
}