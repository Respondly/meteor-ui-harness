#= require ../ns.js

###
Internal API for shared functions and state.
###

INTERNAL.hash = hash = new ReactiveHash()


###
REACTIVE: Gets or sets the [Suite] or [Spec] list-item control
          that the mouse is currently over.
###
INTERNAL.hoveredListItemCtrl = (value) -> hash.prop 'hoveredListItemCtrl', value, onlyOnChange:true



###
REACTIVE: Gets or sets whether the UIHarness has completed
          it's initial load sequence.
###
INTERNAL.isInitialized = (value) -> hash.prop 'isInitialized', value, onlyOnChange:true, default:false



###
REACTIVE: Gets or sets the screen dimensions.
###
INTERNAL.windowSize = (value) -> hash.prop 'windowSize', value


###
Loads the parent suite into the tree index.
###
INTERNAL.gotoParentSuite = (callback) ->
  if suite = UIHarness.suite()?.parent
    INTERNAL.index.insertFromLeft(suite, callback)


###
Loads the root suite into the tree index.
###
INTERNAL.gotoRootSuite = (callback) ->
  INTERNAL.index.insertFromLeft(BDD.suite, callback)



###
LOCAL-STORAGE: Gets or sets the UID of the current suite.
###
INTERNAL.currentSuiteUid = (value) -> LocalStorage.prop 'currentSuiteUid', value



###
REACTIVE: Gets the current title/sub-title text for the header.
          This is set either from:

            1. Calling UIHarness.title(value)

            2. Setting @title within a describe block:

                describe 'suite', ->
                  @title('My Title')

###
INTERNAL.headerText = ->
  asValue = (value) ->
      value = value.call(UIHarness) if Object.isFunction(value)
      value

  getText = (prop) ->
        # Retrieve reactive values.
        viaProp   = UIHarness[prop]()
        viaBefore = UIHarness.suite()?.uiHarness?[prop]

        # Explicitly set title values on [UIHarness].
        if viaProp?
          return asValue(viaProp)

        # Fall back to the @title(...) value set within the "describe" function.
        if viaBefore?
          return asValue(viaBefore)

  result =
    title:    getText('title')
    subtitle: getText('subtitle')



# ----------------------------------------------------------------------



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


