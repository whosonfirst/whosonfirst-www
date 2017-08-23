// Add a Mapzen API key
// To generate your key, go to https://mapzen.com/developers/
var api_key = 'mapzen-aetZmeQ';
// Add a map to the 'map' div
var startingLocation = [40.74456010000001, -73.99019279999999,16]

var map = L.Mapzen.map('map', {
    maxZoom: startingLocation[2],
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

var lat = startingLocation[0];
var lon = startingLocation[1];
map.setView([lat, lon], startingLocation[2]);
var locator = L.Mapzen.locator();
locator.setPosition('bottomright');
locator.addTo(map);
var current_markers = [];
var last_active_marker;
var last_active_point_click;
var marker_click_active = false;
var plane_click_active = false;
var active_plane_clicks = [];
var active_plane_click_number = 0;
var planePolygon;

/*Get Point Coordinates When Point Button Activated*/

map.on('click', function(e) {
	if (document.getElementById("whosonfirst-tutorial-top-side-point-button").classList.contains("whosonfirst-tutorial-top-side-button-activate")) {
		setTimeout(function() {
			if (!marker_click_active) {
				if (last_active_point_click) {
					map.removeLayer(last_active_point_click);
				}
				if (document.getElementById("whosonfirst-tutorial-top-side-point-button").classList.contains("whosonfirst-tutorial-top-side-button-activate")) {
					document.getElementById("whosonfirst-tutorial-form-latitude").value = e.latlng.lat;
					document.getElementById("whosonfirst-tutorial-form-longitude").value = e.latlng.lng;
					if (!document.getElementById("whosonfirst-tutorial-form-radius").value) {
						document.getElementById("whosonfirst-tutorial-form-radius").value = 0;	
					}
					last_active_point_click = new L.marker(e.latlng,{icon: myIcon}).addTo(map);
					console.log(marker_click_active);
					marker_click_active = false;
				}
			}
		},100);
	} else if (document.getElementById("whosonfirst-tutorial-top-side-plane-button").classList.contains("whosonfirst-tutorial-top-side-button-activate")) {
		setTimeout(function() {
			console.log(marker_click_active);
			if (!marker_click_active) {
				if (active_plane_clicks.length == 4) {
					console.log("Were in here");
					map.removeLayer(active_plane_clicks[0]);
					map.removeLayer(active_plane_clicks[1]);
					map.removeLayer(active_plane_clicks[2]);
					map.removeLayer(active_plane_clicks[3]);
					map.removeLayer(planePolygon);
					document.getElementById("whosonfirst-tutorial-form-max-latitude").value = null;
					document.getElementById("whosonfirst-tutorial-form-min-latitude").value = null;
					document.getElementById("whosonfirst-tutorial-form-max-longitude").value = null;
					document.getElementById("whosonfirst-tutorial-form-min-longitude").value = null;
					console.log(active_plane_clicks);
					active_plane_clicks.splice(0);
					active_plane_click_number = 0;
					console.log(active_plane_clicks);
				}
				if (active_plane_clicks.length < 4) {
					var click_number = "active_click_number_" + active_plane_click_number;
					active_plane_clicks[active_plane_click_number] = new L.marker(e.latlng,{icon: myIcon}).addTo(map);
					active_plane_click_number++;
					console.log(active_plane_clicks);
				}
				if (active_plane_clicks.length == 4) {
					document.getElementById("whosonfirst-tutorial-form-max-latitude").value = Math.max(active_plane_clicks[0]._latlng.lat,active_plane_clicks[1]._latlng.lat,active_plane_clicks[2]._latlng.lat,active_plane_clicks[3]._latlng.lat);
					document.getElementById("whosonfirst-tutorial-form-min-latitude").value = Math.min(active_plane_clicks[0]._latlng.lat,active_plane_clicks[1]._latlng.lat,active_plane_clicks[2]._latlng.lat,active_plane_clicks[3]._latlng.lat);
					document.getElementById("whosonfirst-tutorial-form-max-longitude").value = Math.max(active_plane_clicks[0]._latlng.lng,active_plane_clicks[1]._latlng.lng,active_plane_clicks[2]._latlng.lng,active_plane_clicks[3]._latlng.lng);
					document.getElementById("whosonfirst-tutorial-form-min-longitude").value = Math.min(active_plane_clicks[0]._latlng.lng,active_plane_clicks[1]._latlng.lng,active_plane_clicks[2]._latlng.lng,active_plane_clicks[3]._latlng.lng);
					var polygonlatlngs = [active_plane_clicks[0]._latlng,active_plane_clicks[1]._latlng,active_plane_clicks[2]._latlng,active_plane_clicks[3]._latlng];
					planePolygon = new L.polygon(polygonlatlngs, {color: '#FE189B', opacity: '0', fillColor: '#FE189B', fillOpacity: '.2'}).addTo(map);
					console.log(polygonlatlngs);
				}	
				marker_click_active = false;
			}
		},100);
	};
});

var markerStyle = {
    "weight": 2,
    "opacity": .6,
	"fillOpacity": .2,
    "radius": 9,
    "fillColor": "#888888",
	"color": "#888888"
};

var myIcon = L.icon({
    iconUrl: '../css/images/marker-icon.png',
    iconAnchor: [14, 38]
});

// How we should handle each API result
var show_venue = function(place) {
    var marker = L.circleMarker({
        lat: place['geom:latitude'],
        lng: place['geom:longitude']
    }, markerStyle);
	marker.on('click', function(ev) {
		scrollTo(place['wof:id']);
		marker_click_active = true;
		setTimeout(function() {
			marker_click_active = false;
		},500);
	});
	map.addLayer(marker);
	current_markers.push(marker);
	console.log(marker_click_active)
};

var create_venue_card = function(place) {
	var name = place['wof:name'];
	var id = place['wof:id'];
	var latitude = place['geom:latitude'];
	var longitude = place['geom:longitude'];
	var type_of_place = place['wof:placetype'];
	var parent_id = place['wof:parent_id'];
	var repo = place['wof:repo'];
	var newdiv = document.createElement("DIV");
	newdiv.classList.add("whosonfirst-tutorial-result");
	newdiv.id = id;
	newdiv.innerHTML = '<div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-interaction-id">34248723</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col"><a class="whosonfirst-tutorial-individual-result-header whosonfirst-tutorial-individual-result-url"></a><div class="whosonfirst-tutorial-individual-result-subheader">this is a <span class="whosonfirst-tutorial-individual-result-subheader-focus"></span></div></div><div class="row whosonfirst-tutorial-result-subresults-container"><div class="whosonfirst-tutorial-subresult-row"><div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-key">latitude</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-answer whosonfirst-tutorial-individual-result-latitude"></div></div></div><div class="whosonfirst-tutorial-subresult-row"><div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-key">longitude</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-answer whosonfirst-tutorial-individual-result-longitude"></div></div></div><div class="whosonfirst-tutorial-subresult-row"><div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-key">parent id</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-answer whosonfirst-tutorial-individual-result-parent-id"></div></div></div><div class="whosonfirst-tutorial-subresult-row"><div class="col-lg-4 col-md-4 col-sm-4 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-key">repo</div></div><div class="col-lg-8 col-md-8 col-sm-8 whosonfirst-tutorial-result-col"><div class="whosonfirst-tutorial-individual-result-answer whosonfirst-tutorial-individual-result-repo"></div></div></div></div>';
	newdiv.getElementsByClassName("whosonfirst-tutorial-interaction-id")[0].innerHTML = id;
	newdiv.getElementsByClassName("whosonfirst-tutorial-individual-result-subheader-focus")[0].innerHTML = type_of_place;
	newdiv.getElementsByClassName("whosonfirst-tutorial-individual-result-latitude")[0].innerHTML = latitude;
	newdiv.getElementsByClassName("whosonfirst-tutorial-individual-result-longitude")[0].innerHTML = longitude;
	newdiv.getElementsByClassName("whosonfirst-tutorial-individual-result-parent-id")[0].innerHTML = parent_id;
	newdiv.getElementsByClassName("whosonfirst-tutorial-individual-result-repo")[0].innerHTML = repo;
	newdiv.getElementsByClassName("whosonfirst-tutorial-individual-result-header")[0].innerHTML = name;
	newdiv.getElementsByClassName("whosonfirst-tutorial-individual-result-url")[0].href = "https://whosonfirst.mapzen.com/spelunker/id/" + id + "/"
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
	for (var j = 0; j < current_markers.length; j++) {
		map.removeLayer(current_markers[j]);
	}
	if (rsp.places.length == 0) {
		console.log("Empty Response");
	}
    for (var i = 0; i < rsp.places.length; i++) {
        var place = rsp.places[i];
        show_venue(place);
		create_venue_card(place);
    }
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
		for (var x = 0; x < active_plane_click_number; x++) {
			map.removeLayer(active_plane_clicks[x]);
		}
		if (planePolygon) {
			map.removeLayer(planePolygon);
		}
		document.getElementById("whosonfirst-tutorial-form-max-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-min-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-max-longitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-min-longitude").value = null;
		active_plane_clicks.splice(0);
		active_plane_click_number = 0;
		last_active_marker = null;
	} else {
		document.getElementById("whosonfirst-tutorial-top-side-point-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		document.getElementById("whosonfirst-tutorial-input-point-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated");
		if (last_active_point_click) {
			map.removeLayer(last_active_point_click);
		}
		last_active_marker = null;
	}
}


function clickPlaneButton() {
	if (document.getElementById("whosonfirst-tutorial-top-side-point-button").classList.contains("whosonfirst-tutorial-top-side-button-activate")) {
		document.getElementById("whosonfirst-tutorial-top-side-point-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		document.getElementById("whosonfirst-tutorial-input-point-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated");
		if (last_active_point_click) {
			map.removeLayer(last_active_point_click);
		}
		document.getElementById("whosonfirst-tutorial-top-side-plane-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		setTimeout(function() {document.getElementById("whosonfirst-tutorial-input-plane-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated")},1600);
		last_active_marker = null;
	} else {
		document.getElementById("whosonfirst-tutorial-top-side-plane-button").classList.toggle("whosonfirst-tutorial-top-side-button-activate");
		document.getElementById("whosonfirst-tutorial-input-plane-container").classList.toggle("whosonfirst-tutorial-input-bottom-container-activated");
		for (var x = 0; x < active_plane_click_number; x++) {
			map.removeLayer(active_plane_clicks[x]);
		}
		if (planePolygon) {
			map.removeLayer(planePolygon);
		}
		document.getElementById("whosonfirst-tutorial-form-max-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-min-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-max-longitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-min-longitude").value = null;
		active_plane_clicks.splice(0);
		active_plane_click_number = 0;
		last_active_marker = null;
	}
}

function deactivateTutorialInfo1() {
	document.getElementById("whosonfirst-tutorial-info").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},1600);
	document.getElementById("whosonfirst-tutorial-results-container").classList.toggle("whosonfirst-tutorial-results-container-activated");
	document.getElementsByClassName("leaflet-right")[1].classList.toggle("leaflet-right-activated");
}

function nextTutorialInfo1() {
	document.getElementById("whosonfirst-tutorial-info-header-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-subheader-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-2").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-2").classList.toggle("whosonfirst-tutorial-info-image-deactivated")},1000);
	document.getElementById("whosonfirst-tutorial-info-1-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-2-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-2-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-2-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-2-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-progess-circle-2").classList.toggle("whosonfirst-tutorial-info-progess-circle-activated")},1000);
}

function nextTutorialInfo2() {
	document.getElementById("whosonfirst-tutorial-info-header-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-subheader-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-image-2").classList.toggle("whosonfirst-tutorial-info-image-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-2").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-3").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-3").classList.toggle("whosonfirst-tutorial-info-image-deactivated")},1000);
	document.getElementById("whosonfirst-tutorial-info-2-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-2-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-3-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-3-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-3-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-3-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-progess-circle-3").classList.toggle("whosonfirst-tutorial-info-progess-circle-activated")},1000);
}

function backTutorialInfo2() {
	document.getElementById("whosonfirst-tutorial-info-header-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-subheader-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-image-2").classList.toggle("whosonfirst-tutorial-info-image-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-2").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	document.getElementById("whosonfirst-tutorial-info-2-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-2-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-1-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-2-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-2-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-1").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-progess-circle-2").classList.toggle("whosonfirst-tutorial-info-progess-circle-activated")},1000);
}

function nextTutorialInfo3() {
	document.getElementById("whosonfirst-tutorial-info-header-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-subheader-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-image-3").classList.toggle("whosonfirst-tutorial-info-image-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-4").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-3").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-4").classList.toggle("whosonfirst-tutorial-info-image-deactivated")},1000);
	document.getElementById("whosonfirst-tutorial-info-3-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-3-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-4-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-4-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-4-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-4-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-4").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-4").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-4").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-4").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-progess-circle-4").classList.toggle("whosonfirst-tutorial-info-progess-circle-activated")},1000);
}

function backTutorialInfo3() {
	document.getElementById("whosonfirst-tutorial-info-header-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-subheader-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-image-3").classList.toggle("whosonfirst-tutorial-info-image-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-2").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-3").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-2").classList.toggle("whosonfirst-tutorial-info-image-deactivated")},1000);
	document.getElementById("whosonfirst-tutorial-info-3-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-3-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-2-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-2-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-3-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-3-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-2").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-progess-circle-3").classList.toggle("whosonfirst-tutorial-info-progess-circle-activated")},1000);
}

function nextTutorialInfo4() {
	document.getElementById("whosonfirst-tutorial-info").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},1600);
	document.getElementById("whosonfirst-tutorial-results-container").classList.toggle("whosonfirst-tutorial-results-container-activated");
	document.getElementsByClassName("leaflet-right")[1].classList.toggle("leaflet-right-activated");
}

function backTutorialInfo4() {
	document.getElementById("whosonfirst-tutorial-info-header-4").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-subheader-4").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-image-4").classList.toggle("whosonfirst-tutorial-info-image-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-4").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-4").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-3").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-4").classList.toggle("whosonfirst-tutorial-info-image-display")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-image-3").classList.toggle("whosonfirst-tutorial-info-image-deactivated")},1000);
	document.getElementById("whosonfirst-tutorial-info-4-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-4-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-3-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-3-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
	document.getElementById("whosonfirst-tutorial-info-4-back").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	document.getElementById("whosonfirst-tutorial-info-4-next").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-header-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-subheader-3").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},1000);
	setTimeout(function() {document.getElementById("whosonfirst-tutorial-info-progess-circle-4").classList.toggle("whosonfirst-tutorial-info-progess-circle-activated")},1000);
}

function openTutorialInfoFromSide() {
	document.getElementsByClassName("leaflet-right")[1].classList.toggle("leaflet-right-activated");
	document.getElementById("whosonfirst-tutorial-results-container").classList.toggle("whosonfirst-tutorial-results-container-activated");
	if (document.getElementById("whosonfirst-tutorial-info").classList.contains("whosonfirst-tutorial-info-container-deactivated-nodisplay")){
		document.getElementById("whosonfirst-tutorial-info").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay");
		setTimeout(function() {document.getElementById("whosonfirst-tutorial-info").classList.toggle("whosonfirst-tutorial-info-container-deactivated")},100);
	} else {
		document.getElementById("whosonfirst-tutorial-info").classList.toggle("whosonfirst-tutorial-info-container-deactivated");
		setTimeout(function() {document.getElementById("whosonfirst-tutorial-info").classList.toggle("whosonfirst-tutorial-info-container-deactivated-nodisplay")},800);
	}
}

function customSearch() {
	console.log(document.getElementById("search-text-go").value);
	
	document.getElementById("whosonfirst-tutorial-result-box-container").innerHTML = "";
	
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
		locality_id: 0,
        per_page: 100,
        extras: 'geom:,mz:' // this gets us lat/lng coords
    };
	console.log(data);
	map.setView([0, 0], 2);
	
    // Ok now we actually call the API
    mapzen.whosonfirst.api.execute_method(method, data, onprogress, onerror);
	
	console.log("Updated Input Selections");
	var customQuery = "curl -X GET 'https://whosonfirst-api.mapzen.com/?method=whosonfirst.places.search&api_key=your-mapzen-api-key&q="+search_terms+"&locality_id:0&extras=geom:,mz:&per_page=50'"
	if (document.getElementsByClassName("whosonfirst-tutorial-individual-code-box")[0].classList.contains("whosonfirst-api-initial-no-show")) {
		document.getElementsByClassName("whosonfirst-tutorial-individual-code-box")[0].classList.remove("whosonfirst-api-initial-no-show");
	}
	document.getElementById("tutorial-api-method").innerHTML = customQuery;
	
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
	if (search_latitude < -90 || search_latitude > 90) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-latitude").placeholder = "Invalid latitude";
		document.getElementById("whosonfirst-tutorial-form-latitude").classList.add("whosonfirst-error-messaging-tutorial");
		console.log(document.getElementById("whosonfirst-tutorial-form-latitude"));
		return;
	} else if (search_longtitude < -180 || search_longtitude > 180) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-longitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-longitude").placeholder = "Invalid latitude";
		document.getElementById("whosonfirst-tutorial-form-longitude").classList.add("whosonfirst-error-messaging-tutorial");
		return;
	} else if (!search_latitude) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-latitude").placeholder = "Missising latitude";
		document.getElementById("whosonfirst-tutorial-form-latitude").classList.add("whosonfirst-error-messaging-tutorial");
		console.log(document.getElementById("whosonfirst-tutorial-form-latitude"));
		return;
	} else if (!search_longtitude) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-longitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-longitude").placeholder = "Missing longitude";
		document.getElementById("whosonfirst-tutorial-form-longitude").classList.add("whosonfirst-error-messaging-tutorial");
		return;
	}
	
	document.getElementById("whosonfirst-tutorial-form-latitude").placeholder = "11.1243";
	document.getElementById("whosonfirst-tutorial-form-longitude").placeholder = "11.1243";
	if (document.getElementById("whosonfirst-tutorial-form-latitude").classList.contains("whosonfirst-error-messaging-tutorial")) {
		document.getElementById("whosonfirst-tutorial-form-latitude").classList.remove("whosonfirst-error-messaging-tutorial");
	};
	if (document.getElementById("whosonfirst-tutorial-form-longitude").classList.contains("whosonfirst-error-messaging-tutorial")) {
		document.getElementById("whosonfirst-tutorial-form-longitude").classList.remove("whosonfirst-error-messaging-tutorial");
	};
	
	console.log("Search Terms: " + search_radius + search_latitude + search_longtitude);
	
    var method = 'whosonfirst.places.getNearby';
    var data = {
        latitude: search_latitude,
		longitude: search_longtitude,
		radius: search_radius,
        per_page: 100,
        extras: 'geom:,mz:' // this gets us lat/lng coords
    };
	console.log(data);
	map.setView([search_latitude, search_longtitude], 14);
	
    // Ok now we actually call the API
    mapzen.whosonfirst.api.execute_method(method, data, onprogress, onerror);
	
	
	console.log("Updated Input Selections");
	
	/*Using Filderstatt where Stuttgart has an airport, id is 101761809*/
	
	var customQuery = "curl -X GET 'https://whosonfirst-api.mapzen.com/?method=whosonfirst.places.getNearby&api_key=your-mapzen-api-key&latitude="+search_latitude +"&longitude="+search_longtitude+"&search_radius="+search_radius+"&extras=geom:,mz:&per_page=50'"
	if (document.getElementsByClassName("whosonfirst-tutorial-individual-code-box")[0].classList.contains("whosonfirst-api-initial-no-show")) {
		document.getElementsByClassName("whosonfirst-tutorial-individual-code-box")[0].classList.remove("whosonfirst-api-initial-no-show");
	}
	document.getElementById("tutorial-api-method").innerHTML = customQuery;
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
	if (search_max_latitude < -90 || search_max_latitude > 90) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-max-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-max-latitude").placeholder = "Invalid latitude";
		document.getElementById("whosonfirst-tutorial-form-max-latitude").classList.add("whosonfirst-error-messaging-tutorial");
		console.log(document.getElementById("whosonfirst-tutorial-form-max-latitude"));
		return;
	} else if (search_max_longtitude < -180 || search_max_longtitude > 180) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-max-longitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-max-longitude").placeholder = "Invalid latitude";
		document.getElementById("whosonfirst-tutorial-form-max-longitude").classList.add("whosonfirst-error-messaging-tutorial");
		return;
	} else if (search_min_latitude < -90 || search_min_latitude > 90) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-min-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-min-latitude").placeholder = "Invalid latitude";
		document.getElementById("whosonfirst-tutorial-form-min-latitude").classList.add("whosonfirst-error-messaging-tutorial");
		console.log(document.getElementById("whosonfirst-tutorial-form-min-latitude"));
		return;
	} else if (search_min_longtitude < -180 || search_min_longtitude > 180) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-min-longitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-min-longitude").placeholder = "Invalid latitude";
		document.getElementById("whosonfirst-tutorial-form-min-longitude").classList.add("whosonfirst-error-messaging-tutorial");
		return;
	} else if (!search_max_longtitude) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-max-longitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-max-longitude").placeholder = "Missing maximum longitude";
		document.getElementById("whosonfirst-tutorial-form-max-longitude").classList.add("whosonfirst-error-messaging-tutorial");
		return;
	} else if (!search_min_longtitude) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-min-longitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-min-longitude").placeholder = "Missing minimum longitude";
		document.getElementById("whosonfirst-tutorial-form-min-longitude").classList.add("whosonfirst-error-messaging-tutorial");
		return;
	} else if (!search_max_latitude) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-max-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-max-latitude").placeholder = "Missing maximum latitude";
		document.getElementById("whosonfirst-tutorial-form-max-latitude").classList.add("whosonfirst-error-messaging-tutorial");
		return;
	} else if (!search_min_latitude) {
		console.log("Something went wrong");
		document.getElementById("whosonfirst-tutorial-form-min-latitude").value = null;
		document.getElementById("whosonfirst-tutorial-form-min-latitude").placeholder = "Missing minimum latitude";
		document.getElementById("whosonfirst-tutorial-form-min-latitude").classList.add("whosonfirst-error-messaging-tutorial");
		return;
	}
	
	document.getElementById("whosonfirst-tutorial-form-max-latitude").placeholder = "11.1243";
	document.getElementById("whosonfirst-tutorial-form-max-longitude").placeholder = "11.1243";
	document.getElementById("whosonfirst-tutorial-form-min-latitude").placeholder = "11.1243";
	document.getElementById("whosonfirst-tutorial-form-min-longitude").placeholder = "11.1243";
	if (document.getElementById("whosonfirst-tutorial-form-max-latitude").classList.contains("whosonfirst-error-messaging-tutorial")) {
		document.getElementById("whosonfirst-tutorial-form-max-latitude").classList.remove("whosonfirst-error-messaging-tutorial");
	};
	if (document.getElementById("whosonfirst-tutorial-form-max-longitude").classList.contains("whosonfirst-error-messaging-tutorial")) {
		document.getElementById("whosonfirst-tutorial-form-max-longitude").classList.remove("whosonfirst-error-messaging-tutorial");
	};
	if (document.getElementById("whosonfirst-tutorial-form-min-latitude").classList.contains("whosonfirst-error-messaging-tutorial")) {
		document.getElementById("whosonfirst-tutorial-form-min-latitude").classList.remove("whosonfirst-error-messaging-tutorial");
	};
	if (document.getElementById("whosonfirst-tutorial-form-min-longitude").classList.contains("whosonfirst-error-messaging-tutorial")) {
		document.getElementById("whosonfirst-tutorial-form-min-longitude").classList.remove("whosonfirst-error-messaging-tutorial");
	};

	console.log("Search Terms: max" + search_max_latitude + "min" + search_min_latitude + "max" + search_max_longtitude + "min" + search_min_longtitude);
	
    var method = 'whosonfirst.places.getIntersects';
    var data = {
        max_latitude: search_max_latitude,
		min_latitude: search_min_latitude,
		max_longitude: search_max_longtitude,
		min_longitude: search_min_longtitude,
        per_page: 100,
        extras: 'geom:,mz:' // this gets us lat/lng coords
    };
	var new_latitude = ((search_max_latitude-search_min_latitude)/2);
	var new_longitude = ((search_max_longtitude-search_min_longtitude)/2);
	var new_latitudetwo = Number(search_min_latitude)+Number(new_latitude);
	var new_longitudetwo = Number(search_min_longtitude)+Number(new_longitude);
	
	console.log(data);
	map.setView([new_latitudetwo,new_longitudetwo], 12);
	
    // Ok now we actually call the API
    mapzen.whosonfirst.api.execute_method(method, data, onprogress, onerror);
	
	
	console.log("Updated Input Selections");
	
	/*Using Filderstatt where Stuttgart has an airport, id is 101761809*/
	
	var customQuery = "curl -X GET 'https://whosonfirst-api.mapzen.com/?method=whosonfirst.places.getIntersects&api_key=your-mapzen-api-key&min_latitude="+search_min_latitude +"&max_latitude="+search_max_latitude+"&min_longitude="+search_min_longtitude+"&max_longitude="+search_max_longtitude+"&extras=geom:,mz:&per_page=50'"
	if (document.getElementsByClassName("whosonfirst-tutorial-individual-code-box")[0].classList.contains("whosonfirst-api-initial-no-show")) {
		document.getElementsByClassName("whosonfirst-tutorial-individual-code-box")[0].classList.remove("whosonfirst-api-initial-no-show");
	}
	document.getElementById("tutorial-api-method").innerHTML = customQuery;
}

function scrollTo(where_to_go) {
	if (last_active_marker) {
		document.getElementById(last_active_marker).classList.remove("whosonfirst-active-answer");
	}
	var result_box_container = $('#whosonfirst-tutorial-result-box-container');
	
	result_box_container.scrollTop = 0;
	var scrollLocation = $("#"+where_to_go)
	var scrollDiv = $(scrollLocation);
	if (!scrollDiv.length) {
		return;
	}
	result_box_container.animate({ scrollTop: $('#whosonfirst-tutorial-result-box-container').scrollTop() + scrollLocation.offset().top - 80}, 'slow');
	
	if (document.getElementById(where_to_go).classList.contains("whosonfirst-active-answer")) {
		document.getElementById(where_to_go).classList.remove("whosonfirst-active-answer");
	} else {
		document.getElementById(where_to_go).classList.add("whosonfirst-active-answer");
	}
	last_active_marker = where_to_go;
	return false;
}