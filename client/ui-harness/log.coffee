DEFAULT_EDGE = null
DEFAULT_OFFSET = 300


###
The API to the log.
###
PKG.Log = stampit().enclose ->
  hash = new ReactiveHash(onlyOnChange:true)
  mainCtrl = null

  getLogCtrl = (callback) =>
    Deps.nonreactive =>
      if ctrl = @configure.ctrls.main?.logCtrl()
        # The log control is loaded into one of the edges.
        callback?(ctrl)
      else
        # The log control is not loaded within an edge.
        # Get it from the main host.
        ctrl = @ctrl()
        if ctrl?.type is 'c-log'
          callback?(ctrl)
        else
          @load 'c-log', size:'fill', scroll:true, => callback?(@ctrl())


  # ----------------------------------------------------------------------


  ###
  Logs a value for debugging.
  ###
  @log = log = (value) -> getLogCtrl (ctrl) => ctrl.log(value)



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


  # ----------------------------------------------------------------------

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
  log.json = (value, options) =>
    getLogCtrl (ctrl) => ctrl.logJson(value, options)



  ###
  Clears the log.
  ###
  log.clear = -> getLogCtrl (ctrl) => ctrl.clear()


  # ----------------------------------------------------------------------
  return @

