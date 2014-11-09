DEFAULT_EDGE = null
DEFAULT_OFFSET = 300


###
The API to the log.
###
PKG.Log = stampit().enclose ->
  hash = new ReactiveHash(onlyOnChange:true)


  # ----------------------------------------------------------------------


  ###
  Logs a value for debugging.
  ###
  @log = log = (value) ->
    if Util.isObject(value)
      log.json(value)
    else
      console.log value


  # ----------------------------------------------------------------------


  ###
  REACTIVE: Gets or sets the edge that the log is on.
  @param value: 'left', 'top', 'right', 'bottom'
  ###
  log.edge = (value) => hash.prop 'edge', value, default:DEFAULT_EDGE


  ###
  REACTIVE: Gets or sets the pixel offset of the log
  ie. the width or height depending upon what edge the
  log is pinned to.
  ###
  log.offset = (value) -> hash.prop 'offset', value, default:DEFAULT_OFFSET



  ###
  Resets the log to it's original state.
  ###
  log.reset = =>
    log.edge(DEFAULT_EDGE)
    log.offset(DEFAULT_OFFSET)




  ###
  Loads a visual object.
  @param value: The object to load.
  @param options:
            - showFuncs:    Flag indicating whether function values are rendered.
            - invokeFuncs:  Flag indicating whether functions should be invoked to convert them to a value.
            - exclude:      The key name(s) to exclude from the output.
                            String or Array of strings.
  ###
  log.json = (value, options = {}) =>
    Deps.nonreactive =>
      return unless Util.isObject(value)
      options.showFuncs ?= true
      if ctrl = UIHarness.ctrl()
        if ctrl.type is 'c-json'
          # Set the value on existing JSON ctrl.
          ctrl.showFuncs(options.showFuncs)
          ctrl.invokeFuncs(options.invokeFuncs)
          ctrl.exclude(options.exclude ? null)
          ctrl.value(value)
          return

      # Load new JSON ctrl.
      args =
        value:        value
        showFuncs:    options.showFuncs
        invokeFuncs:  options.invokeFuncs
        exclude:      options.exclude
      UIHarness.load 'c-json', size:'fill', args:args, scroll:true


  # ----------------------------------------------------------------------
  return @

