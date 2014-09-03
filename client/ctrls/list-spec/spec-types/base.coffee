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



  ###
  Converts label values into common formats, for null/false/undefined/empty-string.
  @param label: The label to convert.
  ###
  formatLabel: (label) ->
    label = 'null' if label is null
    label = 'undefined' if label is undefined
    label = '<empty>' if label is ''
    label = 'false' if label is false
    label



  ###
  Converts a value to it's raw type if necessary.
  @param value: The value to examine and convert.
  ###
  formatValue: (value) ->
    value = value.toNumber() if Util.isNumeric(value)
    value = null if value is 'null'
    value = true if value is 'true'
    value = false if value is 'false'
    value







