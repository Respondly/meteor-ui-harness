###
Methods for loading controls in the UIHarness host.
###
PKG.CtrlHost = stampit().enclose ->
  hash = new ReactiveHash(onlyOnChange:true)

  hostCtrl = =>
    ctrl = @configure.ctrls.host
    if not ctrl?
      throw new Error('The [uih-host] has not been initialized. Ensure it is set on [harness.configure.ctrls.host]')
    ctrl


  # ----------------------------------------------------------------------


  ###
  Resets the host control.
  ###
  @reset.hostCtrl = =>
    @title(null)
    @title.hr(true)
    @subtitle(null)
    @scroll(false)
    @api(null)
    hostCtrl()?.reset()


  # ----------------------------------------------------------------------


  ###
  REACTIVE Gets or sets the current [Suite].
  ###
  @suite = (value) -> hash.prop 'suite', value, default:null


  ###
  REACTIVE Gets or sets the object used as the API for spec-types.

    eg. describe.boolean 'isEnabled', ->

  Set this when you want to store values against a specific object other
  than the loaded control, for example a [ReactiveHash].

  ###
  @api = (value) -> hash.prop 'api', value, default:null


  ###
  REACTIVE Gets or sets the display title shown in the header of the Harness
  ###
  @title = (value) -> hash.prop 'title', value, default:null


  ###
  REACTIVE Gets or sets whether the horizontal rule under the title is displayed.
  ###
  @title.hr = (value) -> hash.prop 'hr', value, default:true


  ###
  REACTIVE Gets or sets the display sub-title shown in the header of the Harness
  ###
  @subtitle = (value) -> hash.prop 'subtitle', value, default:null


  ###
  REACTIVE Retrieves the Ctrl that is currently under test (if exists).
  ###
  @ctrl = (value) -> hash.prop 'ctrl', value, default:null


  ###
  REACTIVE Retrieves the element for the content that is currently under test.
  @param value: (optional)
            - Nothing: READ.
            - String: READ with selector.
            - jQuery element: WRITE.
  ###
  @el = (value) ->
    selector = ''
    if Object.isString(value)
      selector = value
      value = undefined
    result = hash.prop 'el', value, default:null
    if Util.isBlank(selector) then result else result.find(selector)


  ###
  Gets or sets the size of the hosted controls
  @param value: String
           - 'width,height', eg: '20,30', [20,30], (30,40)
           - 'fill'
           - 'auto' (default)
  ###
  @size = (value...) ->
    value = undefined if value.length is 0
    hostCtrl().size(value)


  ###
  Gets or sets the scroll behavior of the host.
  @param value:
            - boolean (value for X and Y)
            - {x:boolean, y:boolean}
  ###
  @scroll = (value...) ->
    value = undefined if value.length is 0
    hostCtrl().scroll(value)



  ###
  Gets or sets the alignment of the hosted control.
  @param value: String - {x:y}
           - 'center,middle' (default)
           - x: left|center|right
           - y: top|middle|bottom
  ###
  @align = (value) -> hostCtrl().align(value)


  ###
  Gets or sets the margin around the content.
  Relevant when 'size' is set to 'fill'.
  @param value: String - {left|top|right|bottom}
  ###
  @margin = (value) -> hostCtrl().margin(value)



  ###
  Gets or sets the device/version being used. Default null.
  Example:
      'iPhone:6'
      'iPhone:5s'
  ###
  @device = (value) -> hostCtrl().device(value)


  ###
  Gets or sets orientation of the device (if a device has been set).
  Values:
    - 'portrait' (default)
    - 'landscape'
  ###
  @orientation = (value) -> hostCtrl().orientation(value)



  # METHODS ----------------------------------------------------------------------


  ###
  Inserts a visual element into the [Host].
  @param content: The control to insert. Can be:
                  - Ctrl (definition)
                  - Ctrl (instance)
                  - DOM element
                  - jQuery element
                  - String (HTML)
  @param options:
            - size:       The size of the control:
                             - 'width,height', eg: '20,30', 'auto,30'
                             - 'fill'
                             - 'auto' (default)

            - align:      How to align the control within the host (x:y):
                             - 'center,middle' (default)
                             - x: left|center|right
                             - y: top|middle|bottom


            - margin:     The margin to place around the hosted control
                          when the size is set to 'fill'.
                             String: {left|top|right|bottom}

            - cssClass:   A CSS class to apply to the container element.

            - background: (alias 'bg').  The background color.
                          - Number: 0..1 to represent an alpha value of black.
                          - String: A CSS color value.

            - args:       Arguments to pass to the content/ctrl/template.
  ###
  @load = (content, options, callback) ->
    if Object.isFunction(options) and not callback?
      callback = options
      options = {}

    options ?= {}
    @style.background(options.background ? options.bg ? null)

    ctrl = hostCtrl()
    ctrl.load content, options, =>
        # Update current state.
        @el(ctrl.elContent())
        @ctrl(ctrl.currentCtrl())
        callback?()


  ###
  Removes the hosted control.
  ###
  @unload = ->
    hostCtrl().unload()
    @el(null)
    @ctrl(null)



  ###
  Updates the visual state of the test-harness.
  ###
  @updateState = -> hostCtrl().updateState()


  # ----------------------------------------------------------------------
  return @



