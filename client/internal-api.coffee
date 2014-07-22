#= require ./internal-api.js


###
Loads the parent suite into the tree index.
###
TH.gotoParentSuite = (callback) ->
  if suite = TestHarness.suite()?.parent
    TH.index.insertFromLeft(suite, callback)
