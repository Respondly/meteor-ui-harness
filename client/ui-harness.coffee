#= require ./ns.client.js
#= require ./log
@expect = chai.expect


hash = new ReactiveHash() # Internal hash.
LOREM = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
LOREM_WORDS = LOREM.split(' ')
depsHandles = []


# ----------------------------------------------------------------------



###
Root API for the [UIHarness]
###
class Ctrls.UIHarness
  constructor: ->
    @__internal =
      timers:[]
      hash: new ReactiveHash()
    @hash = new ReactiveHash() # Hash used by specs.
    @log = INTERNAL.log


  ###
  Gets or sets the value for the given key.
  @param key:         The unique identifier of the value (this is prefixed with the namespace).
  @param value:       (optional). The value to set (pass null to remove).
  @param options:
            default:  (optional). The default value to return if the session does not contain the value (ie. undefined).
            onlyOnChange:  (optional). Will only call set if the value has changed.
                                           Default is set by the [defaultOnlySetIfChanged] property.
  ###
  prop: (key, value, options) -> @hash.prop(key, value, options)


  ###
  Provides global configruation for the UIHarness.
  @param options:
            - title: The root title.
  ###
  configure: (options = {}) ->
    BDD.suite.name = options.title if options.title?


  ###
  REACTIVE Gets or sets the current [Suite].
  ###
  suite: (value) -> @__internal.hash.prop 'suite', value, default:null


  ###
  REACTIVE Retrieves the element for the content that is currently under test.
  @param value: (optional)
            - Nothing: READ.
            - String: READ with selector.
            - jQuery element: WRITE.
  ###
  el: (value) ->
    selector = ''
    if Object.isString(value)
      selector = value
      value = undefined
    result = @__internal.hash.prop 'el', value, default:null
    if Util.isBlank(selector) then result else result.find(selector)


  ###
  REACTIVE Retrieves the Ctrl that is currently under test (if exists).
  ###
  ctrl: (value) -> @__internal.hash.prop 'ctrl', value, default:null


  ###
  REACTIVE Gets or sets the object used as the API for spec-types.

    eg. describe.boolean 'isEnabled', ->

  Set this when you want to store values against a specific object other
  than the loaded control, for example a [ReactiveHash].

  ###
  api: (value) -> @__internal.hash.prop 'api', value, default:null


  ###
  REACTIVE Gets or sets the display title shown in the header of the Harness
  ###
  title: (value) -> @__internal.hash.prop 'title', value, default:null


  ###
  REACTIVE Gets or sets the display sub-title shown in the header of the Harness
  ###
  subtitle: (value) -> @__internal.hash.prop 'subtitle', value, default:null


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

            - args:       Arguments to pass to the content/ctrl/template.
  ###
  load: (content, options, callback) ->
    hostCtrl = @__internal.mainHostCtrl
    hostCtrl.load content, options, =>
        # Update current state.
        @el(hostCtrl.elContent())
        @ctrl(hostCtrl.currentCtrl())
        callback?()



  ###
  Removes the hosted control.
  ###
  unload: ->
    @__internal.mainHostCtrl.clear()
    @el(null)
    @ctrl(null)


  ###
  Resets the UIHarness to it's default state.
  ###
  reset: ->
    @title(null)
    @subtitle(null)
    @scroll(false)
    @api(null)
    @hash.clear()
    @stopTimers()
    @__internal.mainHostCtrl.reset()
    depsHandles.each (handle) -> handle?.stop?()
    depsHandles = []


  ###
  Safely provides [Deps.autorun] funtionality stopping the
  handle when the UI-Harness is reset.
  @param func: The function to monitor.
  ###
  autorun: (func) ->
    handle = Deps.autorun(func)
    depsHandles = depsHandles ?= []
    depsHandles.push(handle)
    handle



  ###
  Updates the visual state of the test-harness.
  ###
  updateState: -> @__internal.mainHostCtrl.updateState()


  ###
  Gets or sets the size of the hosted controls
  @param value: String
           - 'width,height', eg: '20,30', [20,30], (30,40)
           - 'fill'
           - 'auto' (default)
  ###
  size: (value...) ->
    value = undefined if value.length is 0
    @__internal.mainHostCtrl.size(value)


  ###
  Gets or sets the scroll behavior of the host.
  @param value:
            - boolean (value for X and Y)
            - {x:boolean, y:boolean}
  ###
  scroll: (value...) ->
    value = undefined if value.length is 0
    @__internal.mainHostCtrl.scroll(value)



  ###
  Gets or sets the alignment of the hosted control.
  @param value: String - {x:y}
           - 'center,middle' (default)
           - x: left|center|right
           - y: top|middle|bottom
  ###
  align: (value) -> @__internal.mainHostCtrl.align(value)


  ###
  Gets or sets the margin around the content.
  Relevant when 'size' is set to 'fill'.
  @param value: String - {left|top|right|bottom}
  ###
  margin: (value) -> @__internal.mainHostCtrl.margin(value)



  ###
  Provides a convenient way of setting a timeout.

  @param msecs:  The milliseconds to delay.
  @param func:   The function to invoke.

  @returns  The timer handle.
            Use the [stop] method to cancel the timer.
  ###
  delay: (msecs, func) ->
    timer = Util.delay(msecs, func)
    @__internal.timers.push(timer)


  ###
  Stops any timers that have been started.
  ###
  stopTimers: ->
    timer.stop() for timer in @__internal.timers
    @__internal.timers = []



  ###
  Generates a string of Lorem Ipsum
  @param options: The number of words, or an object:
                    - words:        The total number of words to return.
                                    Default: 30
                    - random:       Flag indicating if the string should be generated from
                                    a random starting place.
                                    Default:true
                    - period:       Flag indicating if the string should end
                                    in a period (.)
                                    Default:true
                    - capitalize:   Flag indicating if the result should
                                    start with a capital letter.
                                    Default:true
  ###
  lorem: (options) ->
    # Setup initial conditions.
    options = { words:(options ? 30) } unless Object.isObject(options)
    options.period      = true unless options.period?
    options.capitalize  = true unless options.capitalize?
    options.random      = true unless options.random?

    # Prepare a specific number of words.
    result = []
    index = switch options.random
              when true then Number.random(0, LOREM_WORDS.length - 1)
              when false then 0

    for i in [0..(options.words - 1)]
      result.push(LOREM_WORDS[index])
      index += 1
      index = 0 if index > LOREM_WORDS.length
    result = result.join(' ')

    # Format result.
    result = result.remove /,$/
    result = result.remove /.$/
    result = result.trim()
    result += '.' if options.period is true
    if options.capitalize is true and result.length > 1
      result = "#{ result[0].capitalize() }#{ result.substring(1, result.length) }"

    # Finish up.
    result


  ###
  Retrieves the computed CSS style on the given element.
  @param el:    The element to examine.
  @param prop:  The name of the property/attribute.
  @returns string.
  ###
  getStyle: (el, prop) ->
    return unless el
    el = el[0] if el.jquery
    window.getComputedStyle(el, null).getPropertyValue(prop)



# EXPORT ----------------------------------------------------------------------


UIHarness = new Ctrls.UIHarness()

