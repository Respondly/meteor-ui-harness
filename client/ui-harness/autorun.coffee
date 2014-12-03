console.log 'TODO: Use the AutoRun in Util'

###
Provides auto-run functionality to an object.
###
PKG.AutoRun = stampit().enclose ->
  depsHandles = []



  ###
  Safely provides [Deps.autorun] funtionality stopping the
  handle when the [autorun.reset] is called.
  @param func: The function to auto-run.
  @returns the auto-run handle.
  ###
  @autorun = (func) ->
    handle = Deps.autorun(func)
    depsHandles = depsHandles ?= []
    depsHandles.push(handle)
    handle


  ###
  Stops all auto-run handles.
  ###
  @autorun.reset = ->
    depsHandles.each (handle) -> handle?.stop?()
    depsHandles = []
    @


  # ----------------------------------------------------------------------
  return @
