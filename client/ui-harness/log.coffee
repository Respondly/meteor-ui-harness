DEFAULT_EDGE = null
DEFAULT_OFFSET = 300
DEFAULT_TAIL = true


###
The API to the log.
###
PKG.Log = stampit().enclose ->
  hash = new ReactiveHash(onlyOnChange:true)
  log = null # Main API function (defined below).
  queue = []
  NOTHING = {}


  getLogCtrl = (callback) =>
    Deps.nonreactive =>
        # The log control is not loaded within an edge.
        # Get it from the main host.
        loadInMain = =>
            ctrl = @ctrl()
            if ctrl?.type is 'c-log'
              callback?(ctrl)
            else
              @load 'c-log', size:'fill', scroll:true, => callback?(@ctrl())

        # The log control is loaded into one of the edges.
        loadInEdge = =>
            handle = @autorun =>
                if ctrl = @configure.ctrls.main?.logCtrl()
                  handle?.stop()
                  callback?(ctrl)

        # Get the control from either an edge panel, or the main canvas.
        if log.edge()? then loadInEdge() else loadInMain()


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
  @log = log = (value, options = {}) ->
    # Store the value in queue, in case this method get called again
    # before the Log Ctrl has finished loading.
    handle = new LogHandle()
    queue.push(handle)

    # Write to the handle (value writing queued internally)
    options.showUndefined ?= false
    unless value is NOTHING
      handle.write(value, options)

    # Get or load the log Ctrl.
    getLogCtrl (logCtrl) =>
        log.clear() unless log.tail()
        for handle in queue
          itemCtrl = logCtrl.write(value, options)
          handle.init(itemCtrl)
        queue = []

    # Finish up.
    return handle


  ###
  Write to the log (convenience method).
  ###
  log.write = log



  ###
  Adds a new log item with the given title.
  @param value: The title.
  @returns a [LogHandle] for future updates to the log item.
  ###
  log.title = (value) ->
    handle = log(NOTHING)
    handle.title(value)
    handle



  ###
  Adds a new log item with the given sub-title.
  @param value: The subtitle.
  @returns a [LogHandle] for future updates to the log item.
  ###
  log.subtitle = (value) ->
    handle = log(NOTHING)
    handle.subtitle(value)
    handle



  ###
  Clears the log.
  ###
  log.clear = =>
    queue = []
    @ctrl().clear() if @ctrl()?.type is 'c-log' # Clear if loaded in main host too.
    getLogCtrl (ctrl) => ctrl.clear()
    @



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
    log

  log.left = (offset = 350) -> setEdge('left', offset)
  log.top = (offset = 350) -> setEdge('top', offset)
  log.right = (offset = 350) -> setEdge('right', offset)
  log.bottom = (offset = 350) -> setEdge('bottom', offset)


  # ----------------------------------------------------------------------

  ###
  Resets the log to it's original state.
  ###
  log.reset = =>
    log.clear()
    log.offset(DEFAULT_OFFSET)
    log.tail(DEFAULT_TAIL)
    log.edge(DEFAULT_EDGE)
    if @ctrl()?.type is 'c-log'
      @unload()
      console.log 'unloaded || ', @ctrl()


  # ----------------------------------------------------------------------
  return @

