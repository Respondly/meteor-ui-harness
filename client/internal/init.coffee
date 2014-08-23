Meteor.startup ->

  # Keep the current Suite ID up-to-date.
  Deps.autorun ->
    if currentSuite = UIHarness.suite()
      INTERNAL.currentSuiteUid(currentSuite.uid())

  # Monitor the screen size (throttled).
  elWindow = $(window)
  updateWindowSize = ->
        size =
          width:elWindow.width()
          height:elWindow.height()
        INTERNAL.windowSize(size)
  updateWindowSize = updateWindowSize.throttle(100)
  elWindow.resize (e) -> updateWindowSize()
  updateWindowSize()


