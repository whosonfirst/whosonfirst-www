window.onload = chooseBackground;

var backgroundImages = new Array("images/berlinvenuevisualization.png","images/nycvenuevisualization.png","images/seoulneighborhoodvisualization.png","images/sfneighborhoodvisualization.png");

function chooseBackground() {
	var randomNum = Math.floor(Math.random() * backgroundImages.length);
	document.getElementById("chosen-background-image").src = backgroundImages[randomNum];
}