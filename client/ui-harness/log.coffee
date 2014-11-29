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
  Adds a new log item.
  @param value: The value to log.
  @param options
            For an Object:
              - showFuncs:    Flag indicating whether function values are rendered.
              - invokeFuncs:  Flag indicating whether functions should be invoked to convert them to a value.
              - exclude:      The key name(s) to exclude from the output.
                              String or Array of strings.

  @returns a [LogHandle] for future updates to the log item.
  ###
  @log = log = (value, options) ->
    # initHandle (logCtrl) -> logCtrl.write(value, options)
    handle = new LogHandle()
    getLogCtrl (logCtrl) =>
        log.clear() unless log.tail()
        itemCtrl = logCtrl.write(value, options)
        handle.init(itemCtrl)
    handle



  ###
  Adds a new log item with the given title.
  @param value: The title.
  @returns a [LogHandle] for future updates to the log item.
  ###
  log.title = (value) ->
    handle = log(value)
    handle.title(value)
    handle



  ###
  Adds a new log item with the given sub-title.
  @param value: The subtitle.
  @returns a [LogHandle] for future updates to the log item.
  ###
  log.subtitle = (value) ->
    handle = log(value)
    handle.subtitle(value)
    handle



  ###
  Clears the log.
  ###
  log.clear = =>
    @ctrl().clear() if @ctrl()?.type is 'c-log' # Clear if loaded in main host too.
    getLogCtrl (ctrl) => ctrl.clear()



  # ----------------------------------------------------------------------

  ###
  Gets or sets whethe the log is tailing.
  ###
  log.tail = (value) -> hash.prop 'tail', value, default:true



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
    log.tail(DEFAULT_TAIL)




  # ----------------------------------------------------------------------
  return @

