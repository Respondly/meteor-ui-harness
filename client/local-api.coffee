#= require ./local-api.js


###
Loads the parent suite into the tree index.
###
LOCAL.gotoParentSuite = (callback) ->
  if suite = UIHarness.suite()?.parent
    LOCAL.index.insertFromLeft(suite, callback)


###
Loads the root suite into the tree index.
###
LOCAL.gotoRootSuite = (callback) ->
  LOCAL.index.insertFromLeft(BDD.suite, callback)



###
LOCAL-STORAGE: Gets or sets the UID of the current suite.
###
LOCAL.currentSuiteUid = (value) -> LocalStorage.prop 'currentSuiteUid', value




Meteor.startup ->
  # Keep the current Suite ID up-to-date.
  Deps.autorun ->
    if currentSuite = UIHarness.suite()
      LOCAL.currentSuiteUid(currentSuite.uid())

