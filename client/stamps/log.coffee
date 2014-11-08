PKG.stamps.Log = stampit().enclose ->
  ###
  Logs a value for debugging.
  ###
  @log = (value) ->
    if Util.isObject(value)
      @log.json(value)
    else
      console.log value




  ###
  Loads a visual object.
  @param value: The object to load.
  @param options:
            - showFuncs:    Flag indicating whether function values are rendered.
            - invokeFuncs:  Flag indicating whether functions should be invoked to convert them to a value.
            - exclude:      The key name(s) to exclude from the output.
                            String or Array of strings.
  ###
  @log.json = (value, options = {}) =>
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

