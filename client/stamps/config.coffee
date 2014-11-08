###
Handles configuring the UI harness.
###
PKG.stamps.Config = stampit().enclose ->
  config = {}


  ###
  Provides global configruation for the UIHarness.
  @param options:
            - title: The root title.
  ###
  @configure = (options = {}) ->
    config = options
    BDD.suite.name = options.title if options.title?



  # ----------------------------------------------------------------------
  return @
