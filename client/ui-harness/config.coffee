###
Handles configuring the UI harness.
###
PKG.Config = stampit().enclose ->
  ###
  Provides global configruation for the UIHarness.
  @param options:
            - title: The root title.
  ###
  @configure = (options = {}) ->
    BDD.suite.name = options.title if options.title?


  @configure.ctrls = {}



  # ----------------------------------------------------------------------
  return @
