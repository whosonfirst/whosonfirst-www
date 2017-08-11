// Add a Mapzen API key
// To generate your key, go to https://mapzen.com/developers/
var api_key = 'mapzen-aetZmeQ';
// Add a map to the 'map' div
var nyclocation = [40.74145,-73.988481,421205771,14,"New York's Flatiron District neighborhood"]
var sflocation = [37.795492,-122.406569,85810881,17,"San Francisco's Chinatown neighborhood"]
var berlinlocation = [52.513351,13.388243,85899637,14,"Berlin's Moabit neighborhood"]
var mumbailocation = [19.10074,72.888075,102030609,15,"Mumbai"]
var melbournelocation = [-37.813963,144.965188,85775095,16,"Melbourne's Museum neighborhood"]
var uslocation = [32.921921,-89.687118,85688579,8,"US"]
var locationOptions = [nyclocation,sflocation,berlinlocation,mumbailocation,melbournelocation,uslocation]
var randomLocation = locationOptions[4];

var map = L.Mapzen.map('map', {
    maxZoom: randomLocation[3],
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

var lat = randomLocation[0];
var lon = randomLocation[1];
map.setView([lat, lon], randomLocation[3]);
var locator = L.Mapzen.locator();
locator.setPosition('bottomright');
locator.addTo(map);