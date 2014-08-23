#= base


###
Base class for controllers of the various
different spec types (eg. "it.boolean")
###
class INTERNAL.SpecTypeBase extends AutoRun
  constructor: (@specCtrl) ->
    super

    # Store state.
    @spec = @specCtrl.context.data
    @meta = @spec.meta
    @propName = @meta.propName

    # Listen for when the Ctrl is ready.
    @specCtrl.onReady =>
      @ready()
      handle = @autorun =>
        if ctrl = UIHarness.ctrl()
          handle?.stop()
          @onCtrlLoaded(ctrl)



  ###
  Invoked when the spec control is ready.
  ###
  onReady: -> # No-op.


  ###
  Invoked once when the hosted control is loaded.
  ###
  onCtrlLoaded: (ctrl) -> # No-op.


  ###
  Invoked when the spec is run.
  ###
  onRun: -> # No-op.


  ###
  Attempts to write to the prop with the given value.
  ###
  setProp: (value) ->
    propName = @propName
    if ctrl = UIHarness.ctrl()
      if value isnt undefined
        if Object.isFunction(ctrl[propName])
          ctrl[propName](value)


