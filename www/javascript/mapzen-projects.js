'use strict'

// PRODUCT PAGE - DEMO SECTION
// --------------------------------------------------------

function setDemoContainerHeight () {
  var viewportHeight = document.documentElement.clientHeight
  var demoContainerEl = document.getElementById('demo')
  var minHeight = 600
  var maxHeightPercentage = 0.6
  // On small width screens, demo is always a percentage of the screen height
  if (document.documentElement.clientWidth < 768) {
    maxHeightPercentage = 0.6
    demoContainerEl.style.height = Math.floor(maxHeightPercentage * viewportHeight) + 'px'
  } else {
    demoContainerEl.style.height = Math.max(minHeight, Math.floor(maxHeightPercentage * viewportHeight)) + 'px'
  }
}

// Set demo height
setDemoContainerHeight()
window.addEventListener('resize', setDemoContainerHeight)

// PRODUCT NAVIGATION
// --------------------------------------------------------

// makes global for debug reasons
var productNav = new SectionNavigation('#project-nav', {
  sectionSelector: '.project-content h2, .js-section-navigable'
})