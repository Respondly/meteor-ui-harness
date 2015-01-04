PKG.title = 'UIHarness'


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
    PKG.title = options.title if Object.isString(options.title)


  @configure.ctrls = {}



  # ----------------------------------------------------------------------
  return @
