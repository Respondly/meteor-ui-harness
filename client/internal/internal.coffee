#= require ./internal.js
INTERNAL.hash = hash = new ReactiveHash()



###
REACTIVE: Gets or sets the [Suite] list-item
###
INTERNAL.overSuiteCtrl = (value) -> hash.prop 'overSuiteCtrl', value, onlyOnChange:true



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




Meteor.startup ->
  # Keep the current Suite ID up-to-date.
  Deps.autorun ->
    if currentSuite = UIHarness.suite()
      INTERNAL.currentSuiteUid(currentSuite.uid())

