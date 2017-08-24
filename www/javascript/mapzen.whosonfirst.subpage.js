$(document).ready(function(){
	$("#bs-example-navbar-collapse-2").on("show.bs.collapse", function(){
		console.log("In here");
		document.getElementById("glyphicon-one").classList.add("glyphicon-menu-up");
		document.getElementById("glyphicon-one").classList.remove("glyphicon-menu-down");
	});
	$("#bs-example-navbar-collapse-2").on("hide.bs.collapse", function(){
		document.getElementById("glyphicon-one").classList.add("glyphicon-menu-down");
		document.getElementById("glyphicon-one").classList.remove("glyphicon-menu-up");
	});
	/*
	$(".whosonfirst-sidenav-list").mouseover(function(){
		$("body").css("overflow","hidden");
	});
	$(".whosonfirst-sidenav-list").mouseout(function(){
		$("body").css("overflow","auto");
	});
	*/
	window.addEventListener("hashchange", function() { scrollBy(0, -60) })
	
	$('h1,h2,h3,h4,h5,h6').each(function() {
		if ($(this).find('a.anchor').length !== 0) {
			$(this).attr('id',$(this).children().attr('id'));
		}
	});
});