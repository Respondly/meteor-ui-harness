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

    # Listen for when the [Ctrl] is ready.
    @specCtrl.onReady =>
      @ready()
      handle = @autorun =>
        if api = UIHarness.api()
          handle?.stop()
          @onLoaded()

        if ctrl = UIHarness.ctrl()
          handle?.stop()
          @onLoaded()



  ###
  Invoked once when the hosted control is loaded.
  ###
  onLoaded: (ctrl) -> # No-op.


  ###
  Invoked when the spec is run.
  ###
  onRun: -> # No-op.


  ###
  Retrieves the object that exposes the API.
  ###
  api: ->
    propName = @propName

    if api = UIHarness.api()
      return api if Object.isFunction(api[propName])

    if ctrl = UIHarness.ctrl()
      return ctrl if Object.isFunction(ctrl[propName])



  ###
  Attempts to read/write to the property function.
  ###
  prop: (value) -> @api()?[@propName]?(value)




