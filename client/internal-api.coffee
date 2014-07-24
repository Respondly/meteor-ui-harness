#= require ./internal-api.js


###
Loads the parent suite into the tree index.
###
TH.gotoParentSuite = (callback) ->
  if suite = TestHarness.suite()?.parent
    TH.index.insertFromLeft(suite, callback)


###
Loads the root suite into the tree index.
###
TH.gotoRootSuite = (callback) ->
  TH.index.insertFromLeft(BDD.suite, callback)



###
LOCAL-STORAGE: Gets or sets the UID of the current suite.
###
TH.currentSuiteUid = (value) -> LocalStorage.prop 'currentSuiteUid', value




Meteor.startup ->
  # Keep the current Suite ID up-to-date.
  Deps.autorun ->
    if currentSuite = TestHarness.suite()
      TH.currentSuiteUid(currentSuite.uid())

