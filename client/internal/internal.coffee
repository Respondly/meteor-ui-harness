#= require ./ns.js

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
REACTIVE: The current display title.
###
INTERNAL.displayTitle = ->
  # Retrieve reactive values.
  viaProp   = UIHarness.title()
  viaBefore = UIHarness.suite()?.uiHarness?.title

  # Explicitly set property values on UIHarness used first.
  if viaProp?
    return Util.asValue(viaProp)

  # Fall back to the @title value set within the "describe" statement.
  if viaBefore?
    return Util.asValue(viaBefore)



# ----------------------------------------------------------------------



Meteor.startup ->
  # Keep the current Suite ID up-to-date.
  Deps.autorun ->
    if currentSuite = UIHarness.suite()
      INTERNAL.currentSuiteUid(currentSuite.uid())

