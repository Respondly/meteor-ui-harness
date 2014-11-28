DEFAULT_EDGE = null
DEFAULT_OFFSET = 300
DEFAULT_TAIL = true


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
  @param value: The value to log.
  @param options
            For an Object:
              - showFuncs:    Flag indicating whether function values are rendered.
              - invokeFuncs:  Flag indicating whether functions should be invoked to convert them to a value.
              - exclude:      The key name(s) to exclude from the output.
                              String or Array of strings.

  ###
  @log = log = (value, options) ->
    handle = new LogHandle()

    getLogCtrl (logCtrl) =>
      itemCtrl = logCtrl.write(value, options)
      handle.init(itemCtrl)

    handle



  ###
  Clears the log.
  ###
  log.clear = =>
    @ctrl().clear() if @ctrl()?.type is 'c-log' # Clear if loaded in main host too.
    getLogCtrl (ctrl) => ctrl.clear()



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

  # Edge methods.
  setEdge = (edge, offset) ->
    log.edge(edge)
    log.offset(offset)

  log.left = (offset = 350) -> setEdge('left', offset)
  log.top = (offset = 350) -> setEdge('top', offset)
  log.right = (offset = 350) -> setEdge('right', offset)
  log.bottom = (offset = 350) -> setEdge('bottom', offset)


  # ----------------------------------------------------------------------

  ###
  Resets the log to it's original state.
  ###
  log.reset = =>
    log.edge(DEFAULT_EDGE)
    log.offset(DEFAULT_OFFSET)




  # ----------------------------------------------------------------------
  return @

