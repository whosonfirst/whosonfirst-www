'use strict'

// PRODUCT PAGE - DEMO SECTION
// --------------------------------------------------------

function setDemoContainerHeight () {
  var viewportHeight = document.documentElement.clientHeight
  var demoContainerEl = document.getElementById('demo')
  var minHeight = 600
  var maxHeightPercentage = 0.6
  // On small width screens, demo is always a percentage of the screen height
  if (document.documentElement.clientWidth < 768 || (document.documentElement.clientHeight < 850 && document.documentElement.clientWidth > 750)) {
    maxHeightPercentage = 0.6
    demoContainerEl.style.height = Math.floor(maxHeightPercentage * viewportHeight) + 'px'
  } else {
    demoContainerEl.style.height = Math.max(minHeight, Math.floor(maxHeightPercentage * viewportHeight)) + 'px'
  }
}

function setMapExplanation() {
    if (document.documentElement.clientWidth > 768) {
        document.getElementById("map-explanation-revised").style.display = "none"
        document.getElementById("map-explanation-thirds").style.display = "inline"
    } else {
        document.getElementById("map-explanation-thirds").style.display = "none"
        document.getElementById("map-explanation-revised").style.display = "block"
    }
}

// Set demo height
document.getElementsByClassName("section-nav")[0].style.display = "block"
document.getElementsByClassName("demo-container")[0].style.display = "block"
document.getElementById("map-explanation-revised").style.display = "block"
setDemoContainerHeight()
setMapExplanation()
window.addEventListener('resize', setDemoContainerHeight)
window.addEventListener('resize', setMapExplanation)

// PRODUCT NAVIGATION
// --------------------------------------------------------

// makes global for debug reasons
var productNav = new SectionNavigation('#project-nav', {
  sectionSelector: '.project-content h2, .js-section-navigable'
})