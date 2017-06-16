// Add a Mapzen API key
// To generate your key, go to https://mapzen.com/developers/
var api_key = 'mapzen-aetZmeQ';
// Add a map to the 'map' div
var nyclocation = [40.74315,-73.990481,85869245,17]
var sflocation = [37.787019,-122.40007,85887417,17]
var berlinlocation = [52.513351,13.388243,85899637,15]
var mumbailocation = [19.10074,72.858075,102030609,12]
var seoullocation = [25.066207,121.548109,102026641,13]
var locationOptions = [nyclocation,sflocation,berlinlocation,mumbailocation,seoullocation]
var randomLocation = locationOptions[Math.floor(Math.random()*5)];

var map = L.Mapzen.map('map', {
    maxZoom: randomLocation[3],
    scrollWheelZoom: false,
    tangramOptions: {
        scene: {
            import: [
                'https://mapzen.com/carto/refill-style/7.1/refill-style.zip',
                'https://mapzen.com/carto/refill-style/7.1/themes/high-contrast.zip'],
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
    "color": "#ff4947",
    "weight": 1,
    "opacity": 1,
    "radius": 5,
    "fillColor": "#ff4947",
    "fillOpacity": 0.7
};

// How we should handle each API result
var show_venue = function(place) {
    var marker = L.circleMarker({
        lat: place['geom:latitude'],
        lng: place['geom:longitude']
    }, markerStyle);
    marker.bindPopup(place['wof:name']);
    map.addLayer(marker);
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
};