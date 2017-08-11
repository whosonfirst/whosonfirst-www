// Add a Mapzen API key
// To generate your key, go to https://mapzen.com/developers/
var api_key = 'mapzen-aetZmeQ';
// Add a map to the 'map' div
var nyclocation = [40.74145,-73.988481,421205771,14,"New York's Flatiron District neighborhood"]
var sflocation = [37.795492,-122.406569,85810881,17,"San Francisco's Chinatown neighborhood"]
var berlinlocation = [52.513351,13.388243,85899637,14,"Berlin's Moabit neighborhood"]
var mumbailocation = [19.10074,72.888075,102030609,15,"Mumbai"]
var melbournelocation = [-37.813963,144.965188,85775095,16,"Melbourne's Museum neighborhood"]
var locationOptions = [nyclocation,sflocation,berlinlocation,mumbailocation,melbournelocation]
var randomLocation = locationOptions[3];

var map = L.Mapzen.map('map', {
    maxZoom: randomLocation[3],
    scrollWheelZoom: false,
    tangramOptions: {
        scene: {
            import: [
                'https://mapzen.com/carto/refill-style/7.1/refill-style.zip',
                'https://mapzen.com/carto/refill-style/7.1/themes/gray.zip'],
            global: {
                sdk_mapzen_api_key: api_key,
                sdk_building_extrude: 'false'
            }
        }
    }
});

var lat = randomLocation[0];
var lon = randomLocation[1];
map.setView([lat, lon], randomLocation[3]);

// Venues are shown as a green circle
var markerStyle = {
    "color": "#666",
    "weight": 1,
    "opacity": 1,
    "radius": 5,
    "fillColor": "#666",
    "fillOpacity": 0.7
};

var markerStyle2 = {
	iconUrl: '../images/wof-sq-pink.jpg'
}

// How we should handle each API result
var show_venue = function(place) {
    var marker = L.circleMarker({
        lat: place['geom:latitude'],
        lng: place['geom:longitude']
    }, markerStyle);
    marker.bindTooltip(place['wof:name']);
	var popupLocation = new L.LatLng(place['geom:latitude'],place['geom:longitude']);
	var popupContent = place['wof:name'];
	popup = new L.popup({minWidth: 0});
	popup.setContent(popupContent);
	popup.setLatLng(popupLocation);
	map.addLayer(popup);
};

// NOOP (we are using onprogress instead)
var onsuccess = function() { return; };

// Just log errors to the JS console
var onerror = function(rsp) {
    console.error(rsp);
};

// Take all the API results and show them on the map
var onprogress = function(rsp) {
    //console.log(rsp);
    for (var i = 0; i < rsp.places.length; i++) {
        var place = rsp.places[i];
        show_venue(place);
    }
	
};

function runWhosOnFirstAPI() {
    // Setup the API key
    mapzen.whosonfirst.api.set_handler('authentication', function() {
        return api_key;
    });
    // Get all the venues in the Flatiron District
    // See: https://mapzen.com/documentation/wof/methods/#whosonfirst.places.getDescendants
    var parent_id = randomLocation[2];
    var method = 'whosonfirst.places.getDescendants';
    var data = {
        id: parent_id,
        per_page: 500,
        extras: 'geom:' // this gets us lat/lng coords
    };
    // Ok now we actually call the API
    mapzen.whosonfirst.api.execute_method_paginated(method, data, onsuccess, onerror, onprogress);
    
    document.getElementById("whosFirstDescendantKey").innerHTML=randomLocation[2];
    document.getElementById("whosFirstDescendantLocation").innerHTML=randomLocation[4];
};