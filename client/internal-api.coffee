#= require ./internal-api.js


###
Loads the parent suite into the tree index.
###
TH.gotoParentSuite = (callback) ->
  if suite = TestHarness.suite()?.parent
    TH.index.insertFromLeft(suite, callback)



###
LOCAL-STORAGE: Gets or sets the UID of the current suite.
###
TH.currentSuiteUid = (value) -> LocalStorage.prop 'currentSuiteUid', value




Meteor.startup ->
  Deps.autorun ->
    if currentSuite = TestHarness.suite()
      TH.currentSuiteUid(currentSuite.uid())

