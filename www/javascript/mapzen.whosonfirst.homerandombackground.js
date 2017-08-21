window.onload = chooseBackground;

var backgroundImages = new Array(["images/berlinvenuevisualization.png","curl -X GET 'https://whosonfirst-api.mapzen.com/?method=whosonfirst.places.getDescendants&api_key=your-mapzen-api-key&id=85899637&extras=geom:'","venues in Berlin"],["images/nycvenuevisualization.png","curl -X GET 'https://whosonfirst-api.mapzen.com/?method=whosonfirst.places.getDescendants&api_key=your-mapzen-api-key&id=85869245&extras=geom:'","venues in New York City"],["images/seoulneighborhoodvisualization.png","curl -X GET 'https://whosonfirst-api.mapzen.com/?method=whosonfirst.places.getDescendants&api_key=your-mapzen-api-key&id=102026327&extras=geom:,mz:uri'","neighbourhoods in Seoul"],["images/sfneighborhoodvisualization.png","curl -X GET 'https://whosonfirst-api.mapzen.com/?method=whosonfirst.places.getDescendants&api_key=your-mapzen-api-key&id=85922583&extras=geom:,mz:uri'","neighbourhoods in San Francisco"]);

function chooseBackground() {
	var randomNum = Math.floor(Math.random() * backgroundImages.length);
	document.getElementById("chosen-background-image").src = backgroundImages[randomNum][0];
	console.log(backgroundImages[randomNum][1]);
	document.getElementById("whosonfirst-card-map-code-content").innerHTML = backgroundImages[randomNum][1];
	document.getElementById("whosonfirst-custom-card-map-explanation-content").innerHTML = backgroundImages[randomNum][2];
}