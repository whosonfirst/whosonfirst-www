// (c) 2015 Mapzen
//
// SECTION NAVIGATION
// UI component for navigating between
// sections on project pages
// --------------------------------------------------------
/* global jQuery */
var SectionNavigation = (function ($) {
  'use strict'

  // Default, and configurable values
  var CSS_COMPONENT_PREFIX = 'section-nav-'
  var DEFERRED_COLLAPSE_TIMEOUT = 900 // in ms
  var SECTION_SELECTOR = '.js-section-navigable'
  var SECTION_POSITION_ADJUST = 0 // in pixels; manual adjustment of DOM position - maybe unecessary now because of extra padding in the ::before pseudo element that makes fragment identifier linking possible
  var SECTION_POSITION_BUFFER = 100 // in pixels; tweaking the scroll-to position
  var VIEWPORT_TOP_OFFSET = 20 // in pixels
  var SCROLL_TIME = 250 // Time in ms to scroll page to section
  var SPACING_BETWEEN_TITLE_AND_MENU = 10 // in pixels

  var SectionNavigation = function (selector, opts) {
    var el = document.querySelector(selector)

    this.opts = opts || {}

    this.el = el
    this.topPosition = this.el.offsetTop
    this.isFloating = false
    this.isCollapsed = false
    this.hitboxIsActive = false
    this.mustBeExpanded = false
    this.deferredCollapseTimer = null // Placeholder for setTimeout
    this.sections = [] // Placeholder for NodeList
    this.sectionPositions = [] // Placeholder for array of numbers
    this.navScrollerWidth = 150 // Placeholder for nav scroller width in pixels
    this.titleWidth = this.getTitleWidth() // Calc immediately, do not placehold

    this.initMenuItems()
    this.addEventListeners()

    window.setTimeout(function () {
      this.reflow()
    }.bind(this), 0)

    // Enable some CSS transitions only after page has completed loading.
    // This fixes browser issues where initial paint would sometimes
    // be animated, which looks out of place.
    // Make sure the timer is greater than the amount of the transition
    // time in the CSS.
    window.setTimeout(function () {
      el.classList.add('enable-animation')
    }, 300)

    // Recalculate everything when the window resizes
    window.addEventListener('resize', this.reflow.bind(this), false)

    // Reflow if document fires the 'load' event
    document.addEventListener('load', function (event) {
      this.reflow()
    }.bind(this))
  }

  SectionNavigation.prototype.reflow = function () {
    // Calculate Y positions of sections
    this.sectionPositions = this.getSectionPositions()

    // Calculate width of title element
    this.titleWidth = this.getTitleWidth()

    // Remember nav item scroller width
    this.navScrollWidth = this.getNavScrollerWidth()

    // Set maximum left position of nav item area based on title width
    this.el.querySelector('.' + CSS_COMPONENT_PREFIX + 'items').style.left = (this.titleWidth + SPACING_BETWEEN_TITLE_AND_MENU).toString() + 'px'

    // Determine state
    this.determineFloatState()
    this.determineActiveSection()
  }

  SectionNavigation.prototype.initMenuItems = function () {
    this.sections = document.querySelectorAll(this.opts.sectionSelector || SECTION_SELECTOR)
    var ul = this.el.querySelector('ul')

    var handleClickEvent = function (index) {
      return function (event) {
        event.preventDefault()
        this.clickSection(index)
      }
    }

    // Empty the ul element, if needed
    while (ul.lastChild) {
      ul.removeChild(ul.lastChild)
    }

    // Create list elements from sections
    for (var i = 0, j = this.sections.length; i < j; i++) {
      var section = this.sections[i]
      var name = section.getAttribute('data-section-name') || section.textContent || '???'
      var li = document.createElement('li')
      var a = document.createElement('a')
      li.className = CSS_COMPONENT_PREFIX + 'item'
      a.setAttribute('data-section-index', i)
      a.textContent = name
      a.href = '#' + section.id

      // The first element gets to start with the active state on
      if (i === 0) {
        li.classList.add('active')
      }

      // Bind click event
      a.addEventListener('click', handleClickEvent(i).bind(this), false)

      li.appendChild(a)
      ul.appendChild(li)

      // Remember the width of the largest menu element
      var menuItemWidth = a.getBoundingClientRect().width + 20
      if (menuItemWidth > this.navScrollerWidth) {
        this.navScrollerWidth = menuItemWidth
      }
    }

    // Add hidden element that accounts for footer area
    var hiddenLi = document.createElement('li')
    hiddenLi.className = CSS_COMPONENT_PREFIX + 'item ' + CSS_COMPONENT_PREFIX + 'item-egg'
    hiddenLi.textContent = '<3'
    ul.appendChild(hiddenLi)

    // Remember the Y position of each section
    this.sectionPositions = this.getSectionPositions()
  }

  SectionNavigation.prototype.getTitleWidth = function () {
    return this.el.querySelector('.' + CSS_COMPONENT_PREFIX + 'title').getBoundingClientRect().width
  }

  // Used when layout changes to reset nav scroller width
  SectionNavigation.prototype.getNavScrollerWidth = function () {
    var navItems = document.querySelectorAll('.' + CSS_COMPONENT_PREFIX + 'item')
    var minValue = 150
    for (var i = 0, j = navItems.length; i < j; i++) {
      var itemWidth = navItems[i].getBoundingClientRect().width + 20
      if (itemWidth > minValue) {
        minValue = itemWidth
      }
    }
    return minValue
  }

  SectionNavigation.prototype.getSectionPositions = function () {
    var positions = []
    function _getTopPositionOfElement (element) {
      if (element.getBoundingClientRect) {
        return element.getBoundingClientRect().top + ((document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop)
      }
    }
    for (var i = 0, j = this.sections.length; i < j; i++) {
      var el = this.sections[i]
      var position = _getTopPositionOfElement(el)

      // Adjust position by buffer, skip if the position is
      // the first one (hacky for demo)
      if (i !== 0) {
        position = position - SECTION_POSITION_ADJUST
      }

      // Clamp position value to zero if result is negative
      if (position < 0) {
        position = 0
      }

      positions.push(position)

      // Record the bottom edge of the last section
      if (i === j - 1) {
        if (this.opts.sectionSelector) {
          positions.push(_getTopPositionOfElement(document.querySelector('footer')))
        } else {
          positions.push(position + el.getBoundingClientRect().height)
        }
      }
    }

    return positions
  }

  SectionNavigation.prototype.addEventListeners = function () {
    var hitboxClassName = CSS_COMPONENT_PREFIX + 'hitbox'
    var hitboxEl = document.querySelector('.' + hitboxClassName)

    // All the elements that act as hitboxes for the purpose of
    // interacting with the product navigation bar
    hitboxEl.addEventListener('mouseover', onMouseEntersHitboxArea.bind(this), false)
    hitboxEl.addEventListener('mouseout', onMouseLeavesHitboxArea.bind(this), false)
    this.el.addEventListener('mouseover', onMouseEntersHitboxArea.bind(this), false)
    this.el.addEventListener('mouseout', onMouseLeavesHitboxArea.bind(this), false)
    document.querySelector('nav').addEventListener('mouseover', onMouseEntersHitboxArea.bind(this), false)
    document.querySelector('nav').addEventListener('mouseout', onMouseLeavesHitboxArea.bind(this), false)

    window.addEventListener('mouseover', onMouseReentersWindow.bind(this))
    window.addEventListener('scroll', onScrollWindow.bind(this))

    this.el.querySelector('.' + CSS_COMPONENT_PREFIX + 'title a').addEventListener('click', onClickNavigationTitle, false)

    function onMouseLeavesHitboxArea (event) {
      this.hitboxIsActive = false
      this.el.classList.remove('hitbox-is-active')

      // Do not collapse if navbar is not floating
      if (this.isFloating === false) return

      // Do not collapse if mouse pointer exits the window
      if (event && !event.relatedTarget) return

      this.deferredCollapse()
    }

    function onMouseEntersHitboxArea (event) {
      this.hitboxIsActive = true
      this.el.classList.add('hitbox-is-active')
      this.expand()
    }

    function onMouseReentersWindow (event) {
      // Do not collapse if navbar is not floating
      if (this.isFloating === false) return

      // Collapse if mouse pointer re-enters the window
      // but outside of the hitbox area
      if (!event.relatedTarget && this.hitboxIsActive === false) {
        this.collapse()
      }
    }

    function onScrollWindow (event) {
      this.determineFloatState()
      this.determineActiveSection()
    }

    function onClickNavigationTitle (event) {
      event.preventDefault()
      document.body.classList.add('is-scrolling')
      $(window).scrollTo(0, SCROLL_TIME, {
        onAfter: function () {
          document.body.classList.remove('is-scrolling')
        }
      })
    }
  }

  SectionNavigation.prototype.expand = function () {
    clearTimeout(this.deferredCollapseTimer)
    this.isCollapsed = false

    // Remove class name to indicate state.
    // Hitbox will not be disabled here.
    this.el.classList.remove('is-collapsed')

    // Remove widths
    this.el.querySelector('.' + CSS_COMPONENT_PREFIX + 'items').style.width = ''
    this.el.querySelector('.' + CSS_COMPONENT_PREFIX + 'container').style.width = ''
  }

  SectionNavigation.prototype.collapse = function () {
    // Refuse to collapse if the hitbox area is active
    if (this.hitboxIsActive) return

    // Refuse to collapse if something else prevents it
    if (this.mustBeExpanded) return

    this.isCollapsed = true

    // Provide class name hooks to indicate state.
    // Enable hitbox when navigation is collapsed.
    this.el.classList.add('is-collapsed')

    // Set widths
    this.el.querySelector('.' + CSS_COMPONENT_PREFIX + 'items').style.width = this.navScrollerWidth.toString() + 'px'
    this.el.querySelector('.' + CSS_COMPONENT_PREFIX + 'container').style.width = (this.navScrollerWidth + this.titleWidth + SPACING_BETWEEN_TITLE_AND_MENU).toString() + 'px'
  }

  SectionNavigation.prototype.deferredCollapse = function () {
    var timer = DEFERRED_COLLAPSE_TIMEOUT || 1200

    // Set a timer to defer collapse into the future
    // This can be canceled by clearing the timer elsewhere
    this.deferredCollapseTimer = setTimeout(function () {
      if (this.deferredCollapseTimer) {
        this.collapse()
      }
    }.bind(this), timer)
  }

  SectionNavigation.prototype.float = function () {
    this.isFloating = true
    this.el.classList.add('is-floating')
    document.body.classList.add('floating-section-nav')
  }

  SectionNavigation.prototype.unfloat = function () {
    this.isFloating = false
    this.el.classList.remove('is-floating')
    document.body.classList.remove('floating-section-nav')
  }

  SectionNavigation.prototype.determineFloatState = function () {
    var windowYPosition = window.pageYOffset || (document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop

    // Set product navigation to be floating or not
    // depending on the window's current Y position
    if (windowYPosition >= (this.topPosition - VIEWPORT_TOP_OFFSET)) {
      this.float()
    } else {
      this.unfloat()
      this.expand()
    }
  }

  SectionNavigation.prototype.determineActiveSection = function () {
    var windowYPosition = window.pageYOffset || (document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop
    var sourcePositions = this.sectionPositions
    var navEl = this.el

    var positions = sourcePositions.map(function (x) {
      return x - navEl.getBoundingClientRect().bottom
    })

    if (windowYPosition < positions[0]) {
      // Assume very first section for now
      this.setSection(0)
      this.expand()
      return
    } else if (windowYPosition >= positions[positions.length - 1]) {
      // Last section
      this.setSection(positions.length - 1)
      return
    }

    for (var i = 0, j = positions.length; i < j; i++) {
      if (windowYPosition >= positions[i] && windowYPosition < positions[i + 1]) {
        this.setSection(i)

        // Depending on the section are on, set default collapse or expand state
        // TODO: Is this a thing that is here?
        if (i === 0) {
          // Demo section; force expand of navbar and disable hitbox
          this.expand()
          this.el.classList.remove('enable-hitbox')
          this.mustBeExpanded = true
        } else if (!this.isCollapsed) {
          this.collapse()
          this.el.classList.add('enable-hitbox')
          this.mustBeExpanded = false
        }

        return
      }
    }
  }

  SectionNavigation.prototype.setSection = function (sectionIndex) {
    var listEls = this.el.querySelectorAll('li')
    var el = listEls[sectionIndex]
    var listScrollPosition = sectionIndex * this.el.offsetHeight

    // Remove active class on all list elements
    for (var i = 0, j = listEls.length; i < j; i++) {
      listEls[i].classList.remove('active')
    }

    // Set new section to active state
    el.classList.add('active')

    // Set list container scroll position for nav in collapsed state
    el.parentNode.style.top = '-' + listScrollPosition.toString() + 'px'
  }

  SectionNavigation.prototype.clickSection = function (sectionIndex) {
    var listEls = this.el.querySelectorAll('li')
    var el = listEls[sectionIndex]
    var navEl = this.el
    var position

    // Scroll-to position is modified based on current position of the navbar
    // No buffer for the first position (hacky for demo)
    if (sectionIndex === 0  && document.querySelector('.navbar') != null) {
        console.log("Bounding Client Rectangle" + document.querySelector('.navbar'))
      position = this.sectionPositions[sectionIndex] - document.querySelector('.navbar').getBoundingClientRect().bottom
    } else {
      position = this.sectionPositions[sectionIndex] - navEl.getBoundingClientRect().bottom + SECTION_POSITION_BUFFER
    }

    // Indicate that page is being mechanically scrolled
    document.body.classList.add('is-scrolling')

    // Indicate which section is being scrolled to
    for (var i = 0, j = listEls.length; i < j; i++) {
      listEls[i].classList.remove('activated')
    }
    el.classList.add('activated')

    $(window).scrollTo(position, SCROLL_TIME, {
      onAfter: function () {
        // Ensure this is cleaned up only after scroll execution completes
        window.setTimeout(function () {
          el.classList.remove('activated')

          // Ensure that sticky nav does not interfere
          document.body.classList.remove('is-scrolling')
        }, SCROLL_TIME)
      }
    })
  }

  return SectionNavigation
})(jQuery)